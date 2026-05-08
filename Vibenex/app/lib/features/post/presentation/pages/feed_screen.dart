import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../auth/bloc/auth_bloc.dart';
import '../../bloc/feed/feed_bloc.dart';
import '../widgets/post_card.dart';
import '../widgets/feed_shimmer.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<FeedBloc>().add(FeedLoadRequested());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<FeedBloc>().add(FeedLoadMoreRequested());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll - 200);
  }

  Future<void> _onRefresh() async {
    context.read<FeedBloc>().add(FeedRefreshRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Vibenex', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, letterSpacing: -0.5)),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0.5,
        actions: [
          IconButton(icon: const Icon(Icons.search, color: Colors.black87), onPressed: () {}),
          IconButton(icon: const Icon(Icons.notifications_none, color: Colors.black87), onPressed: () {}),
        ],
      ),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state.status == FeedStatus.initial || (state.status == FeedStatus.loading && state.posts.isEmpty)) {
            return const FeedShimmer();
          }

          if (state.status == FeedStatus.failure && state.posts.isEmpty) {
            return ErrorStateWidget(
              message: state.errorMessage ?? 'Không thể tải bảng tin',
              onRetry: () => context.read<FeedBloc>().add(FeedLoadRequested()),
            );
          }

          if (state.posts.isEmpty) {
            return const EmptyStateWidget(
              icon: Icons.article_outlined,
              title: 'Chưa có bài viết nào',
              subtitle: 'Hãy bắt đầu theo dõi mọi người để xem bảng tin',
            );
          }

          final currentUser = (context.read<AuthBloc>().state is AuthAuthenticated)
              ? (context.read<AuthBloc>().state as AuthAuthenticated).user.id
              : '';

          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: state.hasReachedMax ? state.posts.length : state.posts.length + 1,
              itemBuilder: (context, index) {
                if (index >= state.posts.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                
                final post = state.posts[index];
                // Note: ideally like status should be fetched per post or embedded in post model from backend.
                // Here we assume it's part of local state or passed. Since it's not in the model yet, we leave it false.
                return PostCard(post: post, currentUserId: currentUser);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/post/create');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
