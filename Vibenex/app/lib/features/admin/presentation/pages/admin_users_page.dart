import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/avatar_widget.dart';
import '../../data/admin_api_service.dart';
import '../../../../core/di/injection.dart';
import 'package:dio/dio.dart';

class AdminUsersPage extends StatefulWidget {
  const AdminUsersPage({super.key});

  @override
  State<AdminUsersPage> createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> {
  late final AdminApiService _api;
  List<dynamic> _users = [];
  int _page = 1;
  int _totalPages = 1;
  bool _loading = true;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _api = AdminApiService(getIt<Dio>());
    _loadUsers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadUsers() async {
    setState(() => _loading = true);
    try {
      final data = await _api.getUsers(_page, search: _searchController.text);
      setState(() {
        _users = data['users'] ?? [];
        _totalPages = data['totalPages'] ?? 1;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  Future<void> _deleteUser(String userId, String name) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceMidnight,
        title: const Text('Xác nhận xóa', style: TextStyle(color: AppColors.textSilver)),
        content: Text('Bạn có chắc muốn xóa tài khoản "$name"? Hành động này không thể hoàn tác.',
            style: const TextStyle(color: AppColors.textFog)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Hủy')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Xóa', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _api.deleteUser(userId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đã xóa tài khoản $name')),
      );
      _loadUsers();
    }
  }

  Future<void> _toggleVerify(String userId) async {
    await _api.toggleVerify(userId);
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDeep,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDeep,
        iconTheme: const IconThemeData(color: AppColors.textSilver),
        title: const Text('Quản lý Người dùng', style: TextStyle(color: AppColors.textSilver, fontWeight: FontWeight.w700)),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: AppColors.textSilver, fontSize: 14),
              onSubmitted: (_) {
                _page = 1;
                _loadUsers();
              },
              decoration: InputDecoration(
                hintText: 'Tìm kiếm tên, email, username...',
                hintStyle: const TextStyle(color: AppColors.textFog, fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: AppColors.textFog),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear, color: AppColors.textFog, size: 18),
                  onPressed: () {
                    _searchController.clear();
                    _page = 1;
                    _loadUsers();
                  },
                ),
                filled: true,
                fillColor: AppColors.surfaceContainerHigh.withValues(alpha: 0.5),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              ),
            ),
          ),

          // User list
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator(color: AppColors.brandViolet))
                : _users.isEmpty
                    ? const Center(child: Text('Không tìm thấy người dùng', style: TextStyle(color: AppColors.textFog)))
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 80),
                        itemCount: _users.length,
                        itemBuilder: (context, index) {
                          final user = _users[index];
                          return _buildUserTile(user);
                        },
                      ),
          ),

          // Pagination
          if (_totalPages > 1)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left, color: AppColors.textSilver),
                    onPressed: _page > 1 ? () { _page--; _loadUsers(); } : null,
                  ),
                  Text('$_page / $_totalPages', style: const TextStyle(color: AppColors.textSilver)),
                  IconButton(
                    icon: const Icon(Icons.chevron_right, color: AppColors.textSilver),
                    onPressed: _page < _totalPages ? () { _page++; _loadUsers(); } : null,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildUserTile(Map<String, dynamic> user) {
    final isVerified = user['isVerified'] == true;
    final role = user['role'] ?? 'USER';
    final postCount = user['_count']?['posts'] ?? 0;
    final shortCount = user['_count']?['shorts'] ?? 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          AvatarWidget(imageUrl: user['avatar'], radius: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        user['name'] ?? '',
                        style: const TextStyle(color: AppColors.textSilver, fontWeight: FontWeight.w700, fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isVerified) ...[
                      const SizedBox(width: 4),
                      const Icon(Icons.verified, color: AppColors.brandViolet, size: 14),
                    ],
                    if (role == 'ADMIN') ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.redAccent.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text('ADMIN', style: TextStyle(color: Colors.redAccent, fontSize: 9, fontWeight: FontWeight.w800)),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text('@${user['username']}', style: const TextStyle(color: AppColors.textFog, fontSize: 12)),
                const SizedBox(height: 2),
                Text(
                  '${user['email']} · $postCount bài · $shortCount shorts',
                  style: const TextStyle(color: AppColors.textFog, fontSize: 11),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Actions
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: AppColors.textFog, size: 20),
            color: AppColors.surfaceMidnight,
            onSelected: (value) {
              if (value == 'verify') _toggleVerify(user['id']);
              if (value == 'delete') _deleteUser(user['id'], user['name'] ?? '');
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'verify',
                child: Row(
                  children: [
                    Icon(isVerified ? Icons.remove_circle_outline : Icons.verified, color: AppColors.brandViolet, size: 20),
                    const SizedBox(width: 8),
                    Text(isVerified ? 'Hủy xác minh' : 'Xác minh', style: const TextStyle(color: AppColors.textSilver)),
                  ],
                ),
              ),
              if (role != 'ADMIN')
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                      SizedBox(width: 8),
                      Text('Xóa tài khoản', style: TextStyle(color: Colors.redAccent)),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
