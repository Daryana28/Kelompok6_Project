import 'package:flutter/material.dart';
import 'CameraListComponent.dart';
import 'AreaMasukScreen.dart';
import 'AreaFingerprintScreen.dart';

class AreaSelectionScreen extends StatelessWidget {
  const AreaSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> areas = [
      {
        'title': 'Area Masuk',
        'image': 'images/gate.png',
        'screen': const AreaMasukScreen()
      },
      {
        'title': 'Area Fingerprint',
        'image': 'images/finger.png',
        'screen': const AreaFingerprintScreen()
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF2F4F4F),
      appBar: AppBar(
        title: const Text(
          'Pilih Area',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2F4F4F),
        centerTitle: true,
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
            // 🔍 **Search Bar dengan efek neon**
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CameraListComponent()),
                );
              },
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F8FF),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.black),
                    SizedBox(width: 10),
                    Text(
                      'Cari Camera',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 📌 **Judul Area Camera**
            const Text(
              'Area Camera',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            const SizedBox(height: 4),
            const Text(
              'Pilih area lalu klik untuk melihat CCTV',
              style: TextStyle(fontSize: 15, color: Colors.white70),
            ),
            const SizedBox(height: 20),

            // 📷 **List Area dengan Efek Neon**
            Expanded(
              child: ListView.builder(
                itemCount: areas.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: GestureDetector(
                      onTap: () {
                        // Navigasi ke screen yang sesuai
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => areas[index]['screen'],
                          ),
                        );
                      },
                      child: Container(
                        height: 180,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F8FF),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                          image: DecorationImage(
                            image: AssetImage(areas[index]['image']!),
                            fit: BoxFit.cover,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          areas[index]['title']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 5.0,
                                color: Colors.black,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
