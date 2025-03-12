/* lib/dashboard/HeaderComponent.dart */
import 'package:flutter/material.dart';
import '../profile/ProfileScreen.dart'; // Import the ProfileScreen

class HeaderComponent extends StatelessWidget {
  const HeaderComponent({super.key});

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Coming Soon",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.black87,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: Color(0xFF2F4F4F), // Dark Slate Gray for header
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end, // Align items to the right
        children: [
          // Right side icons
          IconButton(
            icon:
                const Icon(Icons.notifications_none, color: Color(0xFFF0F8FF)),
            onPressed: () {
              _showComingSoon(context); // Menampilkan SnackBar "Coming Soon"
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: Color(0xFFF0F8FF)),
            onPressed: () {
              // Navigate to ProfileScreen on profile icon click
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
