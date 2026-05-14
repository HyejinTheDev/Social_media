import 'package:flutter/material.dart';
import '../../../../core/widgets/avatar_widget.dart';

class ShortVideoOverlay extends StatelessWidget {
  final Map<String, dynamic> data;

  const ShortVideoOverlay({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Dark gradient at bottom and top for text visibility
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 300,
          child: Container(
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
          ),
        ),
        
        // Right side actions
        Positioned(
          right: 16,
          bottom: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAction(
                icon: Icons.favorite,
                label: _formatCount(data['likeCount']),
                color: Colors.white,
              ),
              const SizedBox(height: 24),
              _buildAction(
                icon: Icons.chat_bubble,
                label: _formatCount(data['commentCount']),
                color: Colors.white,
              ),
              const SizedBox(height: 24),
              _buildAction(
                icon: Icons.share,
                label: _formatCount(data['shareCount']),
                color: Colors.white,
              ),
              const SizedBox(height: 32),
              AvatarWidget(
                imageUrl: data['author']['avatar'],
                radius: 24,
                showBorder: true,
                borderColor: Colors.white,
              ),
            ],
          ),
        ),
        
        // Bottom info
        Positioned(
          left: 16,
          bottom: 20,
          right: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '@${data['author']['name']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                data['description'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.music_note, color: Colors.white, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    data['musicName'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}

Widget _buildAction({required IconData icon, required String label, required Color color}) {
  return Column(
    children: [
      Icon(icon, size: 36, color: color),
      const SizedBox(height: 4),
      Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    ],
  );
}
