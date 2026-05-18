import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/di/injection.dart';
import '../../domain/models/community_models.dart';
import '../../domain/repositories/community_repository.dart';

class EditRoomPage extends StatefulWidget {
  final CommunityModel community;
  const EditRoomPage({super.key, required this.community});

  @override
  State<EditRoomPage> createState() => _EditRoomPageState();
}

class _EditRoomPageState extends State<EditRoomPage> {
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late bool _isVoiceRoom;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.community.name);
    _descController = TextEditingController(text: widget.community.description ?? '');
    _isVoiceRoom = widget.community.isVoiceRoom;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_nameController.text.trim().isEmpty) return;
    setState(() => _isLoading = true);
    try {
      final repo = getIt<CommunityRepository>();
      await repo.updateCommunity(
        widget.community.id,
        _nameController.text.trim(),
        _descController.text.trim(),
        _isVoiceRoom,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đã cập nhật phòng!'), backgroundColor: AppColors.statusEmerald),
        );
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: $e'), backgroundColor: Colors.redAccent),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDeep,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceMidnight,
        title: const Text('Sửa thông tin phòng', style: TextStyle(color: AppColors.textSilver, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: AppColors.textSilver),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Tên phòng', style: TextStyle(color: AppColors.textFog, fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              style: const TextStyle(color: AppColors.textSilver),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.surfaceContainerHigh,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                hintText: 'Tên phòng...',
                hintStyle: const TextStyle(color: AppColors.textFog),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Mô tả', style: TextStyle(color: AppColors.textFog, fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _descController,
              style: const TextStyle(color: AppColors.textSilver),
              maxLines: 3,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.surfaceContainerHigh,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                hintText: 'Mô tả phòng...',
                hintStyle: const TextStyle(color: AppColors.textFog),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SwitchListTile(
                title: const Text('Voice Room', style: TextStyle(color: AppColors.textSilver, fontWeight: FontWeight.bold)),
                subtitle: Text(
                  _isVoiceRoom ? 'Phòng thoại giọng nói' : 'Phòng chat văn bản',
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
                onPressed: _isLoading ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isLoading
                    ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('Lưu thay đổi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
