import 'dart:developer';

import 'package:chitchat/src/features/home/presentation/cubit/call_cubit/call_cubit.dart';
import 'package:chitchat/src/features/home/presentation/pages/call_pages/incoming_call_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncomingCallWrapper extends StatelessWidget {
  const IncomingCallWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallCubit, CallState>(
      builder: (context, state) {
        log('is there incoming call: ${state.isThereIncomingCall}');
        return Stack(
          children: [
            child,
            Visibility(
              visible: state.isThereIncomingCall,
              child: IncomingCallPage(),
            ),
          ],
        );
      },
    );
  }
}
