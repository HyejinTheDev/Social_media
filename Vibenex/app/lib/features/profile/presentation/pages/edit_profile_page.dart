import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/image_utils.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/avatar_widget.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/image_drop_zone.dart';
import '../../bloc/profile_bloc.dart';
import '../widgets/image_picker_sheet.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameC;
  late TextEditingController _usernameC;
  late TextEditingController _bioC;
  File? _newAvatar;
  File? _newCover;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final state = context.read<ProfileBloc>().state;
      if (state is ProfileLoaded) {
        _nameC = TextEditingController(text: state.user.name);
        _usernameC = TextEditingController(text: state.user.username);
        _bioC = TextEditingController(text: state.user.bio ?? '');
        _initialized = true;
      }
    }
  }

  @override
  void dispose() {
    if (_initialized) { _nameC.dispose(); _usernameC.dispose(); _bioC.dispose(); }
    super.dispose();
  }

  void _handleAvatarFile(File file) {
    setState(() => _newAvatar = file);
    context.read<ProfileBloc>().add(ProfileAvatarUploadRequested(file.path));
  }

  void _handleCoverFile(File file) {
    setState(() => _newCover = file);
    context.read<ProfileBloc>().add(ProfileCoverUploadRequested(file.path));
  }

  void _pickAvatar() => ImagePickerSheet.show(context,
    title: 'Ảnh đại diện', showRemove: true,
    onPick: (src) async {
      final f = await ImageUtils.pickAvatar(source: src);
      if (f != null && mounted) _handleAvatarFile(f);
    },
    onRemove: () {},
  );

  void _pickCover() => ImagePickerSheet.show(context,
    title: 'Ảnh bìa', showRemove: true,
    onPick: (src) async {
      final f = await ImageUtils.pickCover(source: src);
      if (f != null && mounted) _handleCoverFile(f);
    },
    onRemove: () {},
  );

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    context.read<ProfileBloc>().add(ProfileUpdateRequested(
      name: _nameC.text.trim(),
      username: _usernameC.text.trim(),
      bio: _bioC.text.trim(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (ctx, state) {
        if (state is ProfileLoaded) {
          ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
            content: const Text('Đã cập nhật hồ sơ'),
            behavior: SnackBarBehavior.floating, backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ));
        } else if (state is ProfileError) {
          ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
            content: Text(state.message), backgroundColor: cs.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new, size: 20), onPressed: () => context.pop()),
          title: const Text('Chỉnh sửa hồ sơ'),
          actions: [
            BlocBuilder<ProfileBloc, ProfileState>(builder: (ctx, state) {
              return TextButton(
                onPressed: state is ProfileUpdating ? null : _save,
                child: state is ProfileUpdating
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                  : Text('Lưu', style: TextStyle(fontWeight: FontWeight.w700, color: cs.primary)),
              );
            }),
          ],
        ),
        body: !_initialized
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(child: Form(key: _formKey, child: Column(children: [
              _buildImageSection(cs),
              const SizedBox(height: 24),
              // Hint text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(children: [
                  Icon(Icons.info_outline, size: 14, color: cs.onSurfaceVariant),
                  const SizedBox(width: 6),
                  Text('Chạm hoặc kéo thả ảnh vào khu vực trên',
                    style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
                ]),
              ),
              const SizedBox(height: 20),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Column(children: [
                CustomTextField(label: 'Họ và tên', controller: _nameC, prefixIcon: const Icon(Icons.person_outline),
                  validator: (v) => Validators.required(v, 'Họ và tên')),
                const SizedBox(height: 16),
                CustomTextField(label: 'Tên người dùng', controller: _usernameC, prefixIcon: const Icon(Icons.alternate_email),
                  validator: Validators.username),
                const SizedBox(height: 16),
                CustomTextField(label: 'Giới thiệu', controller: _bioC, maxLines: 3, maxLength: 150,
                  hint: 'Viết gì đó về bạn...', prefixIcon: const Icon(Icons.info_outline)),
              ])),
              const SizedBox(height: 40),
            ]))),
      ),
    );
  }

  Widget _buildImageSection(ColorScheme cs) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (ctx, state) {
      final user = state is ProfileLoaded ? state.user : (state is ProfileUpdating ? state.user : null);
      final coverUrl = user?.coverPhoto != null ? '${AppConstants.baseUrl}${user!.coverPhoto}' : null;
      final avatarUrl = user?.avatar != null ? '${AppConstants.baseUrl}${user!.avatar}' : null;

      return Stack(clipBehavior: Clip.none, children: [
        // Cover with drop zone
        ImageDropZone(
          height: 160,
          onFileDropped: _handleCoverFile,
          onTap: _pickCover,
          child: Container(
            height: 160, width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [cs.primary.withValues(alpha: 0.5), cs.secondary.withValues(alpha: 0.3)]),
            ),
            child: Stack(children: [
              if (_newCover != null)
                Positioned.fill(child: Image.file(_newCover!, fit: BoxFit.cover))
              else if (coverUrl != null)
                Positioned.fill(child: CachedNetworkImage(imageUrl: coverUrl, fit: BoxFit.cover)),
              Center(child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(8)),
                child: const Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.camera_alt, color: Colors.white, size: 18),
                  SizedBox(width: 6),
                  Text('Ảnh bìa', style: TextStyle(color: Colors.white, fontSize: 13)),
                ]),
              )),
            ]),
          ),
        ),
        // Avatar with drop zone
        Positioned(left: 20, bottom: -40, child: ImageDropZone(
          borderRadius: BorderRadius.circular(44),
          onFileDropped: _handleAvatarFile,
          onTap: _pickAvatar,
          child: Container(
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 4)),
            child: Stack(children: [
              if (_newAvatar != null)
                CircleAvatar(radius: 40, backgroundImage: FileImage(_newAvatar!))
              else
                AvatarWidget(imageUrl: avatarUrl, radius: 40),
              Positioned(right: 0, bottom: 0, child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: cs.primary, shape: BoxShape.circle),
                child: const Icon(Icons.camera_alt, size: 14, color: Colors.white),
              )),
            ]),
          ),
        )),
      ]);
    });
  }
}
