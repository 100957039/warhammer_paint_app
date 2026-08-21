import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'package:warhammer_paint_app/navigation.dart';
//import 'package:flutter/rendering.dart';

void main() {
  //debugPaintSizeEnabled=true; 
  runApp(MainApp());
}

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