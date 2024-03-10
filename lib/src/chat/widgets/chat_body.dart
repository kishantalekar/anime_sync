import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import 'package:anime_sync/core/theme/colors.dart';
import 'package:anime_sync/src/chat/cubit/cubit.dart';

/// {@template chat_body}
/// Body of the ChatPage.
///
/// Add what it does
/// {@endtemplate}
///

class ChatBody extends StatefulWidget {
  /// {@macro chat_body}
  const ChatBody({super.key});

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  final TextEditingController chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    super.dispose();
    chatController.dispose();
    _scrollController.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 1), curve: Curves.linear);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...switch (state) {
              ChatLoading() => [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return _buildMessage(state.message[index]);
                      },
                      itemCount: state.message.length,
                    ),
                  )
                ],
              ChatInitial() => [
                  const Expanded(
                      child: Center(
                    child: Text("Type something..."),
                  ))
                ],
              ChatLoaded() => [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        return _buildMessage(state.message[index]);
                      },
                      itemCount: state.message.length,
                    ),
                  ),
                ]
            },
            BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
              if (state is ChatInitial || state is ChatLoaded) {
                return ChatInputField(
                  chatController: chatController,
                  isLoading: false,
                  scrollController: _scrollController,
                );
              } else {
                return ChatInputField(
                  chatController: chatController,
                  isLoading: true,
                  scrollController: _scrollController,
                );
              }
            }),
            Gap(10.h),
          ],
        );
      },
    );
  }
}

class ChatInputField extends StatelessWidget {
  const ChatInputField(
      {super.key,
      required this.chatController,
      required this.isLoading,
      required this.scrollController});
  final ScrollController scrollController;
  final TextEditingController chatController;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          isLoading
              ? const SizedBox(
                  width: 30, height: 30, child: CircularProgressIndicator())
              : IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (chatController.text.isEmpty) return;

                    context
                        .read<ChatCubit>()
                        .sendMessage(chatController.text, scrollController);
                    chatController.clear();
                  },
                ),
        ],
      ),
    );
  }
}

Widget _buildMessage(Message message) {
  return Align(
    alignment:
        message.sender == "User" ? Alignment.centerRight : Alignment.centerLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (message.sender != "User")
          Icon(FontAwesomeIcons.robot, color: TColors.whiteColor, size: 20.sp),
        Container(
          padding: const EdgeInsets.all(8),
          margin: EdgeInsets.only(
              top: 6,
              bottom: 4,
              left: message.sender == "User" ? 20 : 0,
              right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: message.sender == "User"
                ? TColors.primaryColor
                : TColors.secondaryColor,
          ),
          child: Text(
            message.content,
            style: const TextStyle(color: TColors.whiteColor),
          ),
        ),
      ],
    ),
  );
}

class Message {
  final String sender;
  final String content;

  Message({required this.sender, required this.content});
}
