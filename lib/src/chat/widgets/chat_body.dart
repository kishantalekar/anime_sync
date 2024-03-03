import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:anime_sync/core/theme/colors.dart';
import 'package:anime_sync/src/chat/cubit/cubit.dart';
import 'package:anime_sync/src/home/widgets/widgets_imports.dart';

/// {@template chat_body}
/// Body of the ChatPage.
///
/// Add what it does
/// {@endtemplate}
///

class ChatBody extends StatelessWidget {
  /// {@macro chat_body}
  ChatBody({super.key});
  final TextEditingController chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...switch (state) {
              ChatLoading() => [const LoadingIndicator()],
              ChatInitial() => [
                  const Expanded(
                      child: Center(
                    child: Text("empty"),
                  ))
                ],
              ChatLoaded() => [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return _buildMessage(state.message[index]);
                      },
                      itemCount: state.message.length,
                    ),
                  ),
                ]
            },
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: chatController,
                      decoration: const InputDecoration(
                        hintText: 'Type your message',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      if (chatController.text.isEmpty) return;

                      context
                          .read<ChatCubit>()
                          .sendMessage(chatController.text);
                    },
                  ),
                ],
              ),
            ),
            Gap(10.h),
          ],
        );
      },
    );
  }

  // _sendMessage(String text) async {
  //   if (text.isNotEmpty) {

  // }
  // }
}

Widget _buildMessage(Message message) {
  return Align(
    alignment:
        message.sender == "User" ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      padding: const EdgeInsets.all(8),
      margin: EdgeInsets.only(
          top: 6,
          bottom: 4,
          left: message.sender == "User" ? 20 : 0,
          right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: message.sender == "User"
            ? TColors.chatBgColor
            : TColors.chatBgColor,
      ),
      child: Text(message.content),
    ),
  );
}

class Message {
  final String sender;
  final String content;

  Message({required this.sender, required this.content});
}
