import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/core/models/user_model.dart';
import 'package:chitchat/src/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.receiver});
  final UserModel receiver;
  final double radiusValue = 15;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      getIt<HomeCubit>().getAllMassages(
        receiver: receiver,
      );
      return BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeGetChatMassages) {
            return Flexible(
              child: ListView.builder(
                itemCount: state.allMessages.length,
                controller: getIt<HomeCubit>().scrollController,
                itemBuilder: (context, index) {
                  if (state.allMessages[index].sender ==
                      getIt<HomeCubit>().currentUser.uId) {
                    return sendedMessage(state.allMessages[index].text);
                  } else {
                    return receivedMessage(state.allMessages[index].text);
                  }
                },
              ),
            );
          } else {
            return const SizedBox(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      );
    });
  }

  Widget sendedMessage(String message) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColor.darkerBlue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusValue),
            topRight: Radius.circular(radiusValue),
            bottomLeft: Radius.circular(radiusValue),
          ),
        ),
        child: Text(
          message,
          style: AppTextStyles.poppinsFont12White100Regular1,
        ),
      ),
    );
  }

  Widget receivedMessage(String message) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColor.lightBlueWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusValue),
            topRight: Radius.circular(radiusValue),
            bottomRight: Radius.circular(radiusValue),
          ),
        ),
        child: Text(message),
      ),
    );
  }
}
