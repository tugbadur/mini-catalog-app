import 'package:flutter/material.dart';
import 'package:mini_catalog_app/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Mini Catalog App',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
