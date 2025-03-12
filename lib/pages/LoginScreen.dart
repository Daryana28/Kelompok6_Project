import 'package:flutter/material.dart';
import '../dashboard/HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Data user yang valid
  final String validUser = "12345";
  final String validPassword = "12345";

  void _login() {
    String userInput = _idController.text;
    String passwordInput = _passwordController.text;

    if (userInput == validUser && passwordInput == validPassword) {
      // Jika login berhasil
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // Jika login gagal, tampilkan error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Username atau Password salah!",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 47, 79, 79), // Latar belakang Dark Slate Gray
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 43.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 80),

                // Logo
                Container(
                  width: 280,
                  height: 190,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage('images/logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 100),

                // Input ID
                _buildInputField(
                  controller: _idController,
                  hintText: 'ID User',
                  iconPath: 'images/profil.png',
                ),

                const SizedBox(height: 20),

                // Input Password
                _buildInputField(
                  controller: _passwordController,
                  hintText: 'Password',
                  iconPath: 'images/kunci.png',
                  obscureText: true,
                ),

                const SizedBox(height: 20),

                // Tombol Login
                SizedBox(
                  width: 315,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: _login, // Cek login saat ditekan
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromRGBO(240, 248, 255, 1), // Alice Blue
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                      shadowColor: const Color(0xFFF0F8FF).withOpacity(0.8),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Color(0xFF2F4F4F), // Dark Slate Gray (kontras)
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// **Input field dengan warna sesuai tema**
  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required String iconPath,
    bool obscureText = false,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF2F4F4F), // Latar belakang sesuai tema
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFF0F8FF)), // Neon Blue border
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF0F8FF).withOpacity(0.8), // Efek neon
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Image.asset(
              iconPath,
              width: 30,
              height: 30,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              style: const TextStyle(
                color: Color(0xFFF0F8FF), // Teks neon biru
                fontSize: 15,
                fontFamily: 'Inter',
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: Color(0x80F0F8FF), // Warna neon redup
                  fontSize: 15,
                  fontFamily: 'Inter',
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
