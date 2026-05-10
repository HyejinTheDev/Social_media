import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../core/constants/app_constants.dart';
import '../../domain/models/post_models.dart';
import '../../bloc/feed/feed_bloc.dart';
import '../../bloc/post/post_bloc.dart';
import 'image_grid.dart';
import 'video_player_widget.dart';
import 'double_tap_like_animation.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final String currentUserId;
  final bool isLiked; // From local state or backend if implemented, for now assume false or derive. Wait, feed bloc doesn't track current user like status directly unless it's in the model. We'll assume a dummy or toggle locally.

  const PostCard({super.key, required this.post, required this.currentUserId, this.isLiked = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      color: Colors.white,
      child: InkWell(
        onTap: () => context.push('/post/detail', extra: post),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 12),
              if (post.content.isNotEmpty)
                Text(post.content, style: const TextStyle(fontSize: 15, height: 1.4)),
              const SizedBox(height: 12),
              _buildMedia(context),
              const SizedBox(height: 12),
              _buildActionBar(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final avatar = post.author.avatar != null
        ? '${AppConstants.baseUrl}${post.author.avatar}'
        : 'https://ui-avatars.com/api/?name=${post.author.name}';
        
    final time = DateTime.parse(post.createdAt);

    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: CachedNetworkImageProvider(avatar),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(post.author.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  if (post.author.isVerified) ...[
                    const SizedBox(width: 4),
                    const Icon(Icons.verified, color: Colors.blue, size: 16),
                  ]
                ],
              ),
              Text(
                timeago.format(time, locale: 'vi'),
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
        if (post.authorId == currentUserId)
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {
              // Show bottom sheet to delete post
              showModalBottomSheet(
                context: context,
                builder: (_) => SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.delete, color: Colors.red),
                        title: const Text('Xóa bài viết', style: TextStyle(color: Colors.red)),
                        onTap: () {
                          Navigator.pop(context);
                          context.read<PostBloc>().add(PostDeleteRequested(post.id));
                          context.read<FeedBloc>().add(FeedPostDeleted(post.id));
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildMedia(BuildContext context) {
    if (post.mediaType == 'VIDEO' && post.videoUrl != null) {
      return DoubleTapLikeAnimation(
        onDoubleTap: () => context.read<PostBloc>().add(PostToggleLikeRequested(post.id)),
        child: VideoPlayerWidget(
          videoUrl: post.videoUrl!,
          thumbnailUrl: post.videoThumbnailUrl,
        ),
      );
    } else if (post.mediaType == 'IMAGE' && post.imageUrls.isNotEmpty) {
      return DoubleTapLikeAnimation(
        onDoubleTap: () => context.read<PostBloc>().add(PostToggleLikeRequested(post.id)),
        child: ImageGrid(imageUrls: post.imageUrls),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildActionBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _buildActionItem(
              icon: isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? Colors.red : Colors.grey[700]!,
              count: post.likesCount,
              onTap: () {
                context.read<PostBloc>().add(PostToggleLikeRequested(post.id));
                // In a real app, you'd also want to locally toggle the isLiked state immediately for better UX
                context.read<FeedBloc>().add(FeedPostLikeToggled(post.id, !isLiked));
              },
            ),
            const SizedBox(width: 24),
            _buildActionItem(
              icon: Icons.chat_bubble_outline,
              color: Colors.grey[700]!,
              count: post.commentsCount,
              onTap: () {
                context.push('/post/detail', extra: post);
              },
            ),
          ],
        ),
        IconButton(
          icon: Icon(Icons.share_outlined, color: Colors.grey[700]),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildActionItem({required IconData icon, required Color color, required int count, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            if (count > 0) ...[
              const SizedBox(width: 6),
              Text('$count', style: TextStyle(color: color, fontWeight: FontWeight.w600)),
            ]
          ],
        ),
      ),
    );
  }
}
