import 'dart:async';

import 'package:flutter/material.dart';

class VideoCallScreen extends StatefulWidget {
  final String userName;

  const VideoCallScreen({
    super.key,
    required this.userName,
  });

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  bool isMuted = false;
  bool cameraOn = true;
  bool frontCamera = true;

  int seconds = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (mounted) {
          setState(() {
            seconds++;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String get durationText {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void endCall() {
    timer?.cancel();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Remote video placeholder
          Positioned.fill(
            child: Container(
              color: const Color(0xFF202124),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: const Color(0xFF6366F1),
                    child: Text(
                      widget.userName.substring(0, 1),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    widget.userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    durationText,
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Top information
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: endCall,
                    child: Container(
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const Spacer(),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 0, 0, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.green,
                          size: 9,
                        ),
                        SizedBox(width: 7),
                        Text(
                          'Connected',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Local camera preview
          Positioned(
            top: 90,
            right: 18,
            child: Container(
              height: 175,
              width: 120,
              decoration: BoxDecoration(
                color: const Color(0xFF343434),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.white30,
                  width: 1,
                ),
              ),
              child: cameraOn
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.person,
                          color: Colors.white54,
                          size: 45,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          frontCamera
                              ? 'Front Camera'
                              : 'Rear Camera',
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    )
                  : const Icon(
                      Icons.videocam_off,
                      color: Colors.white,
                      size: 30,
                    ),
            ),
          ),

          // Bottom controls
          Positioned(
            bottom: 35,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _control(
                        icon: isMuted
                            ? Icons.mic_off
                            : Icons.mic,
                        label: isMuted ? 'Unmute' : 'Mute',
                        active: isMuted,
                        onTap: () {
                          setState(() {
                            isMuted = !isMuted;
                          });
                        },
                      ),

                      const SizedBox(width: 18),

                      _control(
                        icon: cameraOn
                            ? Icons.videocam
                            : Icons.videocam_off,
                        label: cameraOn ? 'Camera' : 'Camera Off',
                        active: !cameraOn,
                        onTap: () {
                          setState(() {
                            cameraOn = !cameraOn;
                          });
                        },
                      ),

                      const SizedBox(width: 18),

                      _control(
                        icon: Icons.cameraswitch,
                        label: 'Switch',
                        active: false,
                        onTap: () {
                          setState(() {
                            frontCamera = !frontCamera;
                          });
                        },
                      ),

                      const SizedBox(width: 18),

                      _control(
                        icon: Icons.call_end,
                        label: 'End',
                        active: true,
                        end: true,
                        onTap: endCall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _control({
    required IconData icon,
    required String label,
    required bool active,
    required VoidCallback onTap,
    bool end = false,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: end
                  ? Colors.red
                  : active
                      ? Colors.white
                      : const Color.fromRGBO(255, 255, 255, 1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: end
                  ? Colors.white
                  : active
                      ? Colors.black
                      : Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 7),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}