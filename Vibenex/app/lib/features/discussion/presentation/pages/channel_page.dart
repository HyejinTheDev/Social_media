import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/discussion_bloc.dart';
import '../widgets/discussion_card.dart';

/// Page showing discussions inside a specific channel.
class ChannelPage extends StatefulWidget {
  final String channelId;
  final String channelName;
  final String communityName;

  const ChannelPage({
    super.key,
    required this.channelId,
    required this.channelName,
    required this.communityName,
  });

  @override
  State<ChannelPage> createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  final _scrollController = ScrollController();
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<DiscussionBloc>().add(LoadDiscussionsRequested(channelId: widget.channelId));
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      final state = context.read<DiscussionBloc>().state;
      if (state is DiscussionsLoaded && !state.hasReachedMax) {
        context.read<DiscussionBloc>().add(
          LoadDiscussionsRequested(channelId: widget.channelId, page: state.currentPage + 1),
        );
      }
    }
  }

  void _sendDiscussion() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;
    context.read<DiscussionBloc>().add(
      CreateDiscussionRequested(channelId: widget.channelId, content: text),
    );
    _textController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('# ${widget.channelName}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(widget.communityName, style: TextStyle(fontSize: 11, color: cs.onSurfaceVariant)),
          ],
        ),
      ),
      body: Column(
        children: [
          // ─── Discussion List ───
          Expanded(
            child: BlocBuilder<DiscussionBloc, DiscussionState>(
              builder: (context, state) {
                if (state is DiscussionLoading) {
                  return Center(child: CircularProgressIndicator(color: cs.primary));
                }
                if (state is DiscussionError) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.error_outline, size: 40, color: Colors.red),
                        const SizedBox(height: 8),
                        Text(state.message, style: const TextStyle(color: Colors.white70)),
                        TextButton(
                          onPressed: () => context.read<DiscussionBloc>().add(
                            LoadDiscussionsRequested(channelId: widget.channelId),
                          ),
                          child: Text('Thử lại', style: TextStyle(color: cs.primary)),
                        ),
                      ],
                    ),
                  );
                }
                if (state is DiscussionsLoaded) {
                  if (state.discussions.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.forum_outlined, size: 48, color: cs.primary.withValues(alpha: 0.4)),
                          const SizedBox(height: 12),
                          const Text('Chưa có thảo luận nào.', style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 4),
                          const Text('Hãy bắt đầu cuộc trò chuyện!', style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    );
                  }
                  return ListView.separated(
                    controller: _scrollController,
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                    itemCount: state.discussions.length + (state.hasReachedMax ? 0 : 1),
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      if (index >= state.discussions.length) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator(color: cs.primary, strokeWidth: 2)),
                        );
                      }
                      return DiscussionCard(discussion: state.discussions[index]);
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),

          // ─── Compose Bar ───
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.08))),
            ),
            padding: EdgeInsets.only(
              left: 12,
              right: 4,
              top: 8,
              bottom: MediaQuery.of(context).padding.bottom + 8,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    maxLines: 4,
                    minLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Viết gì đó trong #${widget.channelName}...',
                      hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.06),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendDiscussion(),
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  icon: Icon(Icons.send_rounded, color: cs.primary),
                  onPressed: _sendDiscussion,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
