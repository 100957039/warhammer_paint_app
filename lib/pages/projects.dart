import 'package:flutter/material.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});
  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  @override
  Widget build(BuildContext context) {
    // Only shows parent projects
    final List<Project> parentProjectList = projectList.where((project) => project.parentId == -1).toList();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProject())
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
        itemCount: parentProjectList.length,
        itemBuilder: (BuildContext context, int index) {
          final currentProject = parentProjectList[index];

          return ListTile(
            title: Text(currentProject.name),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SubProjectsPage(
                    selectedProject: currentProject
                  )
                )
              );
            }
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          height: 10,
        ),
      ),
    );
  }
}

class SubProjectsPage extends StatefulWidget {
  const SubProjectsPage({super.key, required this.selectedProject});
  
  final Project selectedProject;

  @override
  State<SubProjectsPage> createState() => _SubProjectsPageState();
}

class _SubProjectsPageState extends State<SubProjectsPage> {
  @override
  Widget build(BuildContext context) {
    final List<Project> subProjectList = projectList.where((project) => project.parentId == widget.selectedProject.id).toList();

    if(subProjectList.isEmpty){
      return Scaffold(
        appBar: AppBar(title: Text(widget.selectedProject.name)),
        body: Text("No Sub Projects Found"),
        );
    }
    return Scaffold(
      appBar: AppBar(title: Text(widget.selectedProject.name)),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
        itemCount: projectList.length,
        itemBuilder: (BuildContext context, int index) {
          final currentProject = subProjectList[index];

          return ListTile(
            title: Text(currentProject.name),
            onTap: (){

            }
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          height: 10,
        ),
      ),
    );
  }
}

class AddProject extends StatelessWidget {
  const AddProject({super.key});
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

class Project{
  final int id;
  final String name;
  final String description;
  final DateTime startedAt;
  final DateTime finishedAt;
  final DateTime createdAt;
  final String picture;
  final int parentId;
  final int accountId;

  Project({required this.id, required this.name, required this.description, required this.startedAt, required this.finishedAt, required this.createdAt, required this.picture, required this.parentId, required this.accountId});
}

final List<Project> projectList = List.generate(
  30,
  (i) => Project(
    id: i + 1,
    name: 'Project ${i + 1}',
    description: 'Description ${i + 1}',
    startedAt: DateTime.now(),
    finishedAt: DateTime.now(),
    createdAt: DateTime.now(),
    picture: 'Picture Link',
    parentId: -1,
    accountId: 1,
  ),
);