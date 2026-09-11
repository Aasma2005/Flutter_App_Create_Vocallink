import 'package:flutter/material.dart';

import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool notifications = true;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        20,
        15,
        20,
        30,
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),

          Stack(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8EDFF),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'AS',
                    style: TextStyle(
                      color: Color(0xFF3155E7),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Positioned(
                right: 0,
                bottom: 3,
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3155E7),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          const Text(
            'Aasma Shaikh',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'aasma@example.com',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(76, 175, 80, 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              '● Online',
              style: TextStyle(
                color: Colors.green,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 30),

          _profileOption(
            icon: Icons.person_outline,
            title: 'Edit Profile',
            subtitle: 'Update your personal information',
            onTap: () {},
          ),

          _profileOption(
            icon: Icons.notifications_none,
            title: 'Notifications',
            subtitle: 'Manage call notifications',
            trailing: Switch(
              value: notifications,
              onChanged: (value) {
                setState(() {
                  notifications = value;
                });
              },
            ),
            onTap: () {},
          ),

          _profileOption(
            icon: Icons.dark_mode_outlined,
            title: 'Dark Mode',
            subtitle: 'Change application appearance',
            trailing: Switch(
              value: darkMode,
              onChanged: (value) {
                setState(() {
                  darkMode = value;
                });
              },
            ),
            onTap: () {},
          ),

          _profileOption(
            icon: Icons.info_outline,
            title: 'About ConnectCall',
            subtitle: 'Version 1.0.0',
            onTap: () {},
          ),

          const SizedBox(height: 15),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const LoginScreen(),
                  ),
                  (route) => false,
                );
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              label: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: const Color.fromRGBO(244, 67, 54, 1),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        leading: Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: const Color(0xFFE8EDFF),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF3155E7),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 11,
          ),
        ),
        trailing: trailing ??
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
      ),
    );
  }
}