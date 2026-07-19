import 'package:flutter/material.dart';
import 'package:path/path.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});
  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Projects')),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
        itemCount: projectList.length,
        itemBuilder: (BuildContext context, int index) {
          final currentProject = projectList[index];

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

// final List<Object> projectList = <Object>[
//   [1, 'Project 1', 'Description 1', DateTime.now(), DateTime.now(), DateTime.now(), "Picture Link", 2, 1],
//   [2, 'Project 2', 'Description 2', DateTime.now(), DateTime.now(), DateTime.now(), "Picture Link", 2, 1],
//   [3, 'Project 3', 'Description 3', DateTime.now(), DateTime.now(), DateTime.now(), "Picture Link", 2, 1]
// ];

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
    parentId: 2,
    accountId: 1,
  ),
);