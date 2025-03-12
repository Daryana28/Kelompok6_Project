import 'package:flutter/material.dart';
import 'pages/LoginScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safetec Login',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF23417F)),
        useMaterial3: true,
        fontFamily: 'Inter',
        scaffoldBackgroundColor:
            const Color(0xFF2F4F4F), // Set default background color
      ),
      home: const LoginScreen(),
    );
  }
}
