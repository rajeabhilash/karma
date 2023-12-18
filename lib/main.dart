import 'package:flutter/material.dart';
import 'package:karma/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // Initialize Hive
  await Hive.initFlutter();
  // Open Box
  var karmabox = await Hive.openBox('karma');
  runApp(const Karma());
}

class Karma extends StatelessWidget {
  const Karma({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Karma App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.green,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.green,
          elevation: 0,
        ),
        scaffoldBackgroundColor: Colors.green[200],
      ),
      home: const HomePage(),
    );
  }
}
