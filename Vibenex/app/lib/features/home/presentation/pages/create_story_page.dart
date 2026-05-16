import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/theme/app_colors.dart';
import '../../bloc/home_bloc.dart';
import '../../bloc/home_event.dart';

class CreateStoryPage extends StatefulWidget {
  const CreateStoryPage({super.key});

  @override
  State<CreateStoryPage> createState() => _CreateStoryPageState();
}

class _CreateStoryPageState extends State<CreateStoryPage> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedMedia;
  bool _isUploading = false;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _selectedMedia = File(image.path));
    }
  }

  void _submitStory() {
    if (_selectedMedia == null) return;
    
    setState(() => _isUploading = true);
    
    // Dispatch event to upload and create story
    context.read<HomeBloc>().add(HomeStoryCreated(file: _selectedMedia!));
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đang đăng Story...')),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        actions: [
          if (_selectedMedia != null)
            TextButton(
              onPressed: _isUploading ? null : _submitStory,
              child: const Text('Đăng', style: TextStyle(color: AppColors.brandViolet, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
      body: Center(
        child: _selectedMedia == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 64,
                    icon: const Icon(Icons.photo_library, color: Colors.white),
                    onPressed: _pickImage,
                  ),
                  const SizedBox(height: 16),
                  const Text('Chọn ảnh từ thư viện', style: TextStyle(color: Colors.white)),
                ],
              )
            : Image.file(_selectedMedia!),
      ),
    );
  }
}
