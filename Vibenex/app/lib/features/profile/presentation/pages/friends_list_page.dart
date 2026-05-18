import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/widgets/avatar_widget.dart';
import '../../../../core/widgets/shimmer_widgets.dart';
import '../../../../core/di/injection.dart';
import '../../data/datasources/friend_api_service.dart';

class FriendsListPage extends StatefulWidget {
  const FriendsListPage({super.key});

  @override
  State<FriendsListPage> createState() => _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _api = getIt<FriendApiService>();

  List<dynamic> _friends = [];
  List<dynamic> _requests = [];
  bool _loadingFriends = true;
  bool _loadingRequests = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadFriends();
    _loadRequests();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadFriends() async {
    try {
      final data = await _api.getFriends();
      if (mounted) {
        setState(() {
          _friends = data is List ? data : [];
          _loadingFriends = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _loadingFriends = false);
    }
  }

  Future<void> _loadRequests() async {
    try {
      final data = await _api.getPendingRequests();
      if (mounted) {
        setState(() {
          _requests = data is List ? data : [];
          _loadingRequests = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _loadingRequests = false);
    }
  }

  Future<void> _acceptRequest(String requestId) async {
    try {
      await _api.acceptRequest(requestId);
      _loadFriends();
      _loadRequests();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đã chấp nhận lời mời!'), backgroundColor: Color(0xFF10B981)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: $e'), backgroundColor: Colors.redAccent),
        );
      }
    }
  }

  Future<void> _rejectRequest(String requestId) async {
    try {
      await _api.rejectRequest(requestId);
      _loadRequests();
    } catch (_) {}
  }

  Future<void> _removeFriend(String userId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceMidnight,
        title: const Text('Hủy kết bạn?', style: TextStyle(color: AppColors.textSilver)),
        content: const Text('Bạn có chắc muốn hủy kết bạn?', style: TextStyle(color: AppColors.textFog)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Không')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Hủy kết bạn', style: TextStyle(color: Colors.redAccent))),
        ],
      ),
    );
    if (confirm == true) {
      try {
        await _api.removeFriend(userId);
        _loadFriends();
      } catch (_) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDeep,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceMidnight,
        title: const Text('Bạn bè', style: TextStyle(color: AppColors.textSilver, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: AppColors.textSilver),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.brandViolet,
          labelColor: AppColors.textSilver,
          unselectedLabelColor: AppColors.textFog,
          tabs: [
            Tab(text: 'Bạn bè (${_friends.length})'),
            Tab(text: 'Lời mời (${_requests.length})'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFriendsList(),
          _buildRequestsList(),
        ],
      ),
    );
  }

  Widget _buildFriendsList() {
    if (_loadingFriends) {
      return Column(children: List.generate(5, (_) => const RoomShimmer()));
    }
    if (_friends.isEmpty) {
      return const EmptyStateWidget(
        icon: Icons.people_outline,
        title: 'Chưa có bạn bè',
        subtitle: 'Tìm kiếm và kết bạn với người dùng khác nhé!',
      );
    }
    return RefreshIndicator(
      onRefresh: _loadFriends,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _friends.length,
        itemBuilder: (context, index) {
          final friend = _friends[index] as Map<String, dynamic>;
          final user = friend['friend'] ?? friend;
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: AvatarWidget(imageUrl: user['avatar'], radius: 24),
              title: Text(
                user['name'] ?? 'User',
                style: const TextStyle(color: AppColors.textSilver, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '@${user['username'] ?? ''}',
                style: const TextStyle(color: AppColors.textFog, fontSize: 12),
              ),
              trailing: PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: AppColors.textFog),
                color: AppColors.surfaceContainerHigh,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                onSelected: (val) {
                  if (val == 'remove') _removeFriend(user['id']);
                },
                itemBuilder: (_) => [
                  const PopupMenuItem(
                    value: 'remove',
                    child: Row(children: [
                      Icon(Icons.person_remove, color: Colors.redAccent, size: 20),
                      SizedBox(width: 12),
                      Text('Hủy kết bạn', style: TextStyle(color: Colors.redAccent)),
                    ]),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRequestsList() {
    if (_loadingRequests) {
      return Column(children: List.generate(3, (_) => const RoomShimmer()));
    }
    if (_requests.isEmpty) {
      return const EmptyStateWidget(
        icon: Icons.mail_outline,
        title: 'Không có lời mời nào',
        subtitle: 'Khi có ai đó gửi lời mời kết bạn, bạn sẽ thấy ở đây.',
      );
    }
    return RefreshIndicator(
      onRefresh: _loadRequests,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _requests.length,
        itemBuilder: (context, index) {
          final req = _requests[index] as Map<String, dynamic>;
          final sender = req['sender'] ?? req;
          final requestId = req['id'] ?? '';
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                AvatarWidget(imageUrl: sender['avatar'], radius: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sender['name'] ?? 'User',
                        style: const TextStyle(color: AppColors.textSilver, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '@${sender['username'] ?? ''}',
                        style: const TextStyle(color: AppColors.textFog, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                // Accept button
                Container(
                  decoration: BoxDecoration(
                    gradient: AppGradients.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => _acceptRequest(requestId),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text('Chấp nhận', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Reject button
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textFog),
                  onPressed: () => _rejectRequest(requestId),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
