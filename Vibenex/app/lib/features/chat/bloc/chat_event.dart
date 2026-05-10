part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
  @override
  List<Object?> get props => [];
}

class ChatLoadConversations extends ChatEvent {
  const ChatLoadConversations();
}

class ChatOpenConversation extends ChatEvent {
  final String conversationId;
  const ChatOpenConversation(this.conversationId);
  @override
  List<Object?> get props => [conversationId];
}

class ChatLoadMessages extends ChatEvent {
  final String conversationId;
  const ChatLoadMessages(this.conversationId);
  @override
  List<Object?> get props => [conversationId];
}

class ChatLoadMoreMessages extends ChatEvent {
  const ChatLoadMoreMessages();
}

class ChatSendMessage extends ChatEvent {
  final String content;
  final String? imageUrl;
  const ChatSendMessage(this.content, {this.imageUrl});
  @override
  List<Object?> get props => [content, imageUrl];
}

class ChatReceiveMessage extends ChatEvent {
  final Map<String, dynamic> message;
  const ChatReceiveMessage(this.message);
  @override
  List<Object?> get props => [message];
}

class ChatMarkRead extends ChatEvent {
  final String conversationId;
  const ChatMarkRead(this.conversationId);
  @override
  List<Object?> get props => [conversationId];
}

class ChatTypingChanged extends ChatEvent {
  final bool typing;
  const ChatTypingChanged(this.typing);
  @override
  List<Object?> get props => [typing];
}

class ChatLeaveConversation extends ChatEvent {
  const ChatLeaveConversation();
}
