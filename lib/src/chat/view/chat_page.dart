import 'package:anime_sync/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:anime_sync/src/chat/cubit/cubit.dart';
import 'package:anime_sync/src/chat/widgets/chat_body.dart';

/// {@template chat_page}
/// A description for ChatPage
/// {@endtemplate}
class ChatPage extends StatelessWidget {
  /// {@macro chat_page}
  const ChatPage({super.key});

  /// The static route for ChatPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const ChatPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: ChatView(),

    );
  }
}

/// {@template chat_view}
/// Displays the Body of ChatView
/// {@endtemplate}
class ChatView extends StatelessWidget {
  /// {@macro chat_view}
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChatBody();
  }
}
