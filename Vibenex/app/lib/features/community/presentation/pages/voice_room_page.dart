import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../auth/bloc/auth_bloc.dart';

class VoiceRoomPage extends StatefulWidget {
  final String communityId;
  final String channelId;
  final String channelName;
  final String communityName;

  const VoiceRoomPage({
    super.key,
    required this.communityId,
    required this.channelId,
    required this.channelName,
    required this.communityName,
  });

  @override
  State<VoiceRoomPage> createState() => _VoiceRoomPageState();
}

class _VoiceRoomPageState extends State<VoiceRoomPage> {
  String _userId = '';
  String _userName = '';

  @override
  void initState() {
    super.initState();
    final authState = getIt<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      _userId = authState.user.id;
      _userName = authState.user.name ?? authState.user.username;
    } else {
      // Fallback cho testing
      _userId = 'user_${DateTime.now().millisecondsSinceEpoch}';
      _userName = 'Guest ${_userId.substring(0, 4)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    // ⚠️ TODO: Replace with your actual ZegoCloud AppID and AppSign
    // 1. Go to https://console.zegocloud.com/
    // 2. Create a new project -> Live Audio Room
    // 3. Get AppID (int) and AppSign (String)
    const int appID = 1234567890; // REPLACE THIS
    const String appSign = 'YOUR_APP_SIGN_HERE'; // REPLACE THIS

    // In a real app, you would determine if the user is a host or audience based on their role in the community.
    // For simplicity, we make everyone a speaker/host for now, or use ZegoLiveAudioRoomRole.speaker.
    final role = ZegoLiveAudioRoomRole.speaker;

    return SafeArea(
      child: ZegoUIKitPrebuiltLiveAudioRoom(
        appID: appID,
        appSign: appSign,
        userID: _userId,
        userName: _userName,
        roomID: widget.channelId,
        config: (role == ZegoLiveAudioRoomRole.speaker
            ? ZegoUIKitPrebuiltLiveAudioRoomConfig.host()
            : ZegoUIKitPrebuiltLiveAudioRoomConfig.audience())
          ..takeSeatIndexWhenJoining = role == ZegoLiveAudioRoomRole.speaker ? 0 : -1
          ..background = Container(
            color: AppColors.backgroundDeep,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  '🎙️ ${widget.channelName}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textSilver),
                ),
                Text(
                  widget.communityName,
                  style: const TextStyle(fontSize: 14, color: AppColors.brandViolet),
                ),
              ],
            ),
          )
          ..layoutConfig = ZegoLiveAudioRoomLayoutConfig()
          ..seatConfig = ZegoLiveAudioRoomSeatConfig(
            showSoundWaveInAudioMode: true,
          )
          ..bottomMenuBarConfig = ZegoLiveAudioRoomBottomMenuBarConfig(
            hostButtons: [
              ZegoLiveAudioRoomMenuBarButtonName.toggleMicrophoneButton,
              ZegoLiveAudioRoomMenuBarButtonName.showMemberListButton,
            ],
            speakerButtons: [
              ZegoLiveAudioRoomMenuBarButtonName.toggleMicrophoneButton,
              ZegoLiveAudioRoomMenuBarButtonName.showMemberListButton,
            ],
          ),
      ),
    );
  }
}
