import 'package:flutter/material.dart';

class ViolationInfoComponent extends StatefulWidget {
  const ViolationInfoComponent({super.key});

  @override
  _ViolationInfoComponentState createState() => _ViolationInfoComponentState();
}

class _ViolationInfoComponentState extends State<ViolationInfoComponent> {
  int currentPage = 0;
  final PageController _pageController = PageController();
  bool isExpanded = false; // Mulai dalam kondisi tertutup
  double containerHeight = 60; // Default tinggi saat tertutup

  final List<Map<String, String>> violations = [
    {
      'Jenis Pelanggaran': 'Tidak Memakai APD',
      'Area': 'Masuk Gate',
      'Waktu Kejadian': '13 Februari 2025'
    },
    {
      'Jenis Pelanggaran': 'Tidak Memakai APD',
      'Area': 'FingerPrint',
      'Waktu Kejadian': '10 Januari 2025'
    },
    {
      'Jenis Pelanggaran': 'Tidak Memakai APD',
      'Area': 'Masuk Gate',
      'Waktu Kejadian': '5 Maret 2025'
    },
  ];

  void toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
      containerHeight =
          isExpanded ? 265 : 60; // Berubah sesuai kondisi expand/collapse
    });
  }

  void _goToPreviousPage() {
    if (currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNextPage() {
    if (currentPage < violations.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // **Gambar CCTV**
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            'images/cctv.png',
            height: 70,
            width: 330,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 15),

        // **AnimatedContainer untuk efek naik turun**
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: containerHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF2F4F4F), // Background utama
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.5), // Efek neon
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: [
              // **Header Info Pelanggaran**
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Info Pelanggaran',
                      style: TextStyle(
                        color: Colors.white, // Warna teks putih
                        fontSize: 14,
                        fontFamily: 'Inter',
                      ),
                    ),
                    GestureDetector(
                      onTap: toggleExpand, // Tombol naik/turun
                      child: Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // **Konten hanya muncul jika Expanded**
              if (isExpanded)
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        currentPage = page;
                      });
                    },
                    itemCount: violations.length,
                    itemBuilder: (context, index) {
                      return ViolationCard(violation: violations[index]);
                    },
                  ),
                ),

              // **Bagian "1/3" dan navigasi**
              Visibility(
                visible: isExpanded, // Akan hilang saat tertutup
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_left, color: Colors.white),
                        onPressed: _goToPreviousPage,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F8FF), // Alice Blue
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5), // Efek neon
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Text(
                          '${currentPage + 1}/${violations.length}',
                          style: const TextStyle(
                            color: Color(0xFF2F4F4F), // Warna teks gelap
                            fontSize: 11,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                      IconButton(
                        icon:
                            const Icon(Icons.arrow_right, color: Colors.white),
                        onPressed: _goToNextPage,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ViolationCard extends StatelessWidget {
  final Map<String, String> violation;

  const ViolationCard({super.key, required this.violation});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFF0F8FF), // Alice Blue
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5), // Efek neon
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: violation.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  entry.key,
                  style: const TextStyle(
                    color: Color(0xFF2F4F4F), // Warna teks gelap
                    fontSize: 13,
                    fontFamily: 'Inter',
                  ),
                ),
                Text(
                  entry.value,
                  style: const TextStyle(
                    color: Color(0xFF2F4F4F), // Warna teks gelap
                    fontSize: 13,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
