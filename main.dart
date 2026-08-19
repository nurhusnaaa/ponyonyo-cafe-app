import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Wrap Firebase init in try-catch so it won't crash if google-services.json is missing
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase init failed: $e");
  }
  runApp(const PonyonyoCafeApp());
}

class PonyonyoCafeApp extends StatelessWidget {
  const PonyonyoCafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ponyonyo Cafe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFAF7F2), // Cream White
        primaryColor: const Color(0xFFB5C9B0), // Sage Green
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF2A7BB), // Soft Blush Pink
          primary: const Color(0xFFE8899A), // Dusty Rose
          secondary: const Color(0xFFB5C9B0),
          background: const Color(0xFFFAF7F2),
        ),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.dmSerifDisplay(color: const Color(0xFF3B2A2A)),
          displayMedium: GoogleFonts.dmSerifDisplay(color: const Color(0xFF3B2A2A)),
          displaySmall: GoogleFonts.dmSerifDisplay(color: const Color(0xFF3B2A2A)),
          headlineMedium: GoogleFonts.dmSerifDisplay(color: const Color(0xFF3B2A2A)),
          titleLarge: GoogleFonts.dmSerifDisplay(color: const Color(0xFF3B2A2A)),
          bodyLarge: GoogleFonts.nunito(color: const Color(0xFF3B2A2A)),
          bodyMedium: GoogleFonts.nunito(color: const Color(0xFF8A7070)),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFFB5C9B0),
          foregroundColor: const Color(0xFFFAF7F2),
          centerTitle: true,
          titleTextStyle: GoogleFonts.dmSerifDisplay(
            color: const Color(0xFFFAF7F2),
            fontSize: 24,
          ),
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE8899A),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            textStyle: GoogleFonts.nunito(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 2,
          shadowColor: const Color(0xFFF2A7BB).withOpacity(0.3),
        ),
      ),
      home: const LoginPage(),
    );
  }
}
