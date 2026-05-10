import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/app_constants.dart';

class ImageGrid extends StatelessWidget {
  final List<String> imageUrls;
  final VoidCallback? onTapImage;

  const ImageGrid({super.key, required this.imageUrls, this.onTapImage});

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GestureDetector(
          onTap: onTapImage,
          child: _buildGrid(context),
        ),
      ),
    );
  }

  Widget _buildGrid(BuildContext context) {
    final count = imageUrls.length;
    if (count == 1) {
      return _buildImage(context, imageUrls[0], height: 300, index: 0);
    } else if (count == 2) {
      return SizedBox(
        height: 250,
        child: Row(
          children: [
            Expanded(child: _buildImage(context, imageUrls[0], index: 0)),
            const SizedBox(width: 4),
            Expanded(child: _buildImage(context, imageUrls[1], index: 1)),
          ],
        ),
      );
    } else if (count == 3) {
      return SizedBox(
        height: 250,
        child: Row(
          children: [
            Expanded(child: _buildImage(context, imageUrls[0], index: 0)),
            const SizedBox(width: 4),
            Expanded(
              child: Column(
                children: [
                  Expanded(child: _buildImage(context, imageUrls[1], index: 1)),
                  const SizedBox(height: 4),
                  Expanded(child: _buildImage(context, imageUrls[2], index: 2)),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      // 4 or more
      return SizedBox(
        height: 300,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(child: _buildImage(context, imageUrls[0], index: 0)),
                  const SizedBox(height: 4),
                  Expanded(child: _buildImage(context, imageUrls[2], index: 2)),
                ],
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Column(
                children: [
                  Expanded(child: _buildImage(context, imageUrls[1], index: 1)),
                  const SizedBox(height: 4),
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        _buildImage(context, imageUrls[3], index: 3),
                        if (count > 4)
                          Container(
                            color: Colors.black54,
                            alignment: Alignment.center,
                            child: Text(
                              '+${count - 4}',
                              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildImage(BuildContext context, String url, {double? height, required int index}) {
    return GestureDetector(
      onTap: () {
        context.push('/image-viewer', extra: {'imageUrls': imageUrls, 'initialIndex': index});
      },
      child: CachedNetworkImage(
        imageUrl: '${AppConstants.baseUrl}$url',
        height: height,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(color: Colors.grey[300]),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[200],
          child: const Icon(Icons.error, color: Colors.grey),
        ),
      ),
    );
  }
}
