import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../auth/bloc/auth_bloc.dart';
import '../../../chat/data/datasources/socket_service.dart';

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

class _VoiceRoomPageState extends State<VoiceRoomPage> with TickerProviderStateMixin {
  final _socketService = getIt<SocketService>();
  String _userId = '';
  String _userName = '';
  String? _userAvatar;
  bool _isMuted = true;

  List<Map<String, dynamic>> _participants = [];

  StreamSubscription? _participantsSub;
  StreamSubscription? _userJoinedSub;
  StreamSubscription? _userLeftSub;
  StreamSubscription? _micToggledSub;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    final authState = getIt<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      _userId = authState.user.id;
      _userName = authState.user.name;
      _userAvatar = authState.user.avatar;
    }

    _participantsSub = _socketService.onVoiceParticipants.listen((data) {
      if (data['channelId'] == widget.channelId) {
        setState(() {
          _participants = List<Map<String, dynamic>>.from(
            (data['participants'] as List).map((p) => Map<String, dynamic>.from(p)),
          );
        });
      }
    });

    _userJoinedSub = _socketService.onVoiceUserJoined.listen((data) {
      if (data['channelId'] == widget.channelId) {
        final participant = Map<String, dynamic>.from(data['participant']);
        setState(() {
          _participants.removeWhere((p) => p['userId'] == participant['userId']);
          _participants.add(participant);
        });
      }
    });

    _userLeftSub = _socketService.onVoiceUserLeft.listen((data) {
      if (data['channelId'] == widget.channelId) {
        setState(() {
          _participants.removeWhere((p) => p['userId'] == data['userId']);
        });
      }
    });

    _micToggledSub = _socketService.onVoiceMicToggled.listen((data) {
      if (data['channelId'] == widget.channelId) {
        setState(() {
          final idx = _participants.indexWhere((p) => p['userId'] == data['userId']);
          if (idx != -1) {
            _participants[idx] = {..._participants[idx], 'isMuted': data['isMuted']};
          }
          if (data['userId'] == _userId) {
            _isMuted = data['isMuted'];
          }
        });
      }
    });

    // Join the voice room
    _socketService.joinVoiceRoom(widget.channelId, _userName, avatar: _userAvatar);
  }

  @override
  void dispose() {
    _socketService.leaveVoiceRoom(widget.channelId);
    _participantsSub?.cancel();
    _userJoinedSub?.cancel();
    _userLeftSub?.cancel();
    _micToggledSub?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  void _toggleMic() {
    final newMuted = !_isMuted;
    _socketService.toggleMic(widget.channelId, newMuted);
    setState(() => _isMuted = newMuted);
  }

  void _leaveRoom() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textSilver),
          onPressed: _leaveRoom,
        ),
        title: Column(
          children: [
            Text(
              '🎙️ ${widget.channelName}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textSilver,
              ),
            ),
            Text(
              widget.communityName,
              style: const TextStyle(fontSize: 12, color: AppColors.brandViolet),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.brandViolet.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.people, color: AppColors.brandViolet, size: 16),
                const SizedBox(width: 4),
                Text(
                  '${_participants.length}',
                  style: const TextStyle(
                    color: AppColors.brandViolet,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Status bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.brandViolet.withValues(alpha: 0.15),
                  const Color(0xFF7C3AED).withValues(alpha: 0.08),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.brandViolet.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _participants.isNotEmpty ? Colors.greenAccent : Colors.grey,
                    shape: BoxShape.circle,
                    boxShadow: _participants.isNotEmpty
                        ? [BoxShadow(color: Colors.greenAccent.withValues(alpha: 0.5), blurRadius: 6)]
                        : null,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  _participants.isEmpty
                      ? 'Đang kết nối...'
                      : '${_participants.length} người đang trong phòng',
                  style: const TextStyle(color: AppColors.textSilver, fontSize: 13),
                ),
              ],
            ),
          ),

          // Participants grid
          Expanded(
            child: _participants.isEmpty
                ? _buildEmptyState()
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: _participants.length,
                      itemBuilder: (context, index) {
                        return _buildParticipantCard(_participants[index]);
                      },
                    ),
                  ),
          ),

          // Bottom control bar
          _buildControlBar(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.headset_mic,
            size: 64,
            color: AppColors.brandViolet.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 16),
          const Text(
            'Đang kết nối vào phòng...',
            style: TextStyle(color: AppColors.textFog, fontSize: 16),
          ),
          const SizedBox(height: 8),
          const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.brandViolet,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParticipantCard(Map<String, dynamic> participant) {
    final isMuted = participant['isMuted'] == true;
    final username = participant['username'] ?? 'User';
    final avatar = participant['avatar'] as String?;
    final isMe = participant['userId'] == _userId;
    final isSpeaking = !isMuted;

    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E2E), // Dark card background
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSpeaking ? Colors.greenAccent : Colors.transparent,
              width: isSpeaking ? 2 : 0,
            ),
            boxShadow: isSpeaking
                ? [
                    BoxShadow(
                      color: Colors.greenAccent.withValues(alpha: 0.2),
                      blurRadius: 10,
                      spreadRadius: 1,
                    )
                  ]
                : null,
          ),
          child: Stack(
            children: [
              // Center Avatar
              Center(
                child: AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    final scale = isSpeaking ? _pulseAnimation.value : 1.0;
                    return Transform.scale(
                      scale: scale,
                      child: CircleAvatar(
                        radius: 36,
                        backgroundColor: AppColors.brandViolet.withValues(alpha: 0.3),
                        backgroundImage: avatar != null ? NetworkImage(avatar) : null,
                        child: avatar == null
                            ? Text(
                                username.isNotEmpty ? username[0].toUpperCase() : '?',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),
                    );
                  },
                ),
              ),

              // Username and mic status at bottom left/right
              Positioned(
                left: 12,
                right: 12,
                bottom: 12,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        isMe ? '$username (Bạn)' : username,
                        style: TextStyle(
                          color: isMe ? AppColors.brandViolet : Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: isMuted ? Colors.red.withValues(alpha: 0.2) : Colors.black.withValues(alpha: 0.4),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isMuted ? Icons.mic_off : Icons.mic,
                        size: 14,
                        color: isMuted ? Colors.red.shade300 : Colors.greenAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildControlBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Mute/Unmute button
            GestureDetector(
              onTap: _toggleMic,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: _isMuted
                        ? [Colors.grey.shade700, Colors.grey.shade800]
                        : [AppColors.brandViolet, const Color(0xFF7C3AED)],
                  ),
                  boxShadow: !_isMuted
                      ? [
                          BoxShadow(
                            color: AppColors.brandViolet.withValues(alpha: 0.4),
                            blurRadius: 16,
                            spreadRadius: 2,
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  _isMuted ? Icons.mic_off : Icons.mic,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),

            // Leave button
            GestureDetector(
              onTap: _leaveRoom,
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.red.shade600, Colors.red.shade800],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withValues(alpha: 0.3),
                      blurRadius: 12,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.call_end,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
