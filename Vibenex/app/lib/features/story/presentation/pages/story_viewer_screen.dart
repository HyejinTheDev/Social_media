import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../core/constants/app_constants.dart';
import '../../bloc/story_bloc.dart';
import '../../domain/models/story_models.dart';
import '../widgets/story_progress_bar.dart';

class StoryViewerScreen extends StatefulWidget {
  final List<StoryGroup> groups;
  final int initialGroupIndex;

  const StoryViewerScreen({
    super.key,
    required this.groups,
    required this.initialGroupIndex,
  });

  @override
  State<StoryViewerScreen> createState() => _StoryViewerScreenState();
}

class _StoryViewerScreenState extends State<StoryViewerScreen> with TickerProviderStateMixin {
  late PageController _pageController;
  late int _currentGroupIndex;
  late int _currentStoryIndex;
  AnimationController? _progressController;

  @override
  void initState() {
    super.initState();
    _currentGroupIndex = widget.initialGroupIndex;
    _currentStoryIndex = 0;
    _pageController = PageController(initialPage: _currentGroupIndex);
    _startProgress();
  }

  @override
  void dispose() {
    _progressController?.dispose();
    _pageController.dispose();
    super.dispose();
  }

  StoryGroup get _currentGroup => widget.groups[_currentGroupIndex];
  StoryModel get _currentStory => _currentGroup.stories[_currentStoryIndex];

  void _startProgress() {
    _progressController?.dispose();
    final duration = _currentStory.mediaType == 'VIDEO'
        ? const Duration(seconds: 15)
        : const Duration(seconds: 5);

    _progressController = AnimationController(vsync: this, duration: duration);
    _progressController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _nextStory();
      }
    });
    _progressController!.forward();

    // Mark story as viewed
    context.read<StoryBloc>().add(StoryViewRequested(_currentStory.id));
  }

  void _nextStory() {
    if (_currentStoryIndex < _currentGroup.stories.length - 1) {
      setState(() => _currentStoryIndex++);
      _startProgress();
    } else {
      _nextGroup();
    }
  }

  void _prevStory() {
    if (_currentStoryIndex > 0) {
      setState(() => _currentStoryIndex--);
      _startProgress();
    } else {
      _prevGroup();
    }
  }

  void _nextGroup() {
    if (_currentGroupIndex < widget.groups.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  void _prevGroup() {
    if (_currentGroupIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentGroupIndex = index;
      _currentStoryIndex = 0;
    });
    _startProgress();
  }

  void _onTapDown(TapDownDetails details) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (details.globalPosition.dx < screenWidth / 3) {
      _prevStory();
    } else {
      _nextStory();
    }
  }

  void _onLongPressStart(LongPressStartDetails _) {
    _progressController?.stop();
  }

  void _onLongPressEnd(LongPressEndDetails _) {
    _progressController?.forward();
  }

  String _resolveMediaUrl(String url) {
    return url.startsWith('http') ? url : '${AppConstants.baseUrl}$url';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.groups.length,
        onPageChanged: _onPageChanged,
        itemBuilder: (context, groupIndex) {
          final group = widget.groups[groupIndex];
          final story = groupIndex == _currentGroupIndex
              ? group.stories[_currentStoryIndex]
              : group.stories[0];

          return GestureDetector(
            onTapDown: _onTapDown,
            onLongPressStart: _onLongPressStart,
            onLongPressEnd: _onLongPressEnd,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Media content
                _buildMedia(story),

                // Gradient overlay top
                Positioned(
                  top: 0, left: 0, right: 0,
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.6),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Progress bars + header
                Positioned(
                  top: MediaQuery.of(context).padding.top + 4,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      // Progress bars
                      if (groupIndex == _currentGroupIndex)
                        StoryProgressBar(
                          count: group.stories.length,
                          currentIndex: _currentStoryIndex,
                          animationController: _progressController,
                        ),

                      // User info header
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundImage: group.author.avatar != null
                                  ? CachedNetworkImageProvider(
                                      _resolveMediaUrl(group.author.avatar!),
                                    )
                                  : null,
                              child: group.author.avatar == null
                                  ? const Icon(Icons.person, size: 18)
                                  : null,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    group.author.username,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    timeago.format(
                                      DateTime.parse(story.createdAt),
                                      locale: 'vi',
                                    ),
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.7),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(Icons.close, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom gradient + caption
                if (story.caption != null && story.caption!.isNotEmpty)
                  Positioned(
                    left: 0, right: 0, bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.7),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Text(
                        story.caption!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          shadows: [Shadow(blurRadius: 4, color: Colors.black54)],
                        ),
                      ),
                    ),
                  ),

                // View count (owner only)
                if (story.viewCount > 0)
                  Positioned(
                    left: 16,
                    bottom: story.caption != null && story.caption!.isNotEmpty ? 60 : 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.visibility, color: Colors.white, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '${story.viewCount}',
                            style: const TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMedia(StoryModel story) {
    final url = _resolveMediaUrl(story.mediaUrl);

    if (story.mediaType == 'VIDEO') {
      // Placeholder for video — can integrate video_player later
      return Container(
        color: Colors.black,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.play_circle_outline, color: Colors.white, size: 64),
              SizedBox(height: 8),
              Text('Video Story', style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.contain,
      placeholder: (_, __) => const Center(
        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
      ),
      errorWidget: (_, __, ___) => const Center(
        child: Icon(Icons.broken_image, color: Colors.white54, size: 64),
      ),
    );
  }
}
