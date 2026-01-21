import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/settings_page.dart';

void main() {
  runApp(const LGControlApp());
}

class LGControlApp extends StatelessWidget {
  const LGControlApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LG Control',
      theme: ThemeData(
        primarySwatch: Colors.red,
        useMaterial3: true,
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      home: const HomePage(),
      routes: {
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}