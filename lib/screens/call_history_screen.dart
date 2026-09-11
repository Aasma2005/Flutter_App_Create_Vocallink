import 'package:flutter/material.dart';

class CallHistoryScreen extends StatefulWidget {
  const CallHistoryScreen({super.key});

  @override
  State<CallHistoryScreen> createState() =>
      _CallHistoryScreenState();
}

class _CallHistoryScreenState
    extends State<CallHistoryScreen> {
  final List<Map<String, dynamic>> calls = [
    {
      'name': 'Sarah Johnson',
      'type': 'Video Call',
      'time': 'Today, 11:45 AM',
      'duration': '02:35',
      'incoming': false,
      'missed': false,
    },
    {
      'name': 'John Smith',
      'type': 'Audio Call',
      'time': 'Yesterday, 06:20 PM',
      'duration': 'Missed',
      'incoming': true,
      'missed': true,
    },
    {
      'name': 'Alex Wilson',
      'type': 'Audio Call',
      'time': 'Yesterday, 02:15 PM',
      'duration': '05:12',
      'incoming': true,
      'missed': false,
    },
    {
      'name': 'Emily Davis',
      'type': 'Video Call',
      'time': 'Sep 5, 09:30 AM',
      'duration': '10:42',
      'incoming': false,
      'missed': false,
    },
    {
      'name': 'Michael Brown',
      'type': 'Audio Call',
      'time': 'Sep 4, 07:45 PM',
      'duration': '01:21',
      'incoming': false,
      'missed': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        20,
        10,
        20,
        20,
      ),
      itemCount: calls.length,
      itemBuilder: (context, index) {
        final call = calls[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 27,
                backgroundColor: const Color(0xFFE8EDFF),
                child: Icon(
                  call['type'] == 'Video Call'
                      ? Icons.videocam
                      : Icons.call,
                  color: const Color(0xFF3155E7),
                ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      call['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Row(
                      children: [
                        Icon(
                          call['incoming']
                              ? Icons.call_received
                              : Icons.call_made,
                          size: 14,
                          color: call['missed']
                              ? Colors.red
                              : Colors.green,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          call['type'],
                          style: TextStyle(
                            color: call['missed']
                                ? Colors.red
                                : Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 3),

                    Text(
                      call['time'],
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                call['duration'],
                style: TextStyle(
                  color: call['missed']
                      ? Colors.red
                      : Colors.grey,
                  fontWeight: call['missed']
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}