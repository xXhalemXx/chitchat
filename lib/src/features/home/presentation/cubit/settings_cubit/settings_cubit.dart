// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chitchat/src/core/constants/colors.dart';
import 'package:chitchat/src/core/constants/strings.dart';
import 'package:chitchat/src/core/helpers/shared_pref_helper.dart';
import 'package:chitchat/src/core/models/user_data.dart';
import 'package:chitchat/src/core/networking/models/user_model.dart';
import 'package:chitchat/src/core/routes/routes.dart';
import 'package:chitchat/src/core/widgets/permission_dialog.dart';
import 'package:chitchat/src/features/home/data/repo/repo.dart';
import 'package:chitchat/src/features/home/presentation/widgets/settings/edit_photo_snackbar.dart';
import 'package:chitchat/src/features/home/presentation/widgets/settings/update_data_dialog.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({required this.homeRepository}) : super(SettingsState());
  final HomeRepository homeRepository;

  final ImagePicker _picker = ImagePicker();
  navigateToProfileInfo(BuildContext context) {
    Navigator.pushNamed(context, RoutesName.userInfo);
  }

  showEditPhotoSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: EditPhotoSnackbar(),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColor.white,
        duration: Duration(days: 1),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColor.lightestGray, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  takePhoto(BuildContext context) async {
    try {
      // Request camera permission
      PermissionStatus status = await Permission.camera.request();

      if (status.isGranted) {
        final XFile? image =
            await _picker.pickImage(source: ImageSource.camera);
        if (image != null) {
          _onImageSelected(File(image.path));
        }
      } else {
        _showPermissionDialog(context, 'Camera Permission Required',
            'This app requires access to your camera to take a photo.');
      }
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    } catch (error) {
      log('Error taking photo: $error');
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      emit(state.copyWith(isLoadingPicture: false));
      // Show an error message if photo capture fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to take photo. Please try again.'),
          backgroundColor: AppColor.red,
        ),
      );
    }
  }

  selectPhotoFromGallery(BuildContext context) async {
    try {
      // Request storage permission
      PermissionStatus status = await Permission.storage.request();

      if (status.isGranted) {
        final XFile? image =
            await _picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          _onImageSelected(File(image.path));
        }
      } else {
        _showPermissionDialog(context, 'Storage Permission Required',
            'This app requires access to your storage to select a photo from the gallery.');
      }
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    } catch (error) {
      log('Error taking photo: $error');
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      emit(state.copyWith(isLoadingPicture: false));
      // Show an error message if photo capture fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to take photo. Please try again.'),
          backgroundColor: AppColor.red,
        ),
      );
    }
  }

  void _showPermissionDialog(
      BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => PermissionDialog(
          title: title,
          content: content,
          onSettings: () {
            openAppSettings();
          }),
    );
  }

  void deletePhoto(BuildContext context) async {
    try {
      emit(state.copyWith(isLoadingPicture: true));
      await homeRepository.updateUserPhoto(
        userId: UserData.currentUser!.uId,
        photoUrl: '',
      );
      _updateLocalData(photo: '');
      emit(state.copyWith(isLoadingPicture: false));
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    } catch (error) {
      log('Error deleting photo: $error');
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      emit(state.copyWith(isLoadingPicture: false));
      // Show an error message if photo deletion fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete photo. Please try again.'),
          backgroundColor: AppColor.red,
        ),
      );
    }
  }

  void _onImageSelected(File image) async {
    emit(state.copyWith(isLoadingPicture: true));
    // Crop the image
    File? croppedImage = await cropImage(image);
    if (croppedImage == null) {
      emit(state.copyWith(isLoadingPicture: false));
      return; // User cancelled cropping
    }
    String photoUrl = await homeRepository.uploadUserPhoto(
        image: croppedImage,
        fileName:
            '${UserData.currentUser?.uId}${DateTime.now().microsecondsSinceEpoch}');
    await homeRepository.updateUserPhoto(
      userId: UserData.currentUser!.uId,
      photoUrl: photoUrl,
    );
    await _updateLocalData(photo: photoUrl);
    emit(state.copyWith(isLoadingPicture: false));
  }

  Future<File?> cropImage(File image) async {
    try {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        uiSettings: [AndroidUiSettings(toolbarTitle: "Crop Image")],
      );
      return croppedFile != null ? File(croppedFile.path) : null;
    } catch (e) {
      log("Crop error: $e");
      return null;
    }
  }

  _updateLocalData({String? photo, String? name, String? bio}) async {
    UserModel user = UserData.currentUser!;
    //update user data in global class
    UserData.currentUser = user.copyWith(
      photo: photo,
      name: name,
      bio: bio,
    );
    //save user data in secure storage
    await SharedPrefHelper.setSecuredString(
        key: SharedPrefStrings.userData, value: jsonEncode(user.toJson()));
  }

  Future<void> updateName({required BuildContext context}) async {
    TextEditingController textEditingController =
        TextEditingController(text: UserData.currentUser?.name ?? '');
    emit(state.copyWith(isLoadingName: true));
    try {
      showDialog(
          context: context,
          builder: (_) => UpdateDataDialog(
              title: "Update Name",
              hintText: "Enter your new name...",
              onSave: () async {
                String newName = textEditingController.text.trim();
                if (newName.isNotEmpty) {
                  await homeRepository.updateUserName(
                    userId: UserData.currentUser!.uId,
                    name: newName,
                  );
                  await _updateLocalData(name: newName);
                  Navigator.pop(context); // Close the dialog
                }
                emit(state.copyWith(isLoadingName: false));
              },
              textEditingController: textEditingController));
    } catch (error) {
      log('Error updating name: $error');
      emit(state.copyWith(isLoadingName: false));
    }
  }

  Future<void> updateBio({required BuildContext context}) async {
    TextEditingController textEditingController =
        TextEditingController(text: UserData.currentUser?.bio ?? '');
    emit(state.copyWith(isLoadingBio: true));
    try {
      showDialog(
          context: context,
          builder: (_) => UpdateDataDialog(
              title: "Update Bio",
              hintText: "Enter your new bio...",
              onSave: () async {
                String newBio = textEditingController.text.trim();
                if (newBio.isNotEmpty) {
                  await homeRepository.updateUserBio(
                    userId: UserData.currentUser!.uId,
                    bio: newBio,
                  );
                  await _updateLocalData(bio: newBio);
                  Navigator.pop(context); // Close the dialog
                }
                emit(state.copyWith(isLoadingBio: false));
              },
              textEditingController: textEditingController));
    } catch (error) {
      log('Error updating bio: $error');
      emit(state.copyWith(isLoadingBio: false));
    }
  }
}
