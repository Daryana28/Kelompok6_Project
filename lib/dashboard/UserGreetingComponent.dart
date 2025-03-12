import 'package:flutter/material.dart';
import 'package:flutter_application_5/pelanggaran/PelanggaranKendaraan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cctv/AreaSelectionScreen.dart';
import '../pelanggaran/PelanggaranApdScreen.dart'; // Import the PelanggaranApdScreen

class UserGreetingComponent extends StatefulWidget {
  const UserGreetingComponent({super.key});

  @override
  _UserGreetingComponentState createState() => _UserGreetingComponentState();
}

class _UserGreetingComponentState extends State<UserGreetingComponent> {
  String userName = 'User';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('name') ?? 'User';
    });
  }

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
      color: const Color(0xFF2F4F4F),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting section
            Row(
              children: [
                Image.asset(
                  'images/halo.png',
                  width: 30,
                  height: 30,
                ),
                const SizedBox(width: 8),
                Text(
                  'Hi, $userName',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                    color: Color(0xFFF0F8FF),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // First row of icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCard(
                  'CCTV',
                  'images/cctv1.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AreaSelectionScreen(),
                      ),
                    );
                  },
                ),
                _buildCard(
                  'P. Apd',
                  'images/helm.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PelanggaranApdScreen(),
                      ),
                    );
                  },
                ),
                _buildCard(
                  'P. Forklift',
                  'images/forklift.png',
                  onTap: () => _showComingSoon(context),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Second row of icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCard(
                  'P. Pejalan',
                  'images/jalan.png',
                  onTap: () => _showComingSoon(context),
                ),
                _buildCard(
                  'P. Kendaraan',
                  'images/motor.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PelanggaranKendaraan(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 50),

            // Bottom row of blue cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildButton(
                  'Hub 123456',
                  'images/telfon.png',
                  onTap: () => _showComingSoon(context),
                ),
                _buildButton(
                  'Chat us',
                  'images/wa.png',
                  onTap: () => _showComingSoon(context),
                ),
                _buildButton(
                  'Help',
                  'images/tanya.png',
                  onTap: () => _showComingSoon(context),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String label, String iconUrl, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 90,
        height: 109,
        child: Column(
          children: [
            Container(
              width: 90,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF2F4F4F),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFF0F8FF).withOpacity(0.8),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
                border: Border.all(color: const Color(0xFFF0F8FF), width: 2),
              ),
              child: Center(
                child: Image.asset(
                  iconUrl,
                  width: 60,
                  height: 60,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontFamily: 'Inter',
                color: Color(0xFFF0F8FF),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String label, String iconUrl, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 90,
        decoration: BoxDecoration(
          color: const Color(0xFF2F4F4F),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFF0F8FF), width: 2),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFF0F8FF).withOpacity(0.8),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconUrl,
              width: 45,
              height: 45,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 13,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
