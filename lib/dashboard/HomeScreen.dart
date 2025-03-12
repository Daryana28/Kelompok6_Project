/* lib/dashboard/HomeScreen.dart */
import 'package:flutter/material.dart';
import 'SidebarComponent.dart';
import 'HeaderComponent.dart';
import 'ViolationInfoComponent.dart';
import 'UserGreetingComponent.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSidebarOpen = false;

  void _toggleSidebar() {
    setState(() {
      _isSidebarOpen = !_isSidebarOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: ListView(
              physics: const BouncingScrollPhysics(), // Smooth scroll effect
              children: const [
                HeaderComponent(), // Top header
                SizedBox(height: 10), // Space
                ViolationInfoComponent(), // Violation info section
                SizedBox(height: 10), // Space
                UserGreetingComponent(), // User greeting section
                // **Main page content**
              ],
            ),
          ),
          if (_isSidebarOpen)
            SidebarComponent(
              onClose: _toggleSidebar,
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleSidebar,
        child: const Icon(Icons.menu),
      ),
    );
  }
}
