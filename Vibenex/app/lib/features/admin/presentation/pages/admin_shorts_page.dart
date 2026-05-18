import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/avatar_widget.dart';
import '../../data/admin_api_service.dart';
import '../../../../core/di/injection.dart';
import 'package:dio/dio.dart';

class AdminShortsPage extends StatefulWidget {
  const AdminShortsPage({super.key});

  @override
  State<AdminShortsPage> createState() => _AdminShortsPageState();
}

class _AdminShortsPageState extends State<AdminShortsPage> {
  late final AdminApiService _api;
  List<dynamic> _shorts = [];
  int _page = 1;
  int _totalPages = 1;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _api = AdminApiService(getIt<Dio>());
    _loadShorts();
  }

  Future<void> _loadShorts() async {
    setState(() => _loading = true);
    try {
      final data = await _api.getShorts(_page);
      setState(() {
        _shorts = data['shorts'] ?? [];
        _totalPages = data['totalPages'] ?? 1;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  Future<void> _deleteShort(String shortId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceMidnight,
        title: const Text('Xác nhận xóa', style: TextStyle(color: AppColors.textSilver)),
        content: const Text('Bạn có chắc muốn xóa video này?', style: TextStyle(color: AppColors.textFog)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Hủy')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Xóa', style: TextStyle(color: Colors.redAccent))),
        ],
      ),
    );
    if (confirm == true) {
      await _api.deleteShort(shortId);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã xóa video')));
      _loadShorts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDeep,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDeep,
        iconTheme: const IconThemeData(color: AppColors.textSilver),
        title: const Text('Quản lý Shorts', style: TextStyle(color: AppColors.textSilver, fontWeight: FontWeight.w700)),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: AppColors.brandViolet))
          : _shorts.isEmpty
              ? const Center(child: Text('Không có video', style: TextStyle(color: AppColors.textFog)))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 80),
                        itemCount: _shorts.length,
                        itemBuilder: (context, index) => _buildShortTile(_shorts[index]),
                      ),
                    ),
                    if (_totalPages > 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(icon: const Icon(Icons.chevron_left, color: AppColors.textSilver), onPressed: _page > 1 ? () { _page--; _loadShorts(); } : null),
                            Text('$_page / $_totalPages', style: const TextStyle(color: AppColors.textSilver)),
                            IconButton(icon: const Icon(Icons.chevron_right, color: AppColors.textSilver), onPressed: _page < _totalPages ? () { _page++; _loadShorts(); } : null),
                          ],
                        ),
                      ),
                  ],
                ),
    );
  }

  Widget _buildShortTile(Map<String, dynamic> short_) {
    final author = short_['author'] ?? {};
    final createdAt = DateTime.tryParse(short_['createdAt'] ?? '') ?? DateTime.now();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Thumbnail
          Container(
            width: 60,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(child: Icon(Icons.play_circle, color: Colors.white54, size: 28)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AvatarWidget(imageUrl: author['avatar'], radius: 14),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(author['name'] ?? '', style: const TextStyle(color: AppColors.textSilver, fontWeight: FontWeight.w600, fontSize: 13)),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  short_['caption'] ?? 'Không có caption',
                  style: const TextStyle(color: AppColors.textFog, fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _stat(Icons.favorite, '${short_['likeCount'] ?? 0}'),
                    const SizedBox(width: 12),
                    _stat(Icons.chat_bubble_outline, '${short_['commentCount'] ?? 0}'),
                    const SizedBox(width: 12),
                    Text(timeago.format(createdAt, locale: 'vi'), style: const TextStyle(color: AppColors.textFog, fontSize: 10)),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
            onPressed: () => _deleteShort(short_['id']),
          ),
        ],
      ),
    );
  }

  Widget _stat(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 13, color: AppColors.textFog),
        const SizedBox(width: 3),
        Text(label, style: const TextStyle(color: AppColors.textFog, fontSize: 11)),
      ],
    );
  }
}
