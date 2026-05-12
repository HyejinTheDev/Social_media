import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
        onResult: (error) {
          if (!mounted) return;
          setState(() => _isLoading = false);
          
          if (error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error, style: const TextStyle(color: Colors.white)), backgroundColor: Colors.red),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Tạo cộng đồng thành công!', style: TextStyle(color: Colors.white)), backgroundColor: Colors.green),
            );
            context.pop(); // Go back to Communities page
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Create Community'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: cs.primary))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tên cộng đồng', style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'VD: Flutter Vietnam',
                        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
                        filled: true,
                        fillColor: Colors.white.withValues(alpha: 0.05),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) return 'Vui lòng nhập tên cộng đồng';
                        if (val.trim().length < 3) return 'Tên phải có ít nhất 3 ký tự';
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    
                    Text('Mô tả (Không bắt buộc)', style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _descController,
                      style: const TextStyle(color: Colors.white),
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Cộng đồng này dành cho...',
                        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
                        filled: true,
                        fillColor: Colors.white.withValues(alpha: 0.05),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 24),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SwitchListTile(
                        title: const Text('Cộng đồng công khai', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          _isPublic ? 'Ai cũng có thể tìm thấy và tham gia.' : 'Chỉ những người được mời mới có thể tham gia.',
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12),
                        ),
                        value: _isPublic,
                        activeTrackColor: cs.primary,
                        onChanged: (val) => setState(() => _isPublic = val),
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cs.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
