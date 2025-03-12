import 'package:flutter/material.dart';
import 'package:flutter_application_5/pages/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../profile/ProfileScreen.dart';

class SidebarComponent extends StatefulWidget {
  final VoidCallback onClose;

  const SidebarComponent({super.key, required this.onClose});

  @override
  _SidebarComponentState createState() => _SidebarComponentState();
}

class _SidebarComponentState extends State<SidebarComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  File? _profileImage;
  String userName = 'User';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<double>(begin: -250, end: 0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('name') ?? 'User';
      String? imagePath = prefs.getString('profileImage');
      if (imagePath != null) {
        _profileImage = File(imagePath);
      }
    });
  }

  void _closeSidebar() {
    _animationController.reverse().then((_) => widget.onClose());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background
        GestureDetector(
          onTap: _closeSidebar,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(0.3),
          ),
        ),
        // Sidebar
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Positioned(
              left: _slideAnimation.value,
              top: 0,
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  color: const Color(0xFF2F4F4F).withOpacity(0.9),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: [
                    // Close Button
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: IconButton(
                          icon: const Icon(Icons.close,
                              color: Colors.white, size: 28),
                          onPressed: _closeSidebar,
                        ),
                      ),
                    ),
                    // Profile Image
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : const AssetImage('images/avatar.png')
                              as ImageProvider,
                    ),
                    const SizedBox(height: 10),
                    // User Name
                    Text(
                      userName,
                      style: const TextStyle(
                        color: Color(0xFFF0F8FF),
                        fontSize: 21,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Profile Button
                    _buildMenuItem(
                      icon: Icons.person,
                      label: 'Profile',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    // Logout Button
                    _buildMenuItem(
                      icon: Icons.logout,
                      label: 'Logout',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                        // Add logout action
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFFF0F8FF),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            if (label == 'Profile')
              const Icon(Icons.arrow_forward_ios,
                  size: 18, color: Colors.white),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
