import 'dart:async';

import 'package:anime_sync/src/chat/chat.dart';
import 'package:anime_sync/src/chat/services/chat_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(const ChatInitial());
  final ChatService _service = ChatService();

  /// A description for yourCustomFunction
  FutureOr<void> sendMessage(String text) async {
    emit(const ChatLoading());

    final res = await _service.sendMessage(text);

    final updatedMessages = List.of(state.message);
    updatedMessages.add(Message(sender: 'User', content: text));
    updatedMessages.add(Message(sender: 'Bot', content: res));

    emit(ChatLoaded(message: updatedMessages));
  }
}
