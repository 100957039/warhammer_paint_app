import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'Warhammer Paint App',
      home: MyHomePage(title: 'Home'),
    );
  }
}