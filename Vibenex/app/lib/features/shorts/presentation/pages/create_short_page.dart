import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/di/injection.dart';
import '../../data/repositories/short_repository.dart';

class CreateShortPage extends StatefulWidget {
  const CreateShortPage({super.key});

  @override
  State<CreateShortPage> createState() => _CreateShortPageState();
}

class _CreateShortPageState extends State<CreateShortPage> {
  final _captionController = TextEditingController();
  final _picker = ImagePicker();
  File? _videoFile;
  VideoPlayerController? _videoController;
  bool _isUploading = false;
  
  final _shortRepository = getIt<ShortRepository>();

  @override
  void dispose() {
    _captionController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  Future<void> _pickVideo() async {
    try {
      final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _videoFile = File(pickedFile.path);
        });
        _initVideoController();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi chọn video: $e')),
        );
      }
    }
  }

  Future<void> _initVideoController() async {
    if (_videoFile == null) return;
    _videoController?.dispose();
    _videoController = VideoPlayerController.file(_videoFile!);
    await _videoController!.initialize();
    _videoController!.setLooping(true);
    _videoController!.play();
    setState(() {});
  }

  Future<void> _uploadShort() async {
    if (_videoFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng chọn video')),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      // 1. Upload video
      final videoUrl = await _shortRepository.uploadShortMedia(_videoFile!);
      
      // 2. Create Short
      await _shortRepository.createShort(
        videoUrl: videoUrl,
        caption: _captionController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đăng Short thành công!')),
        );
        context.pop(true); // Return true to refresh
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi tải lên: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDeep,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceMidnight,
        title: const Text('Đăng video ngắn', style: TextStyle(color: AppColors.textSilver, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: AppColors.textSilver),
        actions: [
          if (_videoFile != null)
            TextButton(
              onPressed: _isUploading ? null : _uploadShort,
              child: _isUploading 
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Đăng', style: TextStyle(color: AppColors.brandViolet, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Video preview
            GestureDetector(
              onTap: _pickVideo,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                color: Colors.black,
                child: _videoFile != null && _videoController != null && _videoController!.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _videoController!.value.aspectRatio,
                      child: VideoPlayer(_videoController!),
                    )
                  : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.video_library, size: 64, color: AppColors.textFog),
                        SizedBox(height: 16),
                        Text('Nhấn để chọn video', style: TextStyle(color: AppColors.textFog)),
                      ],
                    ),
              ),
            ),
            
            // Caption input
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _captionController,
                style: const TextStyle(color: AppColors.textSilver),
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Thêm mô tả cho video...',
                  hintStyle: const TextStyle(color: AppColors.textFog),
                  filled: true,
                  fillColor: AppColors.surfaceContainerHigh,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
