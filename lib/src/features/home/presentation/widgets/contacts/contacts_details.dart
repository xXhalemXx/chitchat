import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactsDetails extends StatelessWidget {
  ContactsDetails({super.key});
  final List<String> _names = [
    'Afrin Sabila',
    'Shahin Haque',
    'Mizanur Rahman',
    'ahmed khan',
    'khalid ahmed',
    'samin ahmed',
    'sami ahmed',
    'mehedi ahmed',
  ];
  List<Widget> _buildList = [];

  @override
  Widget build(BuildContext context) {
    _convertListToMap();
    return SingleChildScrollView(
      child: Column(children: _buildList),
    );
  }

  _contactEntity({
    required String character,
    required List<String> names,
  }) {
    List<Widget> _list = [];
    _list.add(
      Text(character, style: AppTextStyles.poppinsFont16Black100Bold1),
    );

    _list.add(
      verticalSpace(20.h),
    );
    for (String name in names) {
      _list.add(
        Padding(
          padding: EdgeInsets.only(bottom: 20.0.h),
          child: SizedBox(
            height: 52.h,
            child: Row(
              children: [
                _avatarImage(),
                horizontalSpace(12.w),
                _nameAndBio(name: name),
              ],
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(left: 24.0.w, bottom: 10.h, right: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _list,
      ),
    );
  }

  Widget _avatarImage() {
    return Stack(
      children: [
        Container(
          width: 52.w,
          height: 52.h,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: CircleAvatar(
            child: Image.asset('assets/images/person3.png'),
          ),
        ),
      ],
    );
  }

  Widget _nameAndBio({
    required String name,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: AppTextStyles.poppinsFont18Black100Medium1,
        ),
        verticalSpace(6.h),
        Text(
          'Life is beautiful 👌',
          style: AppTextStyles.poppinsFont12Gray50Regular1,
        )
      ],
    );
  }

  _convertListToMap() {
    Map<String, List<String>> allAlphabetWithNames = {};
    Map<String, List<String>> alphabetWithNames = {};
    int first = "a".codeUnitAt(0);
    int last = "z".codeUnitAt(0);
    while (first <= last) {
      allAlphabetWithNames
          .addAll({String.fromCharCode(first).toUpperCase(): []});
      first++;
    }
    for (String name in _names) {
      allAlphabetWithNames[name[0].toUpperCase()]?.add(name);
    }
    allAlphabetWithNames.forEach((key, value) {
      if (value.isNotEmpty) {
        alphabetWithNames.addAll({key: value});
      }
    });
    _buildList.add(verticalSpace(15.h));
    alphabetWithNames.forEach((key, value) =>
        _buildList.add(_contactEntity(character: key, names: value)));
  }
}
