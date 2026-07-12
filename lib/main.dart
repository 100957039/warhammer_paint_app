import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'theme/app_theme.dart';
import 'package:warhammer_paint_app/navigation.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Navigation(),
      title: 'Warhammer Paint App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}