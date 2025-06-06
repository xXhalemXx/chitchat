import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/constants/assets.dart';
import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/core/networking/models/call_history_model.dart';
import 'package:chitchat/src/features/home/presentation/cubit/call_history_cubit/call_history_cubit.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/user_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CallDetails extends StatelessWidget {
  const CallDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallHistoryCubit, CallHistoryState>(
        builder: (context, state) {
      return state.callsHistory.isEmpty
          ? _noCallsYet()
          : ListView.builder(
              itemCount: state.callsHistory.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return _callsEntity(
                  index: index,
                  calls: state.callsHistory,
                );
              },
            );
    });
  }

  _noCallsYet() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No Calls yet',
            style: AppTextStyles.poppinsFont20Black100Bold1,
          ),
          SizedBox(height: 16.h),
          Text(
            'You have not made any calls yet.\nMake a call to see it here.',
            textAlign: TextAlign.center,
            style: AppTextStyles.poppinsFont16Black100Regular1,
          ),
        ],
      ),
    );
  }

  _callsEntity({required int index, required List<CallHistoryModel> calls}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: 24.0.w,
              bottom: 20.h,
              top: index == 0 ? 0.h : 20.h,
              right: 24.w),
          child: SizedBox(
            height: 52.h,
            child: Row(
              children: [
                _avatarImage(imageUrl: calls[index].userData.photo),
                horizontalSpace(12),
                _callerNameTime(call: calls[index]),
                const Spacer(),
                _endCallButton(call: calls[index]),
              ],
            ),
          ),
        ),
        _grayBar()
      ],
    );
  }

  Widget _avatarImage({required String? imageUrl}) {
    // If imageUrl is provided, use it; otherwise, use a default image.
    return Stack(
      children: [
        Container(
          width: 52.w,
          height: 52.h,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: UserCircleAvatar(size: 52, userPhoto: imageUrl),
        ),
      ],
    );
  }

  Widget _callerNameTime({required CallHistoryModel? call}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          call?.userData.name ?? 'Unknown Caller',
          style: AppTextStyles.poppinsFont18Black100Medium1,
        ),
        verticalSpace(6),
        Row(children: [
          SizedBox(
            width: 16.w,
            height: 16.h,
            child: call!.incoming
                ? call.callStatus == 2 || call.callStatus == 4
                    ? SvgPicture.asset(
                        'assets/images/svgs/missed_call.svg',
                      )
                    : SvgPicture.asset(
                        'assets/images/svgs/incoming_call.svg',
                      )
                : SvgPicture.asset(
                    'assets/images/svgs/outgoing_call.svg',
                  ),
          ),
          horizontalSpace(4),
          Text(
            getIt<CallHistoryCubit>()
                .getTimeDifference(dateAndTime: call.callTime),
            style: AppTextStyles.poppinsFont12Gray50Regular1,
          )
        ])
      ],
    );
  }

  Widget _endCallButton({required CallHistoryModel? call}) {
    return call!.callType == 'audio'
        ? SvgPicture.asset(
            Assets.assetsImagesSvgsPhone,
            width: 18.w,
            height: 18.h,
            colorFilter: ColorFilter.mode(AppColor.gray, BlendMode.srcIn),
          )
        : SvgPicture.asset(
            Assets.assetsImagesSvgsVideoCall,
            width: 24.w,
            height: 24.h,
            colorFilter: ColorFilter.mode(AppColor.gray, BlendMode.srcIn),
          );
  }

  Widget _grayBar() {
    return Padding(
      padding: EdgeInsets.only(
        left: 95.w,
      ),
      child: Container(
        width: double.infinity,
        height: 1.h,
        decoration: BoxDecoration(
          color: AppColor.lightestGray,
        ),
      ),
    );
  }
}
