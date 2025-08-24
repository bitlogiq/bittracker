import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logo Page',
      debugShowCheckedModeBanner: false,
      home: const LogoPage(),
    );
  }
}

class LogoPage extends StatelessWidget {
  const LogoPage({super.key});

  static const Color _background = Color(0xFF263643);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double logoSize;
    if (screenWidth < 400) {
      logoSize = screenWidth * 0.5;
    } else if (screenWidth < 800) {
      logoSize = screenWidth * 0.35;
    } else {
      logoSize = screenWidth * 0.25;
    }

    return Scaffold(
      backgroundColor: _background,
      body: Center(
        child: Image.asset(
          'lib/assets/logo.png', // 👈 must match pubspec.yaml
          width: logoSize,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
