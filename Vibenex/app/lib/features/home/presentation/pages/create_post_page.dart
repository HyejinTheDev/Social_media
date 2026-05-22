import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/avatar_widget.dart';
import '../../bloc/home_bloc.dart';
import '../../bloc/home_event.dart';
import '../../../auth/bloc/auth_bloc.dart';

class CreatePostPage extends StatefulWidget {
  final String? initialText;
  const CreatePostPage({super.key, this.initialText});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _contentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final List<File> _selectedImages = [];
  File? _selectedVideo;
  bool _isPosting = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialText != null) {
      _contentController.text = widget.initialText!;
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(images.map((img) => File(img.path)));
        _selectedVideo = null; // Can only post images OR video for simplicity
      });
    }
  }

  Future<void> _pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        _selectedVideo = File(video.path);
        _selectedImages.clear(); // Can only post images OR video
      });
    }
  }

  void _removeMedia() {
    setState(() {
      _selectedImages.clear();
      _selectedVideo = null;
    });
  }

  void _submitPost() {
    final content = _contentController.text.trim();
    if (content.isEmpty && _selectedImages.isEmpty && _selectedVideo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập nội dung hoặc chọn ảnh/video')),
      );
      return;
    }

    setState(() {
      _isPosting = true;
    });

    context.read<HomeBloc>().add(HomePostCreated(
      content: content,
      images: _selectedImages.isNotEmpty ? _selectedImages : null,
      video: _selectedVideo,
    ));

    // Show success and pop
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đang đăng bài viết...')),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final currentUser = context.read<AuthBloc>().state is AuthAuthenticated 
        ? (context.read<AuthBloc>().state as AuthAuthenticated).user 
        : null;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        title: const Text('Tạo bài viết', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
            onPressed: _isPosting ? null : _submitPost,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.brandViolet,
              disabledForegroundColor: colorScheme.onSurface.withValues(alpha: 0.38),
            ),
            child: const Text('Đăng', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (_isPosting)
              const LinearProgressIndicator(color: AppColors.brandViolet),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AvatarWidget(
                          imageUrl: currentUser?.avatar,
                          name: currentUser?.name,
                          radius: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          currentUser?.name ?? 'Người dùng',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _contentController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        hintText: 'Bạn đang nghĩ gì?',
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 18, color: AppColors.textFog),
                      ),
                      style: const TextStyle(fontSize: 18),
                      autofocus: true,
                    ),
                    const SizedBox(height: 16),
                    if (_selectedImages.isNotEmpty)
                      Stack(
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: colorScheme.outlineVariant),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: _selectedImages.length == 1
                                ? Image.file(_selectedImages[0], fit: BoxFit.cover)
                                : GridView.count(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 2,
                                    crossAxisSpacing: 2,
                                    children: _selectedImages.map((f) => Image.file(f, fit: BoxFit.cover)).toList(),
                                  ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton.filled(
                              icon: const Icon(Icons.close, size: 20),
                              onPressed: _removeMedia,
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.black.withValues(alpha: 0.6),
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (_selectedVideo != null)
                      Stack(
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Icon(Icons.videocam, color: Colors.white, size: 48),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton.filled(
                              icon: const Icon(Icons.close, size: 20),
                              onPressed: _removeMedia,
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.black.withValues(alpha: 0.6),
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Text('Thêm vào bài viết', style: TextStyle(fontWeight: FontWeight.w500)),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.photo_library, color: Colors.green),
                    onPressed: _pickImages,
                  ),
                  IconButton(
                    icon: const Icon(Icons.videocam, color: Colors.blue),
                    onPressed: _pickVideo,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
