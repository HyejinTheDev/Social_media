import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class OfflineBanner extends StatefulWidget {
  final Widget child;

  const OfflineBanner({super.key, required this.child});

  @override
  State<OfflineBanner> createState() => _OfflineBannerState();
}

class _OfflineBannerState extends State<OfflineBanner> {
  bool _isOffline = false;

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      if (!mounted) return;
      final isOffline = results.every((r) => r == ConnectivityResult.none);
      if (isOffline != _isOffline) {
        setState(() {
          _isOffline = isOffline;
        });
      }
    });
    
    Connectivity().checkConnectivity().then((List<ConnectivityResult> results) {
      if (!mounted) return;
      final isOffline = results.every((r) => r == ConnectivityResult.none);
      if (isOffline) {
        setState(() {
          _isOffline = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_isOffline)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Material(
                color: Colors.red,
                elevation: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  alignment: Alignment.center,
                  child: const Text(
                    'Không có kết nối mạng',
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
