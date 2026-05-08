import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/di/injection.dart';
import '../../bloc/post/post_bloc.dart';
import '../../bloc/feed/feed_bloc.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _contentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final List<File> _selectedImages = [];
  File? _selectedVideo;
  late PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _postBloc = getIt<PostBloc>();
  }

  @override
  void dispose() {
    _contentController.dispose();
    _postBloc.close();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(pickedFiles.map((e) => File(e.path)));
        _selectedVideo = null; // Either images or video
      });
    }
  }

  Future<void> _pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedVideo = File(pickedFile.path);
        _selectedImages.clear(); // Either images or video
      });
    }
  }

  void _submit() {
    final content = _contentController.text.trim();
    if (content.isEmpty && _selectedImages.isEmpty && _selectedVideo == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vui lòng nhập nội dung hoặc chọn ảnh/video.')));
      return;
    }

    _postBloc.add(PostCreateRequested(
      content: content,
      images: _selectedImages.isNotEmpty ? _selectedImages : null,
      video: _selectedVideo,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _postBloc,
      child: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostCreateSuccess) {
            context.read<FeedBloc>().add(FeedRefreshRequested());
            Navigator.pop(context);
          } else if (state is PostActionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final isLoading = state is PostActionLoading;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Tạo bài viết mới'),
              actions: [
                TextButton(
                  onPressed: isLoading ? null : _submit,
                  child: const Text('Đăng', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                )
              ],
            ),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _contentController,
                          maxLines: null,
                          decoration: const InputDecoration(
                            hintText: 'Bạn đang nghĩ gì?',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      if (_selectedImages.isNotEmpty)
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _selectedImages.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(_selectedImages[index], width: 90, height: 90, fit: BoxFit.cover),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: GestureDetector(
                                      onTap: () => setState(() => _selectedImages.removeAt(index)),
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                                        child: const Icon(Icons.close, color: Colors.white, size: 16),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      if (_selectedVideo != null)
                        Stack(
                          children: [
                            Container(
                              height: 150,
                              width: double.infinity,
                              color: Colors.black12,
                              child: const Center(child: Icon(Icons.videocam, size: 50, color: Colors.black54)),
                            ),
                            Positioned(
                              right: 8,
                              top: 8,
                              child: GestureDetector(
                                onTap: () => setState(() => _selectedVideo = null),
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                                  child: const Icon(Icons.close, color: Colors.white, size: 20),
                                ),
                              ),
                            )
                          ],
                        ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.photo_library, color: Colors.green),
                            onPressed: _pickImages,
                            tooltip: 'Chọn ảnh',
                          ),
                          IconButton(
                            icon: const Icon(Icons.video_library, color: Colors.redAccent),
                            onPressed: _pickVideo,
                            tooltip: 'Chọn video',
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                if (isLoading)
                  Container(
                    color: Colors.black26,
                    child: const Center(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 16),
                              Text('Đang tải lên...'),
                            ],
                          ),
                        ),
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
}
