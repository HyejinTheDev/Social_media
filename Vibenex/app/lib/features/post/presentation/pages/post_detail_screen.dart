import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/bloc/auth_bloc.dart';
import '../../domain/models/post_models.dart';
import '../../bloc/comment/comment_bloc.dart';
import '../widgets/post_card.dart';
import '../widgets/comment_tile.dart';
import '../../../../core/di/injection.dart';

class PostDetailScreen extends StatefulWidget {
  final PostModel post;

  const PostDetailScreen({super.key, required this.post});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late CommentBloc _commentBloc;

  @override
  void initState() {
    super.initState();
    _commentBloc = getIt<CommentBloc>()..add(CommentLoadRequested(widget.post.id));
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _commentController.dispose();
    _scrollController.dispose();
    _commentBloc.close();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
      _commentBloc.add(CommentLoadMoreRequested());
    }
  }

  void _submitComment() {
    final text = _commentController.text.trim();
    if (text.isNotEmpty) {
      _commentBloc.add(CommentAddRequested(widget.post.id, text));
      _commentController.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = (context.read<AuthBloc>().state is AuthAuthenticated)
        ? (context.read<AuthBloc>().state as AuthAuthenticated).user.id
        : '';

    return BlocProvider.value(
      value: _commentBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Bài viết', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0.5,
        ),
        body: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: PostCard(post: widget.post, currentUserId: currentUserId),
                  ),
                  const SliverToBoxAdapter(
                    child: Divider(height: 1, thickness: 1),
                  ),
                  BlocBuilder<CommentBloc, CommentState>(
                    builder: (context, state) {
                      if (state.status == CommentStatus.loading && state.comments.isEmpty) {
                        return const SliverFillRemaining(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      
                      if (state.comments.isEmpty) {
                        return const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.all(32.0),
                            child: Center(child: Text('Chưa có bình luận nào.', style: TextStyle(color: Colors.grey))),
                          ),
                        );
                      }

                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            if (index >= state.comments.length) {
                              return const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Center(child: CircularProgressIndicator()),
                              );
                            }
                            return CommentTile(
                              comment: state.comments[index],
                              currentUserId: currentUserId,
                            );
                          },
                          childCount: state.hasReachedMax ? state.comments.length : state.comments.length + 1,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            _buildCommentInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentInput() {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 8,
        top: 8,
        bottom: 8 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Viết bình luận...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              maxLines: null,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: _submitComment,
          ),
        ],
      ),
    );
  }
}
