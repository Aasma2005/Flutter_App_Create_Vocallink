import 'package:flutter/material.dart';
import 'audio_call_screen.dart';
import 'video_call_screen.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final TextEditingController searchController =
      TextEditingController();

  final List<Map<String, dynamic>> contacts = [
    {
      'name': 'Sarah Johnson',
      'email': 'sarah@gmail.com',
      'online': true,
      'color': Colors.purple,
    },
    {
      'name': 'John Smith',
      'email': 'john@gmail.com',
      'online': false,
      'color': Colors.orange,
    },
    {
      'name': 'Alex Wilson',
      'email': 'alex@gmail.com',
      'online': true,
      'color': Colors.blue,
    },
    {
      'name': 'Emily Davis',
      'email': 'emily@gmail.com',
      'online': true,
      'color': Colors.green,
    },
    {
      'name': 'Michael Brown',
      'email': 'michael@gmail.com',
      'online': false,
      'color': Colors.red,
    },
    {
      'name': 'Jessica Taylor',
      'email': 'jessica@gmail.com',
      'online': true,
      'color': Colors.teal,
    },
  ];

  List<Map<String, dynamic>> filteredContacts = [];

  @override
  void initState() {
    super.initState();
    filteredContacts = contacts;
    searchController.addListener(filterContacts);
  }

  void filterContacts() {
    final query = searchController.text.toLowerCase();

    setState(() {
      filteredContacts = contacts.where((contact) {
        return contact['name']
            .toString()
            .toLowerCase()
            .contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              10,
              20,
              15,
            ),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search people...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          searchController.clear();
                        },
                        icon: const Icon(Icons.close),
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: filteredContacts.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_search,
                          size: 60,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'No contacts found',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    itemCount: filteredContacts.length,
                    itemBuilder: (context, index) {
                      return _contactTile(
                        filteredContacts[index],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _contactTile(Map<String, dynamic> contact) {
    final bool online = contact['online'];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: contact['color'],
                child: Text(
                  contact['name']
                      .toString()
                      .substring(0, 1),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              if (online)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 14,
                    width: 14,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  online ? 'Online' : 'Offline',
                  style: TextStyle(
                    color: online
                        ? Colors.green
                        : Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {
              Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AudioCallScreen(
          userName: contact['name'],
        ),
      ),
    );
            },
            style: IconButton.styleFrom(
              backgroundColor:
                  Color.fromRGBO(76, 175, 79, 1),
            ),
            icon: const Icon(
              Icons.call,
              color: Colors.green,
            ),
          ),

          IconButton(
            onPressed: () {
              Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoCallScreen(
          userName: contact['name'],
        ),
      ),
    );
            },
            style: IconButton.styleFrom(
              backgroundColor:
                  Color.fromARGB(255, 49, 85, 231)
            ),
            icon: const Icon(
              Icons.videocam,
              color: Color(0xFF3155E7),
            ),
          ),
        ],
      ),
    );
  }
}