import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailC = TextEditingController();
  bool _sent = false;

  @override
  void dispose() { _emailC.dispose(); super.dispose(); }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _sent = true);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new, size: 20), onPressed: () => context.pop())),
      body: SafeArea(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 24),
        child: _sent ? _buildSuccess(cs) : _buildForm(cs),
      )),
    );
  }

  Widget _buildForm(ColorScheme cs) {
    return Form(key: _formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const SizedBox(height: 24),
      Container(width: 64, height: 64, alignment: Alignment.center,
        decoration: BoxDecoration(color: cs.primaryContainer.withValues(alpha: 0.3), shape: BoxShape.circle),
        child: Icon(Icons.lock_reset, size: 32, color: cs.primary)),
      const SizedBox(height: 24),
      Text('Quên mật khẩu?', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700), textAlign: TextAlign.center),
      const SizedBox(height: 12),
      Text('Nhập email đã đăng ký, chúng tôi sẽ gửi liên kết đặt lại mật khẩu.', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant), textAlign: TextAlign.center),
      const SizedBox(height: 32),
      CustomTextField(hint: 'name@example.com', controller: _emailC, keyboardType: TextInputType.emailAddress, prefixIcon: const Icon(Icons.email_outlined), validator: Validators.email),
      const SizedBox(height: 24),
      CustomButton(text: 'Gửi liên kết', onPressed: _onSubmit),
    ]));
  }

  Widget _buildSuccess(ColorScheme cs) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(width: 80, height: 80, decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.1), shape: BoxShape.circle),
        child: const Icon(Icons.mark_email_read, size: 40, color: Colors.green)),
      const SizedBox(height: 24),
      Text('Đã gửi email!', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
      const SizedBox(height: 12),
      Text('Kiểm tra hộp thư ${_emailC.text} để đặt lại mật khẩu.', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant), textAlign: TextAlign.center),
      const SizedBox(height: 32),
      CustomButton(text: 'Quay lại đăng nhập', onPressed: () => context.pop()),
    ]);
  }
}
