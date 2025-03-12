import 'package:flutter/material.dart';
import 'CameraScreenSatu.dart'; // Import halaman sebelumnya
import 'CameraListComponent.dart'; // Import Camera List

class CameraScreenDua extends StatelessWidget {
  const CameraScreenDua({super.key});

  void _navigateToFullScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FullScreenCameraViewDua()),
    );
  }

  void _navigateToPreviousCamera(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const CameraScreenSatu()),
    );
  }

  void _navigateToCameraList(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const CameraListComponent()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F4F4F),
      appBar: AppBar(
        title: const Text(
          'Camera 2',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2F4F4F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () =>
              _navigateToCameraList(context), // Kembali ke CameraListComponent
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // **Tampilan Kamera dengan Tombol Fullscreen**
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
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

                // **Tombol Fullscreen di Kanan Bawah**
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () => _navigateToFullScreen(context),
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

            const SizedBox(height: 30),

            // **Tombol Navigasi Kamera**
            Container(
              width: 260,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.5),
                borderRadius: BorderRadius.circular(30),
                color: Colors.transparent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // **Tombol Panah Kembali ke Camera 1**
                  GestureDetector(
                    onTap: () => _navigateToPreviousCamera(context),
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(Icons.arrow_back,
                          color: Colors.black, size: 24),
                    ),
                  ),

                  // **Teks Camera 2 (Centered)**
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Camera 2",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),

                  // **Tombol Panah Navigasi ke Camera 3**
                  GestureDetector(
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(Icons.arrow_forward,
                          color: Colors.black, size: 24),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// **Fullscreen Camera View untuk Camera 2**
class FullScreenCameraViewDua extends StatelessWidget {
  const FullScreenCameraViewDua({super.key});

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
        title: const Text("Camera 2", style: TextStyle(color: Colors.white)),
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
          // **Kontrol Kamera (Mute/Unmute & Fullscreen)**
          Container(
            color: Colors.black,
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.volume_up, color: Colors.white, size: 30),
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
