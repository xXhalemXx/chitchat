import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/core/networking/models/user_model.dart';
import 'package:chitchat/src/features/home/presentation/cubit/contacts_cubit/contacts_cubit.dart';
import 'package:chitchat/src/features/home/presentation/cubit/messages_cubit/messages_cubit.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/contact_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactsDetails extends StatelessWidget {
  const ContactsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsCubit, ContactsState>(builder: (context, state) {
      return ListView.builder(
          itemCount: state.allContacts.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (_, index) {
            UserModel? user = state.allContacts[index]['data'];
            return state.allContacts.isEmpty
                ? Placeholder()
                : state.allContacts[index]['char'] != '*'
                    ? Padding(
                        padding: EdgeInsets.only(left: 10.w, bottom: 10.h),
                        child: Text(state.allContacts[index]['char'],
                            style: AppTextStyles.poppinsFont16Black100Bold1),
                      )
                    : Padding(
                        padding: EdgeInsets.only(bottom: 20.0.h, left: 10.w),
                        child: SizedBox(
                          height: 52.h,
                          child: ContactInfo(
                            bio: user!.bio,
                            name: user.name,
                            userPhoto: user.photo,
                            onTap: () {
                              getIt<MessagesCubit>().navigateToChatScreen(
                                  receiver: user, context: context);
                            },
                          ),
                        ),
                      );
          });
    });
  }
}
