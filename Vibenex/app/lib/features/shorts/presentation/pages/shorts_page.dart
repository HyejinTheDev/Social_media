import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/bloc/auth_bloc.dart';
import '../../bloc/short_bloc.dart';
import '../widgets/short_video_player.dart';
import '../widgets/short_comments_bottom_sheet.dart';

class ShortsPage extends StatefulWidget {
  const ShortsPage({super.key});

  @override
  State<ShortsPage> createState() => _ShortsPageState();
}

class _ShortsPageState extends State<ShortsPage> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<ShortBloc>().add(LoadShorts(authState.user.id));
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<ShortBloc, ShortState>(
        builder: (context, state) {
          if (state.status == ShortStatus.initial || state.status == ShortStatus.loading && state.shorts.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == ShortStatus.error && state.shorts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Lỗi: ${state.errorMessage}', style: const TextStyle(color: Colors.white)),
                  ElevatedButton(
                    onPressed: () {
                      final authState = context.read<AuthBloc>().state;
                      if (authState is AuthAuthenticated) {
                        context.read<ShortBloc>().add(LoadShorts(authState.user.id));
                      }
                    },
                    child: const Text('Thử lại'),
                  )
                ],
              ),
            );
          }

          if (state.shorts.isEmpty) {
            return const Center(
              child: Text('Chưa có video ngắn nào', style: TextStyle(color: Colors.white)),
            );
          }

          return PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: state.hasMore ? state.shorts.length + 1 : state.shorts.length,
            onPageChanged: (index) {
              if (index == state.shorts.length - 1 && state.hasMore) {
                final authState = context.read<AuthBloc>().state;
                if (authState is AuthAuthenticated) {
                  context.read<ShortBloc>().add(LoadMoreShorts(authState.user.id));
                }
              }
            },
            itemBuilder: (context, index) {
              if (index >= state.shorts.length) {
                return const Center(child: CircularProgressIndicator());
              }

              final short = state.shorts[index];
              return Stack(
                children: [
                  ShortVideoPlayer(videoUrl: short.videoUrl, thumbnailUrl: short.thumbnailUrl),
                  // Overlay UI
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(16).copyWith(bottom: 80), // Avoid bottom nav bar
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.8),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Left side (Info)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(short.authorAvatar),
                                      radius: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '@${short.authorName}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                if (short.caption != null && short.caption!.isNotEmpty)
                                  Text(
                                    short.caption!,
                                    style: const TextStyle(color: Colors.white),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                              ],
                            ),
                          ),
                          // Right side (Actions)
                          Column(
                            children: [
                              _buildAction(
                                icon: short.isLikedByMe ? Icons.favorite : Icons.favorite_border,
                                color: short.isLikedByMe ? Colors.red : Colors.white,
                                label: short.likeCount.toString(),
                                onTap: () {
                                  context.read<ShortBloc>().add(ToggleLikeShort(short.id));
                                },
                              ),
                              const SizedBox(height: 16),
                              _buildAction(
                                icon: Icons.comment,
                                color: Colors.white,
                                label: short.commentCount.toString(),
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => FractionallySizedBox(
                                      heightFactor: 0.7,
                                      child: ShortCommentsBottomSheet(shortId: short.id),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 16),
                              _buildAction(
                                icon: Icons.share,
                                color: Colors.white,
                                label: short.shareCount.toString(),
                                onTap: () {
                                  // Share action
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildAction({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: color, size: 36),
          onPressed: onTap,
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
