import 'package:flutter/material.dart';

import 'contacts_screen.dart';
import 'call_history_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<Widget> screens = const [
    HomeContent(),
    ContactsScreen(),
    CallHistoryScreen(),
    ProfileScreen(),
  ];

  final List<String> titles = const [
    'ConnectCall',
    'Contacts',
    'Call History',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: selectedIndex == 0
          ? null
          : AppBar(
              title: Text(
                titles[selectedIndex],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
      body: screens[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Contacts',
          ),
          NavigationDestination(
            icon: Icon(Icons.call_outlined),
            selectedIcon: Icon(Icons.call),
            label: 'Calls',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> users = [
    {
      'name': 'Sarah Johnson',
      'status': 'Online',
      'color': Colors.purple,
    },
    {
      'name': 'John Smith',
      'status': 'Online',
      'color': Colors.orange,
    },
    {
      'name': 'Alex Wilson',
      'status': 'Offline',
      'color': Colors.blue,
    },
    {
      'name': 'Emily Davis',
      'status': 'Online',
      'color': Colors.green,
    },
  ];

  List<Map<String, dynamic>> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    filteredUsers = users;

    searchController.addListener(searchUsers);
  }

  void searchUsers() {
    final query = searchController.text.toLowerCase();

    setState(() {
      filteredUsers = users.where((user) {
        return user['name']
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
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                CircleAvatar(
                  radius: 27,
                  backgroundColor: const Color(0xFFE8EDFF),
                  child: const Text(
                    'AS',
                    style: TextStyle(
                      color: Color(0xFF3155E7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Morning 👋',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Aasma Shaikh',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_none_rounded,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // Search
            TextField(
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

            const SizedBox(height: 28),

            // Quick actions
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: _quickAction(
                    icon: Icons.call,
                    title: 'Audio Call',
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _quickAction(
                    icon: Icons.videocam,
                    title: 'Video Call',
                    onTap: () {},
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Available People',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('See All'),
                ),
              ],
            ),

            const SizedBox(height: 10),

            if (filteredUsers.isEmpty)
              _emptySearch()
            else
              ...filteredUsers.map(
                (user) => _userCard(user),
              ),

            const SizedBox(height: 20),

            const Text(
              'Recent Calls',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            _recentCall(
              name: 'Sarah Johnson',
              time: 'Today, 11:45 AM',
              duration: '02:35',
              video: true,
              missed: false,
            ),

            _recentCall(
              name: 'John Smith',
              time: 'Yesterday, 06:20 PM',
              duration: 'Missed',
              video: false,
              missed: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _quickAction({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF3155E7),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            const SizedBox(width: 2),
            Icon(
              icon,
              color: Colors.white,
              size: 28,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userCard(Map<String, dynamic> user) {
    final bool online = user['status'] == 'Online';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 27,
                backgroundColor: user['color'],
                child: Text(
                  user['name']
                      .toString()
                      .substring(0, 1),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (online)
                Positioned(
                  right: 1,
                  bottom: 1,
                  child: Container(
                    height: 13,
                    width: 13,
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
                  user['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user['status'],
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

          _smallCallButton(
            Icons.call,
            Colors.green,
            () {},
          ),

          const SizedBox(width: 7),

          _smallCallButton(
            Icons.videocam,
            const Color(0xFF3155E7),
            () {},
          ),
        ],
      ),
    );
  }

  Widget _smallCallButton(
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: color,
          size: 20,
        ),
      ),
    );
  }

  Widget _recentCall({
    required String name,
    required String time,
    required String duration,
    required bool video,
    required bool missed,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xFFE8EDFF),
            child: Icon(
              video ? Icons.videocam : Icons.call,
              color: const Color(0xFF3155E7),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          Text(
            duration,
            style: TextStyle(
              color: missed ? Colors.red : Colors.grey,
              fontWeight: missed
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptySearch() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(35),
      child: const Column(
        children: [
          Icon(
            Icons.search_off,
            size: 50,
            color: Colors.grey,
          ),
          SizedBox(height: 10),
          Text(
            'No people found',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}