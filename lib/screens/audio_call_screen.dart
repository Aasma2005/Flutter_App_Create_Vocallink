import 'dart:async';

import 'package:flutter/material.dart';

class AudioCallScreen extends StatefulWidget {
  final String userName;

  const AudioCallScreen({
    super.key,
    required this.userName,
  });

  @override
  State<AudioCallScreen> createState() => _AudioCallScreenState();
}

class _AudioCallScreenState extends State<AudioCallScreen> {
  bool isMuted = false;
  bool isSpeakerOn = true;

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
      backgroundColor: const Color(0xFF172554),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 25),

            // Header
            Row(
              children: [
                IconButton(
                  onPressed: endCall,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Audio Call',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),

            const Spacer(),

            // Profile
            Container(
              height: 145,
              width: 145,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 1),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                backgroundColor: const Color(0xFF6366F1),
                child: Text(
                  widget.userName.substring(0, 1),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 52,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            Text(
              widget.userName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Connected',
              style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              durationText,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 17,
                letterSpacing: 1,
              ),
            ),

            const Spacer(),

            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _callControl(
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

                const SizedBox(width: 25),

                _callControl(
                  icon: isSpeakerOn
                      ? Icons.volume_up
                      : Icons.volume_off,
                  label: isSpeakerOn ? 'Speaker' : 'Speaker Off',
                  active: isSpeakerOn,
                  onTap: () {
                    setState(() {
                      isSpeakerOn = !isSpeakerOn;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 35),

            // End button
            GestureDetector(
              onTap: endCall,
              child: Container(
                height: 68,
                width: 68,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.call_end,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),

            const SizedBox(height: 45),
          ],
        ),
      ),
    );
  }

  Widget _callControl({
    required IconData icon,
    required String label,
    required bool active,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(35),
          child: Container(
            height: 58,
            width: 58,
            decoration: BoxDecoration(
              color: active
                  ? Colors.white
                  : const Color.fromRGBO(255, 255, 255, 1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: active
                  ? const Color(0xFF172554)
                  : Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}