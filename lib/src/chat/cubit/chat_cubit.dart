import 'dart:async';

import 'package:anime_sync/src/chat/chat.dart';
import 'package:anime_sync/src/chat/services/chat_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(const ChatInitial());
  final ChatService _service = ChatService();

  /// A description for yourCustomFunction
  FutureOr<void> sendMessage(String text, ScrollController scroll) async {
    emit(ChatLoading(message: state.message));

    final res = await _service.sendMessage(text, state.message);

    final updatedMessages = List.of(state.message);
    updatedMessages.add(Message(sender: 'User', content: text));
    updatedMessages.add(Message(sender: 'Bot', content: res));

    emit(ChatLoaded(message: updatedMessages));
    if (scroll.hasClients) {
      scroll.animateTo(scroll.position.maxScrollExtent,
          duration: const Duration(seconds: 1), curve: Curves.linear);
    }
  }
}
