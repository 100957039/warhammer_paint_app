import 'package:flutter/material.dart';

class PaintsPage extends StatefulWidget {
  const PaintsPage({super.key});
  
  @override
  State<PaintsPage> createState() => _PaintsPageState();
}

class _PaintsPageState extends State<PaintsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paints')),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('Paints Page'),
          ],
        ),
      ),
    );
  }
}