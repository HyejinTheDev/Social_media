import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../../../../core/widgets/vibenex_app_bar.dart';
import '../../bloc/home_bloc.dart';
import '../../bloc/home_event.dart';
import '../../bloc/home_state.dart';
import '../../../../features/auth/bloc/auth_bloc.dart';
import '../widgets/post_card.dart';
import '../widgets/story_row.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const VibenexAppBar(),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.status == HomeStatus.initial || state.status == HomeStatus.loading) {
            return const ShimmerLoading();
          }

          if (state.status == HomeStatus.error) {
            return ErrorStateWidget(
              message: state.errorMessage ?? 'Đã xảy ra lỗi',
              onRetry: () => context.read<HomeBloc>().add(HomeLoadRequested()),
            );
          }

          final currentUser = context.read<AuthBloc>().state is AuthAuthenticated
              ? (context.read<AuthBloc>().state as AuthAuthenticated).user
              : null;
          final currentAvatar = currentUser?.avatar ?? 'https://i.pravatar.cc/150?u=self';

          return RefreshIndicator(
            onRefresh: () async {
              context.read<HomeBloc>().add(HomeRefreshed());
            },
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      StoryRow(
                        stories: state.stories,
                        currentUserAvatar: currentAvatar,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        height: 8,
                        color: AppColors.backgroundDeep,
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final post = state.posts[index];
                      return PostCard(
                        post: post,
                        onLike: () {
                          context.read<HomeBloc>().add(HomePostLikeToggled(post.id));
                        },
                      );
                    },
                    childCount: state.posts.length,
                  ),
                ),
                // Padding at bottom
                const SliverToBoxAdapter(
                  child: SizedBox(height: 80),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
