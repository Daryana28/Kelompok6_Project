import 'package:flutter/material.dart';

class PelanggaranKendaraan extends StatefulWidget {
  const PelanggaranKendaraan({super.key});

  @override
  _PelanggaranKendaraanState createState() => _PelanggaranKendaraanState();
}

class _PelanggaranKendaraanState extends State<PelanggaranKendaraan> {
  bool showViolationImage = false;

  void toggleViolationImage() {
    setState(() {
      showViolationImage = !showViolationImage;
    });
  }

  void showFullScreenImage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const FullScreenImage(imagePath: 'images/pelanggaranKendaraan.jpg'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F4F4F),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // **Header**
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFFF0F8FF),
                      size: 30,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'Pelanggaran Kendaraan',
                    style: TextStyle(
                      color: Color(0xFFF0F8FF),
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // **Card Pelanggaran**
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F8FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // **Tanggal**
                  const Text(
                    "Kamis, 06 Maret 2025",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // **Informasi Kamera & Area**
                  Row(
                    children: [
                      Image.asset(
                        'images/motor.png', // Pastikan path benar
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 10),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Camera  : Camera 1",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Area        : Masuk",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // **Deskripsi Pelanggaran**
                  const Text(
                    "Telah terjadi Pelanggaran Kendaraan dikarenakan tidak mematuhi aturan lalu lintas di area masuk.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // **Gambar Pelanggaran (jika ditampilkan)**
                  if (showViolationImage)
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'images/pelanggaranKendaraan.jpg', // Pastikan path benar
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // **Ikon untuk memperbesar gambar**
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () => showFullScreenImage(context),
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Icon(
                                Icons.fullscreen,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 10),

                  // **Tombol Lihat Pelanggaran / Back**
                  Center(
                    child: ElevatedButton(
                      onPressed: toggleViolationImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      child: Text(
                        showViolationImage ? "Back" : "Lihat Pelanggaran",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
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

/// **Tampilan layar penuh untuk gambar pelanggaran**
class FullScreenImage extends StatelessWidget {
  final String imagePath;

  const FullScreenImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                imagePath,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
