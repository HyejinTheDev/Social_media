part of 'chat_bloc.dart';

enum ChatStatus { initial, loading, loaded, error }

class ChatState extends Equatable {
  final ChatStatus conversationsStatus;
  final List<dynamic> conversations;
  final ChatStatus messagesStatus;
  final List<dynamic> messages;
  final String? currentConversationId;
  final int messagesPage;
  final bool hasMoreMessages;
  final String? errorMessage;

  const ChatState({
    this.conversationsStatus = ChatStatus.initial,
    this.conversations = const [],
    this.messagesStatus = ChatStatus.initial,
    this.messages = const [],
    this.currentConversationId,
    this.messagesPage = 1,
    this.hasMoreMessages = false,
    this.errorMessage,
  });

  ChatState copyWith({
    ChatStatus? conversationsStatus,
    List<dynamic>? conversations,
    ChatStatus? messagesStatus,
    List<dynamic>? messages,
    String? currentConversationId,
    int? messagesPage,
    bool? hasMoreMessages,
    String? errorMessage,
  }) {
    return ChatState(
      conversationsStatus: conversationsStatus ?? this.conversationsStatus,
      conversations: conversations ?? this.conversations,
      messagesStatus: messagesStatus ?? this.messagesStatus,
      messages: messages ?? this.messages,
      currentConversationId: currentConversationId ?? this.currentConversationId,
      messagesPage: messagesPage ?? this.messagesPage,
      hasMoreMessages: hasMoreMessages ?? this.hasMoreMessages,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    conversationsStatus, conversations, messagesStatus, messages,
    currentConversationId, messagesPage, hasMoreMessages, errorMessage,
  ];
}
