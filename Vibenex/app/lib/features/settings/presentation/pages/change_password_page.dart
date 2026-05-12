import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/bloc/auth_bloc.dart';
import '../../../../core/widgets/custom_text_field.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordCtrl = TextEditingController();
  final _newPasswordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();

  @override
  void dispose() {
    _oldPasswordCtrl.dispose();
    _newPasswordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        AuthChangePasswordRequested(
          oldPassword: _oldPasswordCtrl.text,
          newPassword: _newPasswordCtrl.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đổi mật khẩu'),
        backgroundColor: cs.surface,
        elevation: 0,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: cs.error),
            );
          } else if (state is AuthAuthenticated) {
            // Success
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Đổi mật khẩu thành công'), backgroundColor: Colors.green),
            );
            context.pop();
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                CustomTextField(
                  label: 'Mật khẩu cũ',
                  controller: _oldPasswordCtrl,
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock_outline),
                  validator: (v) => v!.isEmpty ? 'Vui lòng nhập mật khẩu cũ' : null,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Mật khẩu mới',
                  controller: _newPasswordCtrl,
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock_outline),
                  validator: (v) => v!.length < 8 ? 'Mật khẩu phải có ít nhất 8 ký tự' : null,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Nhập lại mật khẩu mới',
                  controller: _confirmPasswordCtrl,
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock_outline),
                  validator: (v) => v != _newPasswordCtrl.text ? 'Mật khẩu không khớp' : null,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: state is AuthLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: state is AuthLoading
                      ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Text('CẬP NHẬT MẬT KHẨU', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
