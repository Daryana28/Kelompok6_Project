import 'package:flutter/material.dart';

class AreaFingerprintScreen extends StatefulWidget {
  const AreaFingerprintScreen({super.key});

  @override
  _AreaFingerprintScreenState createState() => _AreaFingerprintScreenState();
}

class _AreaFingerprintScreenState extends State<AreaFingerprintScreen> {
  void _navigateToFullScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FullScreenCameraViewFingerprint(),
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Kamera Belum Tersedia",
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
    return Scaffold(
      backgroundColor: const Color(0xFF2F4F4F),
      appBar: AppBar(
        title: const Text(
          'Area Fingerprint',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2F4F4F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // **Tampilan Kamera**
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 325,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "Live Camera View",
                      style: TextStyle(color: Colors.white54, fontSize: 16),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: _navigateToFullScreen,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(Icons.fullscreen, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // **Informasi Lokasi Kamera dengan Image Asset**
            Row(
              children: [
                Image.asset(
                  'images/camera.png', // Ganti dengan path asset gambar fingerprint
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lokasi",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      "Camera 2",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // **List Kamera (Scroll Horizontal)**
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCameraCard(
                    "Camera ",
                    onTap: () => _showComingSoon(context),
                  ),
                  _buildCameraCard(
                    "Camera ",
                    onTap: () => _showComingSoon(context),
                  ),
                  _buildCameraCard(
                    "Camera ",
                    onTap: () => _showComingSoon(context),
                  ),
                  _buildCameraCard(
                    "Camera ",
                    onTap: () => _showComingSoon(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraCard(String label, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(right: 15), // ✅ Padding dipindah ke sini
      child: GestureDetector(
        onTap: onTap, // ✅ Menangani klik
        child: Container(
          width: 170,
          height: 185,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.videocam, color: Colors.white, size: 70),
              const SizedBox(height: 10),
              Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// **Halaman Fullscreen Kamera dengan Mute/Unmute**
class FullScreenCameraViewFingerprint extends StatefulWidget {
  const FullScreenCameraViewFingerprint({super.key});

  @override
  _FullScreenCameraViewFingerprintState createState() =>
      _FullScreenCameraViewFingerprintState();
}

class _FullScreenCameraViewFingerprintState
    extends State<FullScreenCameraViewFingerprint> {
  bool isMuted = false;

  void _toggleMute() {
    setState(() {
      isMuted = !isMuted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Camera Fingerprint",
            style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.black,
              child: const Center(
                child: Text(
                  "Live Camera View",
                  style: TextStyle(color: Colors.white54, fontSize: 18),
                ),
              ),
            ),
          ),
          // **Kontrol Kamera (Mute/Unmute)**
          Container(
            color: Colors.black,
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // **Tombol Mute/Unmute**
                IconButton(
                  icon: Icon(
                    isMuted ? Icons.volume_off : Icons.volume_up,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: _toggleMute,
                ),

                IconButton(
                  icon: const Icon(Icons.fullscreen_exit, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
