import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/models/post_models.dart';
import '../../bloc/comment/comment_bloc.dart';

class CommentTile extends StatelessWidget {
  final CommentModel comment;
  final String currentUserId;

  const CommentTile({super.key, required this.comment, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    final avatar = comment.author.avatar != null
        ? '${AppConstants.baseUrl}${comment.author.avatar}'
        : 'https://ui-avatars.com/api/?name=${comment.author.name}';
    final time = DateTime.parse(comment.createdAt);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: CachedNetworkImageProvider(avatar),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onLongPress: comment.authorId == currentUserId
                  ? () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) => SafeArea(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.delete, color: Colors.red),
                                title: const Text('Xóa bình luận', style: TextStyle(color: Colors.red)),
                                onTap: () {
                                  Navigator.pop(context);
                                  context.read<CommentBloc>().add(CommentDeleteRequested(comment.id));
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment.author.name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          comment.content,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      timeago.format(time, locale: 'vi'),
                      style: TextStyle(color: Colors.grey[600], fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
