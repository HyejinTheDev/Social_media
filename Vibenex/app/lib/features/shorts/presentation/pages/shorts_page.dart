import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/shorts_mock_data.dart';
import '../widgets/short_video_overlay.dart';

class ShortsPage extends StatelessWidget {
  const ShortsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: ShortsMockData.shorts.length,
        itemBuilder: (context, index) {
          final data = ShortsMockData.shorts[index];
          return _ShortVideoItem(data: data);
        },
      ),
    );
  }
}

class _ShortVideoItem extends StatefulWidget {
  final Map<String, dynamic> data;

  const _ShortVideoItem({required this.data});

  @override
  State<_ShortVideoItem> createState() => _ShortVideoItemState();
}

class _ShortVideoItemState extends State<_ShortVideoItem> with TickerProviderStateMixin {
  late AnimationController _progressController;
  bool _isPlaying = true;
  bool _showIcon = false;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _progressController.repeat();
        }
      });
    
    _progressController.forward();
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      _isPlaying = !_isPlaying;
      _showIcon = true;
    });

    if (_isPlaying) {
      _progressController.forward();
    } else {
      _progressController.stop();
    }

    if (_isPlaying) {
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) {
          setState(() {
            _showIcon = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePlay,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background mock video
          CachedNetworkImage(
            imageUrl: widget.data['imageUrl'],
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
            errorWidget: (context, url, error) => const Center(
              child: Icon(Icons.error, color: Colors.white),
            ),
          ),
          
          // Overlay Info
          ShortVideoOverlay(data: widget.data),

          // Play/Pause Center Icon Animation
          if (_showIcon || !_isPlaying)
            Center(
              child: AnimatedOpacity(
                opacity: _isPlaying ? (_showIcon ? 1.0 : 0.0) : 1.0,
                duration: const Duration(milliseconds: 300),
                child: TweenAnimationBuilder(
                  key: ValueKey(_isPlaying),
                  tween: Tween<double>(begin: 0.8, end: 1.2),
                  duration: const Duration(milliseconds: 300),
                  builder: (context, scale, child) {
                    return Transform.scale(
                      scale: scale,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.4),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isPlaying ? Icons.play_arrow : Icons.pause,
                          color: Colors.white,
                          size: 64,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            
          // Progress Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _progressController,
              builder: (context, child) {
                return LinearProgressIndicator(
                  value: _progressController.value,
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  minHeight: 2,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
