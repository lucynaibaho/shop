import 'package:flutter/material.dart';

import 'screens/login_page.dart';

void main() => runApp(const ShopApp());

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF19745E);
    return MaterialApp(
      title: 'Ruang Belanja',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F7F2),
        colorScheme: ColorScheme.fromSeed(
          seedColor: green,
          primary: green,
          secondary: const Color(0xFFE8914A),
          surface: const Color(0xFFF7F7F2),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF7F7F2),
          foregroundColor: Color(0xFF142D2A),
          surfaceTintColor: Colors.transparent,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE2E6E0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE2E6E0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: green, width: 1.5),
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}
