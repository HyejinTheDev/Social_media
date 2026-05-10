import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/error_mapper.dart';
import '../data/datasources/chat_api_service.dart';
import '../data/datasources/socket_service.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatApiService _api;
  final SocketService _socket;
  StreamSubscription? _messageSubscription;

  ChatBloc({required ChatApiService api, required SocketService socket})
      : _api = api,
        _socket = socket,
        super(const ChatState()) {
    on<ChatLoadConversations>(_onLoadConversations);
    on<ChatOpenConversation>(_onOpenConversation);
    on<ChatLoadMoreMessages>(_onLoadMoreMessages);
    on<ChatSendMessage>(_onSendMessage);
    on<ChatReceiveMessage>(_onReceiveMessage);
    on<ChatMarkRead>(_onMarkRead);
    on<ChatTypingChanged>(_onTypingChanged);
    on<ChatLeaveConversation>(_onLeaveConversation);
  }

  Future<void> _onLoadConversations(ChatLoadConversations event, Emitter<ChatState> emit) async {
    emit(state.copyWith(conversationsStatus: ChatStatus.loading));
    try {
      final data = await _api.getConversations();
      emit(state.copyWith(
        conversationsStatus: ChatStatus.loaded,
        conversations: data,
      ));
    } catch (e) {
      emit(state.copyWith(conversationsStatus: ChatStatus.error, errorMessage: ErrorMapper.map(e)));
    }
  }

  Future<void> _onOpenConversation(ChatOpenConversation event, Emitter<ChatState> emit) async {
    emit(state.copyWith(messagesStatus: ChatStatus.loading, currentConversationId: event.conversationId));

    _socket.joinConversation(event.conversationId);

    // Listen for new messages
    _messageSubscription?.cancel();
    _messageSubscription = _socket.onNewMessage.listen((data) {
      if (data['conversationId'] == state.currentConversationId ||
          (data['conversation'] != null && data['conversation']['id'] == state.currentConversationId)) {
        add(ChatReceiveMessage(data));
      }
    });

    try {
      final data = await _api.getMessages(event.conversationId, 1);
      final messages = data['messages'] as List<dynamic>;
      emit(state.copyWith(
        messagesStatus: ChatStatus.loaded,
        messages: messages,
        messagesPage: 1,
        hasMoreMessages: (data['page'] as int) < (data['totalPages'] as int),
      ));
      // Mark as read
      add(ChatMarkRead(event.conversationId));
    } catch (e) {
      emit(state.copyWith(messagesStatus: ChatStatus.error, errorMessage: ErrorMapper.map(e)));
    }
  }

  Future<void> _onLoadMoreMessages(ChatLoadMoreMessages event, Emitter<ChatState> emit) async {
    if (!state.hasMoreMessages || state.currentConversationId == null) return;
    final nextPage = state.messagesPage + 1;
    try {
      final data = await _api.getMessages(state.currentConversationId!, nextPage);
      final older = data['messages'] as List<dynamic>;
      emit(state.copyWith(
        messages: [...older, ...state.messages],
        messagesPage: nextPage,
        hasMoreMessages: (data['page'] as int) < (data['totalPages'] as int),
      ));
    } catch (_) {}
  }

  Future<void> _onSendMessage(ChatSendMessage event, Emitter<ChatState> emit) async {
    if (state.currentConversationId == null) return;

    // Send via socket for real-time
    _socket.sendMessage(state.currentConversationId!, event.content, imageUrl: event.imageUrl);

    // Also send via REST as fallback and to get the created message back
    try {
      final message = await _api.sendMessage(state.currentConversationId!, event.content, imageUrl: event.imageUrl);
      // Add to local list (avoid duplicates from socket)
      final exists = state.messages.any((m) => m['id'] == message['id']);
      if (!exists) {
        emit(state.copyWith(messages: [...state.messages, message]));
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: ErrorMapper.map(e)));
    }
  }

  void _onReceiveMessage(ChatReceiveMessage event, Emitter<ChatState> emit) {
    final exists = state.messages.any((m) => m['id'] == event.message['id']);
    if (!exists) {
      emit(state.copyWith(messages: [...state.messages, event.message]));
    }
  }

  Future<void> _onMarkRead(ChatMarkRead event, Emitter<ChatState> emit) async {
    try {
      await _api.markAsRead(event.conversationId);
      _socket.markRead(event.conversationId);
    } catch (_) {}
  }

  void _onTypingChanged(ChatTypingChanged event, Emitter<ChatState> emit) {
    if (state.currentConversationId != null) {
      _socket.sendTyping(state.currentConversationId!, event.typing);
    }
  }

  void _onLeaveConversation(ChatLeaveConversation event, Emitter<ChatState> emit) {
    if (state.currentConversationId != null) {
      _socket.leaveConversation(state.currentConversationId!);
    }
    _messageSubscription?.cancel();
    emit(state.copyWith(
      currentConversationId: null,
      messages: [],
      messagesStatus: ChatStatus.initial,
    ));
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    return super.close();
  }
}
