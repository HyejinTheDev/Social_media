import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../bloc/auth_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameC = TextEditingController();
  final _usernameC = TextEditingController();
  final _emailC = TextEditingController();
  final _passwordC = TextEditingController();
  final _confirmC = TextEditingController();
  bool _usernameOk = true;
  bool _checking = false;
  Timer? _debounce;

  @override
  void dispose() {
    _nameC.dispose(); _usernameC.dispose(); _emailC.dispose();
    _passwordC.dispose(); _confirmC.dispose(); _debounce?.cancel();
    super.dispose();
  }

  void _onUsernameChanged(String v) {
    _debounce?.cancel();
    if (v.length < 3) { setState(() { _usernameOk = true; _checking = false; }); return; }
    setState(() => _checking = true);
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        final dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));
        final res = await dio.get('/auth/check-username/$v');
        if (mounted) setState(() { _usernameOk = res.data['available'] == true; _checking = false; });
      } catch (_) { if (mounted) setState(() => _checking = false); }
    });
  }

  void _onRegister() {
    if (!_formKey.currentState!.validate() || !_usernameOk) return;
    context.read<AuthBloc>().add(AuthRegisterRequested(
      name: _nameC.text.trim(), username: _usernameC.text.trim(),
      email: _emailC.text.trim(), password: _passwordC.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return BlocListener<AuthBloc, AuthState>(
      listener: (ctx, state) {
        if (state is AuthAuthenticated) ctx.go('/feed');
        else if (state is AuthError) {
          ScaffoldMessenger.of(ctx)..hideCurrentSnackBar()..showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: cs.error,
              behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new, size: 20), onPressed: () => context.pop()), title: const Text('Tạo tài khoản')),
        body: SafeArea(child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(key: _formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            CustomTextField(label: 'Họ và tên', hint: 'Nguyễn Văn A', controller: _nameC, textInputAction: TextInputAction.next, prefixIcon: const Icon(Icons.person_outline), validator: (v) => Validators.required(v, 'Họ và tên')),
            const SizedBox(height: 16),
            CustomTextField(label: 'Tên người dùng', hint: 'nguyen_van_a', controller: _usernameC, textInputAction: TextInputAction.next, prefixIcon: const Icon(Icons.alternate_email), onChanged: _onUsernameChanged, validator: Validators.username,
              suffixIcon: _checking ? const Padding(padding: EdgeInsets.all(14), child: SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))) : _usernameC.text.length >= 3 ? Icon(_usernameOk ? Icons.check_circle : Icons.cancel, color: _usernameOk ? Colors.green : Colors.red) : null),
            if (!_usernameOk && !_checking && _usernameC.text.length >= 3)
              Padding(padding: const EdgeInsets.only(top: 6, left: 4), child: Text('Tên người dùng đã tồn tại', style: TextStyle(fontSize: 12, color: cs.error))),
            const SizedBox(height: 16),
            CustomTextField(label: 'Email', hint: 'name@example.com', controller: _emailC, keyboardType: TextInputType.emailAddress, textInputAction: TextInputAction.next, prefixIcon: const Icon(Icons.email_outlined), validator: Validators.email),
            const SizedBox(height: 16),
            CustomTextField(label: 'Mật khẩu', hint: 'Ít nhất 8 ký tự', controller: _passwordC, obscureText: true, textInputAction: TextInputAction.next, prefixIcon: const Icon(Icons.lock_outline), validator: Validators.password),
            const SizedBox(height: 16),
            CustomTextField(label: 'Xác nhận mật khẩu', hint: '••••••••', controller: _confirmC, obscureText: true, textInputAction: TextInputAction.done, prefixIcon: const Icon(Icons.lock_outline), validator: (v) => Validators.confirmPassword(v, _passwordC.text)),
            const SizedBox(height: 32),
            BlocBuilder<AuthBloc, AuthState>(builder: (ctx, state) => CustomButton(text: 'Đăng ký', isLoading: state is AuthLoading, onPressed: _onRegister)),
            const SizedBox(height: 24),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Đã có tài khoản? ', style: TextStyle(color: cs.onSurfaceVariant)),
              GestureDetector(onTap: () => context.pop(), child: Text('Đăng nhập', style: TextStyle(color: cs.primary, fontWeight: FontWeight.w700))),
            ]),
          ])),
        )),
      ),
    );
  }
}
