import 'package:flutter/material.dart';
import 'package:warhammer_paint_app/pages/customize.dart';
import 'package:warhammer_paint_app/pages/download.dart';
import 'package:warhammer_paint_app/pages/home.dart';
import 'package:warhammer_paint_app/pages/paints.dart';
import 'package:warhammer_paint_app/pages/projects.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() =>
    _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget getChild(int index){
    Widget child;

    switch(index){
      case 0: // Home
        child = HomePage();
      case 1: // Projects
        child = ProjectsPage();
      case 2: // Paints
        child = PaintsPage();
      case 3: // Customize
        child = CustomizePage();
      case 4: // Download
        child = DownloadPage();
      default:
        child = HomePage();
    }
    return child;
  }

  @override
  Widget build(BuildContext context) {
    Widget child = getChild(_selectedIndex);

    return Scaffold(
      body: SizedBox.expand(child: child),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.tertiary,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'Projects'),
          BottomNavigationBarItem(icon: Icon(Icons.format_paint), label: 'Paints',),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_customize), label: 'Customize'),
          BottomNavigationBarItem(icon: Icon(Icons.download), label: 'Download'),
        ],
      ),
    );
  }
}
