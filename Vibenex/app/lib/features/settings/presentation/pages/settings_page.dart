import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../main.dart';
import '../../../auth/bloc/auth_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        title: const Text('Cài đặt', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: cs.surface,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            context.go('/login');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: cs.error),
            );
          }
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Account section
            const _SectionTitle(title: 'Tài khoản'),
            _SettingsTile(
              icon: Icons.lock_outline,
              title: 'Đổi mật khẩu',
              onTap: () => context.push('/change-password'),
            ),
            
            const SizedBox(height: 24),
            // App settings
            const _SectionTitle(title: 'Ứng dụng'),
            ListenableBuilder(
              listenable: themeNotifier,
              builder: (context, _) {
                final isDark = themeNotifier.themeMode == ThemeMode.dark || 
                    (themeNotifier.themeMode == ThemeMode.system && Theme.of(context).brightness == Brightness.dark);
                return _SettingsTile(
                  icon: Icons.dark_mode_outlined,
                  title: 'Giao diện tối',
                  trailing: Switch(
                    value: isDark,
                    onChanged: (v) {
                      themeNotifier.toggleTheme();
                    },
                  ),
                );
              },
            ),
            ListenableBuilder(
              listenable: localeProvider,
              builder: (context, _) {
                final isVi = localeProvider.locale.languageCode == 'vi';
                return _SettingsTile(
                  icon: Icons.language,
                  title: 'Ngôn ngữ',
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(isVi ? 'Tiếng Việt' : 'English', style: TextStyle(color: cs.onSurfaceVariant)),
                      const SizedBox(width: 8),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                  onTap: () {
                    localeProvider.toggleLocale();
                  },
                );
              },
            ),

            const SizedBox(height: 48),
            // Danger zone
            OutlinedButton.icon(
              onPressed: () {
                _showLogoutDialog(context);
              },
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text('Đăng xuất', style: TextStyle(color: Colors.red)),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                _showDeleteAccountDialog(context);
              },
              child: const Text('Xóa tài khoản vĩnh viễn', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Đăng xuất'),
        content: const Text('Bạn có chắc chắn muốn đăng xuất khỏi ứng dụng?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Hủy')),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<AuthBloc>().add(AuthLogoutRequested());
            },
            child: const Text('Đăng xuất', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cảnh báo nguy hiểm', style: TextStyle(color: Colors.red)),
        content: const Text(
            'Hành động này sẽ xóa vĩnh viễn tài khoản của bạn, bao gồm bài viết, bình luận, lượt thích và tin nhắn. Không thể khôi phục.\n\nBạn có chắc chắn muốn xóa?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Hủy')),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<AuthBloc>().add(AuthDeleteAccountRequested());
            },
            child: const Text('XÓA TÀI KHOẢN', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 12,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: cs.primaryContainer.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: cs.primary),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: trailing ?? const Icon(Icons.chevron_right),
    );
  }
}
