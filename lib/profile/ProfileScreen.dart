import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'EditProfileScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String name;
  late String departement;
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    name = 'User';
    departement = 'Stamping';
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'User';
      departement = prefs.getString('departement') ?? 'Stamping';
      String? imagePath = prefs.getString('profileImage');
      if (imagePath != null) {
        _profileImage = File(imagePath);
      }
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profileImage', pickedFile.path);
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _updateProfile(String newName, String newDepartement) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', newName);
    await prefs.setString('departement', newDepartement);
    setState(() {
      name = newName;
      departement = newDepartement;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F4F4F),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: Icon(Icons.arrow_back,
                            color: Colors.black, size: 22),
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),

            // Foto Profil dengan Opsi Pilihan
            GestureDetector(
              onTap: () => _showImagePickerDialog(),
              child: Container(
                margin: const EdgeInsets.only(top: 42),
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFF0F8FF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                  image: _profileImage != null
                      ? DecorationImage(
                          image: FileImage(_profileImage!),
                          fit: BoxFit.cover,
                        )
                      : const DecorationImage(
                          image: AssetImage('images/avatar.png'),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),

            // Profile Info Card
            Container(
              margin: const EdgeInsets.only(top: 66, left: 29, right: 29),
              padding: const EdgeInsets.all(20),
              width: 343,
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
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Nama',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Inter',
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'Inter',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Departement',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Inter',
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        departement,
                        style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'Inter',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(
                              initialName: name,
                              initialDepartement: departement,
                            ),
                          ),
                        );

                        if (result != null) {
                          _updateProfile(result['name'], result['departement']);
                        }
                      },
                      child: Container(
                        width: 80,
                        height: 35,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F8FF),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Ubah',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Inter',
                              color: Colors.black,
                            ),
                          ),
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

  // Fungsi untuk menampilkan dialog pilihan gambar
  void _showImagePickerDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Pilih dari Galeri'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Ambil dari Kamera'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
          ),
        ],
      ),
    );
  }
}
