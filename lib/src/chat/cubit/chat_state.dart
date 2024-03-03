part of 'chat_cubit.dart';

/// {@template chat}
/// ChatState description
/// {@endtemplate}
sealed class ChatState extends Equatable {
  /// {@macro chat}
  ///
  final List<Message> message;
  const ChatState({required this.message});

  @override
  List<Object> get props => [message];
}

/// {@template chat_initial}
/// The initial state of ChatState
/// {@endtemplate}
class ChatInitial extends ChatState {
  /// {@macro chat_initial}
  const ChatInitial() : super(message: const []);
}

class ChatLoading extends ChatState {
  const ChatLoading() : super(message: const []);
}

class ChatLoaded extends ChatState {
  const ChatLoaded({required List<Message> message}) : super(message: message);
}
