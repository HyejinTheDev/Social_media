import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/app_constants.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final String? thumbnailUrl;

  const VideoPlayerWidget({super.key, required this.videoUrl, this.thumbnailUrl});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isPlaying = false;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    final url = '${AppConstants.baseUrl}${widget.videoUrl}';
    _controller = VideoPlayerController.networkUrl(Uri.parse(url))
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _isInitialized = true;
          });
        }
      });
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
        _showControls = true;
      } else {
        _controller.play();
        _isPlaying = true;
        _showControls = false;
      }
    });
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!_isInitialized) return;
    if (info.visibleFraction > 0.6) {
      if (!_isPlaying) {
        _controller.play();
        setState(() {
          _isPlaying = true;
          _showControls = false;
        });
      }
    } else {
      if (_isPlaying) {
        _controller.pause();
        setState(() {
          _isPlaying = false;
          _showControls = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.videoUrl),
      onVisibilityChanged: _onVisibilityChanged,
      child: GestureDetector(
        onTap: _togglePlay,
        child: Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              if (!_isInitialized && widget.thumbnailUrl != null)
                CachedNetworkImage(
                  imageUrl: '${AppConstants.baseUrl}${widget.thumbnailUrl}',
                  fit: BoxFit.cover,
                ),
              if (_isInitialized)
                FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              if (!_isInitialized)
                const Center(child: CircularProgressIndicator(color: Colors.white)),
              if (_isInitialized && _showControls)
                Container(
                  color: Colors.black38,
                  child: const Center(
                    child: Icon(Icons.play_circle_fill, color: Colors.white, size: 60),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
