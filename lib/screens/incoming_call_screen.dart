import 'package:flutter/material.dart';

import 'audio_call_screen.dart';
import 'video_call_screen.dart';

class IncomingCallScreen extends StatefulWidget {
  final String callerName;
  final bool isVideoCall;

  const IncomingCallScreen({
    super.key,
    required this.callerName,
    required this.isVideoCall,
  });

  @override
  State<IncomingCallScreen> createState() =>
      _IncomingCallScreenState();
}

class _IncomingCallScreenState
    extends State<IncomingCallScreen> {
  void acceptCall() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget.isVideoCall
            ? VideoCallScreen(
                userName: widget.callerName,
              )
            : AudioCallScreen(
                userName: widget.callerName,
              ),
      ),
    );
  }

  void declineCall() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF172554),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),

            Text(
              widget.isVideoCall
                  ? 'Incoming Video Call'
                  : 'Incoming Audio Call',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),

            const Spacer(),

            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 1),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                backgroundColor: const Color(0xFF6366F1),
                child: Text(
                  widget.callerName.substring(0, 1),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            Text(
              widget.callerName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Calling you...',
              style: TextStyle(
                color: Colors.white60,
                fontSize: 15,
              ),
            ),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Decline
                Column(
                  children: [
                    GestureDetector(
                      onTap: declineCall,
                      child: Container(
                        height: 70,
                        width: 70,
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
                    const SizedBox(height: 10),
                    const Text(
                      'Decline',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                // Accept
                Column(
                  children: [
                    GestureDetector(
                      onTap: acceptCall,
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          widget.isVideoCall
                              ? Icons.videocam
                              : Icons.call,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Accept',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}