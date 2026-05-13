import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
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
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('# ${widget.channelName}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textSilver)),
            Text(widget.communityName, style: const TextStyle(fontSize: 11, color: AppColors.textFog)),
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
                  return const Center(child: CircularProgressIndicator(color: AppColors.brandViolet));
                }
                if (state is DiscussionError) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.error_outline, size: 40, color: AppColors.error),
                        const SizedBox(height: 8),
                        Text(state.message, style: const TextStyle(color: AppColors.textFog)),
                        TextButton(
                          onPressed: () => context.read<DiscussionBloc>().add(
                            LoadDiscussionsRequested(channelId: widget.channelId),
                          ),
                          child: const Text('Thử lại', style: TextStyle(color: AppColors.brandViolet)),
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
                          Icon(Icons.forum_outlined, size: 48, color: AppColors.brandViolet.withValues(alpha: 0.4)),
                          const SizedBox(height: 12),
                          const Text('Chưa có thảo luận nào.', style: TextStyle(color: AppColors.textFog)),
                          const SizedBox(height: 4),
                          const Text('Hãy bắt đầu cuộc trò chuyện!', style: TextStyle(color: AppColors.textFog, fontSize: 12)),
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
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator(color: AppColors.brandViolet, strokeWidth: 2)),
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
            decoration: const BoxDecoration(
              color: AppColors.surfaceMidnight,
              border: Border(top: BorderSide(color: AppColors.borderTwilight)),
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
                    style: const TextStyle(color: AppColors.textSilver, fontSize: 14),
                    maxLines: 4,
                    minLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Viết gì đó trong #${widget.channelName}...',
                      hintStyle: const TextStyle(color: AppColors.textFog),
                      filled: true,
                      fillColor: AppColors.surfaceContainerHigh,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(color: AppColors.brandViolet, width: 1.5),
                      ),
                    ),
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendDiscussion(),
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  icon: const Icon(Icons.send_rounded, color: AppColors.brandViolet),
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
