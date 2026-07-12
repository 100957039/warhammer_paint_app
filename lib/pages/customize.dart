import 'package:flutter/material.dart';

class CustomizePage extends StatefulWidget {
  const CustomizePage({super.key});

  @override
  State<CustomizePage> createState() => _CustomizePageState();
}

class _CustomizePageState extends State<CustomizePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customize')),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('Customization Page'),
          ],
        ),
      ),
    );
  }
}