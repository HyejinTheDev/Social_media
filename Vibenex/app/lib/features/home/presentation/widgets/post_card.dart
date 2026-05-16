import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/avatar_widget.dart';
import '../../../../core/di/injection.dart';
import '../../domain/models/home_models.dart';
import '../../domain/repositories/post_repository.dart';
import '../widgets/comment_bottom_sheet.dart';
import '../../bloc/comment_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';

class PostCard extends StatefulWidget {
  final PostModel post;
  final VoidCallback? onLike;

  const PostCard({super.key, required this.post, this.onLike});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> with SingleTickerProviderStateMixin {
  bool _isLikeAnimating = false;
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scale = Tween<double>(begin: 0.5, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDoubleTap() {
    if (!widget.post.isLiked && widget.onLike != null) {
      widget.onLike!();
    }
    
    setState(() {
      _isLikeAnimating = true;
    });

    _controller.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 400), () {
        if (mounted) {
          _controller.reverse().then((_) {
            if (mounted) {
              setState(() {
                _isLikeAnimating = false;
              });
            }
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onDoubleTap: _handleDoubleTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        color: AppColors.surfaceMidnight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      AvatarWidget(
                        imageUrl: widget.post.author.avatar,
                        radius: 20,
                        onTap: () => context.push('/user/${widget.post.author.id}'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () => context.push('/user/${widget.post.author.id}'),
                                    child: Text(
                                      widget.post.author.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                if (widget.post.author.isVerified)
                                  const Padding(
                                    padding: EdgeInsets.only(left: 4),
                                    child: Icon(Icons.verified, size: 14, color: AppColors.brandViolet),
                                  ),
                                if (widget.post.author.isFriend)
                                  Container(
                                    margin: const EdgeInsets.only(left: 8),
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.brandViolet.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Row(
                                      children: [
                                        Icon(Icons.people, size: 10, color: AppColors.brandViolet),
                                        SizedBox(width: 4),
                                        Text(
                                          'Bạn bè',
                                          style: TextStyle(
                                            color: AppColors.brandViolet,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              timeago.format(widget.post.createdAt, locale: 'vi'),
                              style: TextStyle(
                                color: colorScheme.onSurfaceVariant,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {},
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),

                // Content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Text(
                    widget.post.content,
                    style: const TextStyle(fontSize: 15, height: 1.4),
                  ),
                ),

                // Images
                if (widget.post.imageUrls.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: _buildImageGrid(widget.post.imageUrls),
                  ),

                // Footer (Actions)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      _ActionButton(
                        icon: widget.post.isLiked ? Icons.favorite : Icons.favorite_border,
                        label: widget.post.likeCount.toString(),
                        color: widget.post.isLiked ? Colors.redAccent : colorScheme.onSurfaceVariant,
                        onTap: widget.onLike,
                      ),
                      _ActionButton(
                        icon: Icons.chat_bubble_outline,
                        label: widget.post.commentCount.toString(),
                        color: colorScheme.onSurfaceVariant,
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => BlocProvider(
                              create: (_) => CommentCubit(
                                getIt<PostRepository>(),
                                widget.post.id,
                              )..loadComments(),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).viewInsets.bottom,
                                ),
                                child: CommentBottomSheet(postId: widget.post.id),
                              ),
                            ),
                          );
                        },
                      ),
                      _ActionButton(
                        icon: Icons.share_outlined,
                        label: widget.post.shareCount.toString(),
                        color: colorScheme.onSurfaceVariant,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
            
            // Heart Animation Overlay
            if (_isLikeAnimating)
              Positioned.fill(
                child: Center(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scale.value,
                        child: Opacity(
                          opacity: _controller.value < 0.5 
                            ? _controller.value * 2 
                            : (1 - _controller.value) * 2,
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 100,
                            shadows: [
                              Shadow(
                                blurRadius: 15,
                                color: Colors.black54,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGrid(List<String> rawUrls) {
    final imageUrls = rawUrls.map((url) => url.startsWith('http') ? url : '${AppConstants.baseUrl}$url').toList();
    
    if (imageUrls.length == 1) {
      return CachedNetworkImage(
        imageUrl: imageUrls[0],
        width: double.infinity,
        height: 250,
        fit: BoxFit.cover,
      );
    } else if (imageUrls.length == 2) {
      return Row(
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: imageUrls[0],
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 2),
          Expanded(
            child: CachedNetworkImage(
              imageUrl: imageUrls[1],
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
        ],
      );
    } else {
      // For 3+ images, just show a simple horizontal list for now or grid
      return SizedBox(
        height: 250,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: imageUrls.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 2),
              child: CachedNetworkImage(
                imageUrl: imageUrls[index],
                width: 250,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      );
    }
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Icon(icon, size: 22, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
