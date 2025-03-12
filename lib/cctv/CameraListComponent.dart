import 'package:flutter/material.dart';
import 'package:flutter_application_5/cctv/AreaSelectionScreen.dart';
import 'CameraScreenSatu.dart'; // Pastikan file ini sesuai dengan lokasi class CameraScreenSatu
import 'CameraScreenDua.dart'; // Tambahkan import untuk CameraScreenDua

class CameraListComponent extends StatefulWidget {
  const CameraListComponent({super.key});

  @override
  _CameraListComponentState createState() => _CameraListComponentState();
}

class _CameraListComponentState extends State<CameraListComponent> {
  final TextEditingController _searchController = TextEditingController();
  List<String> allCameras = List.generate(4, (index) => 'Camera ${index + 1}');
  List<String> filteredCameras = [];

  @override
  void initState() {
    super.initState();
    filteredCameras = allCameras;
  }

  void _filterCameras(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCameras = allCameras;
      } else {
        filteredCameras = allCameras
            .where(
                (camera) => camera.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _onCameraSelected(BuildContext context, String cameraName) {
    if (cameraName == "Camera 1") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CameraScreenSatu()),
      );
    } else if (cameraName == "Camera 2") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CameraScreenDua()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "$cameraName belum tersedia",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.black87,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _navigeToAreaSelection(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AreaSelectionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F4F4F),
      appBar: AppBar(
        title: const Text(
          'Cari Camera',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2F4F4F),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => _navigeToAreaSelection(context),
        ),
      ),
      body: Column(
        children: [
          // 🔍 **Search Bar dengan Efek Neon**
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF0F8FF),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _filterCameras,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  hintText: 'Cari Camera',
                  hintStyle: TextStyle(color: Colors.black54),
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),

          // 📷 **Daftar Kamera**
          Expanded(
            child: ListView.separated(
              itemCount: filteredCameras.length,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
                height: 0.5,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () =>
                      _onCameraSelected(context, filteredCameras[index]),
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 45,
                              height: 45,
                              margin: const EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF0F8FF),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.5),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.videocam,
                                  color: Colors.black, size: 30),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              filteredCameras[index],
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 25,
                          height: 25,
                          margin: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F8FF),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.5),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: const Icon(Icons.arrow_forward,
                              color: Colors.black, size: 20),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
