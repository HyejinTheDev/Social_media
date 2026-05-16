import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ShortVideoPlayer extends StatefulWidget {
  final String videoUrl;
  
  const ShortVideoPlayer({super.key, required this.videoUrl});

  @override
  State<ShortVideoPlayer> createState() => _ShortVideoPlayerState();
}

class _ShortVideoPlayerState extends State<ShortVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
          _controller.setLooping(true);
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _controller.play();
      } else {
        _controller.pause();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.videoUrl),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.8 && _isInitialized) {
          if (!_isPlaying) {
            _controller.play();
            setState(() {
              _isPlaying = true;
            });
          }
        } else {
          if (_isPlaying) {
            _controller.pause();
            setState(() {
              _isPlaying = false;
            });
          }
        }
      },
      child: GestureDetector(
        onTap: _togglePlay,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (_isInitialized)
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              )
            else
              const Center(child: CircularProgressIndicator()),
              
            if (!_isPlaying && _isInitialized)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.play_arrow, color: Colors.white, size: 48),
              ),
          ],
        ),
      ),
    );
  }
}
