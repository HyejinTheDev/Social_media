import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../bloc/community_bloc.dart';

class CreateCommunityPage extends StatefulWidget {
  const CreateCommunityPage({super.key});

  @override
  State<CreateCommunityPage> createState() => _CreateCommunityPageState();
}

class _CreateCommunityPageState extends State<CreateCommunityPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  bool _isPublic = true;
  bool _isVoiceRoom = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    context.read<CommunityBloc>().add(
      CreateCommunityRequested(
        name: _nameController.text.trim(),
        description: _descController.text.trim().isEmpty ? null : _descController.text.trim(),
        isPublic: _isPublic,
        isVoiceRoom: _isVoiceRoom,
        onResult: (error) {
          if (!mounted) return;
          setState(() => _isLoading = false);
          
          if (error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error, style: const TextStyle(color: Colors.white)), backgroundColor: Colors.red),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Tạo phòng thành công!', style: TextStyle(color: Colors.white)), backgroundColor: Colors.green),
            );
            context.pop(); // Go back to Communities page
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Tạo phòng mới'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textSilver),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.brandViolet))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Tên phòng', style: TextStyle(color: AppColors.onSurfaceVariant, fontSize: 14)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _nameController,
                      style: const TextStyle(color: AppColors.textSilver),
                      decoration: const InputDecoration(
                        hintText: 'VD: Góc chém gió',
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) return 'Vui lòng nhập tên phòng';
                        if (val.trim().length < 3) return 'Tên phải có ít nhất 3 ký tự';
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    
                    const Text('Mô tả (Không bắt buộc)', style: TextStyle(color: AppColors.onSurfaceVariant, fontSize: 14)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _descController,
                      style: const TextStyle(color: AppColors.textSilver),
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'Cộng đồng này dành cho...',
                      ),
                    ),
                    const SizedBox(height: 24),

                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SwitchListTile(
                        title: const Text('Phòng công khai', style: TextStyle(color: AppColors.textSilver, fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          _isPublic ? 'Ai cũng có thể tìm thấy và tham gia.' : 'Chỉ những người được mời mới có thể tham gia.',
                          style: const TextStyle(color: AppColors.textFog, fontSize: 12),
                        ),
                        value: _isPublic,
                        activeTrackColor: AppColors.brandViolet,
                        onChanged: (val) => setState(() => _isPublic = val),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SwitchListTile(
                        title: const Text('Loại phòng: Voice Room', style: TextStyle(color: AppColors.textSilver, fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          _isVoiceRoom ? 'Mọi người có thể trò chuyện bằng giọng nói.' : 'Mọi người trò chuyện bằng tin nhắn văn bản.',
                          style: const TextStyle(color: AppColors.textFog, fontSize: 12),
                        ),
                        value: _isVoiceRoom,
                        activeTrackColor: AppColors.statusEmerald,
                        onChanged: (val) => setState(() => _isVoiceRoom = val),
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: AppGradients.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        onPressed: _submit,
                        child: const Text('Tạo ngay', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
