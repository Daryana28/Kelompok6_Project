import 'package:flutter/material.dart';

class YourComponent extends StatelessWidget {
  const YourComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No need to set backgroundColor explicitly if using the theme
      appBar: AppBar(
        title: const Text('Your Component'),
      ),
      body: const Center(
        child: Text('Hello, World!'),
      ),
    );
  }
}
