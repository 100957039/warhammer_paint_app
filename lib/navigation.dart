import 'package:flutter/material.dart';
import 'package:warhammer_paint_app/pages/customize.dart';
import 'package:warhammer_paint_app/pages/download.dart';
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
      case 0: // Projects
        child = ProjectsPage();
      case 1: // Paints
        child = PaintsPage();
      case 2: // Customize
        child = CustomizePage();
      case 3: // Download
        child = DownloadPage();
      default:
        child = ProjectsPage();
    }
    return child;
  }

  String getTitle(int index){
    String title;

    switch(index){
      case 0: // Projects
        title = "Projects";
      case 1: // Paints
        title = "Paints";
      case 2: // Customize
        title = "Customize";
      case 3: // Download
        title = "Download";
      default:
        title = "Projects";
    }
    return title;
  }

  @override
  Widget build(BuildContext context) {
    Widget child = getChild(_selectedIndex);
    final String title = getTitle(_selectedIndex);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: "About",
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InfoPage())
              );
            },
          ),
        ],
        actionsPadding: EdgeInsets.only(right: 8),
      ),
      body: SizedBox.expand(child: child),      
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'Projects'),
          BottomNavigationBarItem(icon: Icon(Icons.format_paint), label: 'Paints',),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_customize), label: 'Customize'),
          BottomNavigationBarItem(icon: Icon(Icons.download), label: 'Download'),
        ],
      ),
    );
  }
}

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white,),
        title: Text("Add New Project",
          style: const TextStyle(color: Colors.white),
        ), 
        backgroundColor: Colors.blueGrey[800],
      ),
      backgroundColor: Colors.blueGrey[600],
      body: Padding(
        padding:  const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[800],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Min Temp: °C',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Max Temp: °C',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Humidity:%',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Wind Speed:m/s',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'UV Index:',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      Text('Sunrise:',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      Text('Sunset:}',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}
