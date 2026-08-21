import 'package:flutter/material.dart';
import 'dart:math';
import 'package:warhammer_paint_app/navigation.dart';
import 'package:collection/collection.dart';
import 'package:warhammer_paint_app/assets/warhammer_armies_list.dart';

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Expanded(
            child: TextButton.icon(
            onPressed: () {
              showMenu(
                context: context,
                position: const RelativeRect.fromLTRB(110.0, 80.0, 0.0, 0.0),
                items: ['Newest', 'Oldest', 'A-Z', 'Z-A']
                    .map(
                      (value) => PopupMenuItem<String>(
                        value: value,
                        child: Text(value),
                        onTap: () => 
                        setState(() {
                          projectList = [...sortList(value)];
                        }), 
                      ),
                    )
                    .toList(),
                elevation: 8.0,
              );
            },
            label: Text("Sort By"),
            icon: const Icon(Icons.arrow_drop_down),
            iconAlignment: .end,
            
          ),
        ),
      ]),
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
        itemCount: parentProjectList.length,
        itemBuilder: (BuildContext context, int index) {
          final currentProject = parentProjectList[index];
          return ListTile(
            title: Text(currentProject.name),
            trailing: IconButton(
              icon: const Icon(Icons.info_outline, color: Color(0xFF009f00),),
              tooltip: "Details",
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProjectInfoPage(project: currentProject))
                );
              },
            ),
            shape: Border(
              bottom: BorderSide(color: Colors.black, width: 1),
            ), 
            
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
          height: 0,
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
    // Only shows subprojects
    final List<Project> subProjectList = projectList.where((project) => project.parentId == widget.selectedProject.id).toList();

    if(subProjectList.isEmpty){
      return Scaffold(
        appBar: AppBar(title: Text(widget.selectedProject.name)),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddProject(parentProject: widget.selectedProject))
            );
          },
          child: const Icon(Icons.add),
        ),
        body: Text("No Subprojects Found"),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectedProject.name),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProject(parentProject: widget.selectedProject))
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
        itemCount: subProjectList.length,
        itemBuilder: (BuildContext context, int index) {
          final currentProject = subProjectList[index];
          return ListTile(
            title: Text(currentProject.name),
            trailing: IconButton(
              icon: const Icon(Icons.info_outline, color: Color(0xFF009f00),),
              tooltip: "Details",
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProjectInfoPage(project: currentProject))
                );
              },
            ),
            shape: Border(
              bottom: BorderSide(color: Colors.black, width: 1),
            ), 
            
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ArmiesPage(
                    selectedProject: currentProject
                  )
                )
              );
            }
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          height: 0,
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   final List<Project> subProjectList = projectList.where((project) => project.parentId == widget.selectedProject.id).toList();

  //   if(subProjectList.isEmpty){
  //     return Scaffold(
  //       appBar: AppBar(title: Text(widget.selectedProject.name)),
  //       floatingActionButton: FloatingActionButton(
  //       onPressed: (){
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => AddProject(parentProject: widget.selectedProject))
  //         );
  //       },
  //       child: const Icon(Icons.add),
  //     ),
  //       body: Text("No Sub Projects Found"),
  //       );
  //   }
  //   return Scaffold(
  //     appBar: AppBar(title: Text(widget.selectedProject.name)),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: (){
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => AddProject(parentProject: widget.selectedProject))
  //         );
  //       },
  //       child: const Icon(Icons.add),
  //     ),
  //     body: ListView.separated(
  //       padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
  //       itemCount: subProjectList.length,
  //       itemBuilder: (BuildContext context, int index) {
  //         final currentProject = subProjectList[index];

  //         return ListTile(
  //           title: Text(currentProject.name),
  //           onTap: (){

  //           }
  //         );
  //       },
  //       separatorBuilder: (context, index) => SizedBox(
  //         height: 10,
  //       ),
  //     ),
  //   );
  // }
}

class AddProject extends StatefulWidget {
  const AddProject({super.key, this.parentProject});

  final Project? parentProject;

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  final _formKey = GlobalKey<FormState>();
  DateTime currentDate = DateTime.now();
  final nameController = TextEditingController();
  final descController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  String title = ""; 
    
  

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    super.dispose();
  }

   Future<void> _selectDate(int selectedDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(currentDate.year, currentDate.month, currentDate.day),
      firstDate: DateTime(1900),
      lastDate: DateTime((currentDate.year + 1)),
      cancelText: "Cancel",
      confirmText: "OK",
      builder: (BuildContext context, Widget? child){
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF009f00),
              onPrimary: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
          ),
          child: child!,
        );
      }
    );

    setState(() {
      switch(selectedDate){
        case 0:
          startDate = pickedDate;
        case 1:
          endDate = pickedDate;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(widget.parentProject != null){
      title = "Add New Subproject";
    } else {
      title = "Add New Project";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title), 
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text("Project Name", style: TextStyle(fontWeight: FontWeight.bold)),
            TextFormField(
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a project name';
                }
                return null;
              },
            ),
            SizedBox(height: 10,),
            Text("Project Description", style: TextStyle(fontWeight: FontWeight.bold)),
            TextFormField(
              controller: descController,
            ),
            SizedBox(height: 10,),
            Text("Start Date", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(startDate != null
              ? '${startDate!.month}/${startDate!.day}/${startDate!.year}'
              : 'No date selected',
            ),
            ElevatedButton(
              onPressed: () async {
                await _selectDate(0);
              },
              child: const Text('Select Date'),
            ),
            SizedBox(height: 10,),
            Text("Completion Date", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(endDate != null
              ? '${endDate!.month}/${endDate!.day}/${endDate!.year}'
              : 'No date selected',
            ),
            ElevatedButton(
              onPressed: () async {
                await _selectDate(1);
              },
              child: const Text('Select Date'),
            ),

            if(widget.parentProject != null) ...[
              SizedBox(height: 10,),
              Text("Parent Project", style: TextStyle(fontWeight: FontWeight.bold)),
              Text(widget.parentProject?.name ?? (widget.parentProject.toString())),
            ],
            
            // DropdownMenu<int>(
            //   initialSelection: -1,
            //   requestFocusOnTap: true,
            //   dropdownMenuEntries: getParentEntries(),
            //   onSelected: (int? id) {
            //     setState(() {
            //       selectedParent = id;
            //     });
            //   },
            // ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                    if(submitAddProject(nameController.text, descController.text, startDate, endDate, (widget.parentProject?.id ?? -1))){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Project Added!')),
                      );
                      
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Navigation(index: 0))
                        );
                    }
                }
              },
              child: const Text('Add Project'),
            ),
          ],
        ),
      ),
    );
  }
}

class Project{
  final int id;
  final String name;
  final String description;
  final DateTime? startedAt;
  final DateTime? finishedAt;
  final DateTime createdAt;
  final String picture;
  final int parentId;
  final int accountId;

  Project({required this.id, required this.name, required this.description, required this.startedAt, required this.finishedAt, required this.createdAt, required this.picture, required this.parentId, required this.accountId});
}

List<Project> projectList = List.generate(
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

bool submitAddProject(String name, String desc, DateTime? startDate, DateTime? endDate, int parentId){
  bool success = false;
  int maxId;
  List<int> projectIdList = projectList.map((project) => project.id).toList();

  if (projectList.isNotEmpty) {
    maxId = projectIdList.reduce(max);
  } else{
    maxId = 0;
  }

  Project newProject = Project(
    id: (maxId + 1),
    name: name,
    description: desc,
    startedAt: startDate,
    finishedAt: endDate,
    createdAt: DateTime.now(),
    picture: 'Picture Link',
    parentId: parentId,
    accountId: 1,
  );
    
  try{
    projectList.add(newProject);
    success = true;
  } catch (e){
    success = false;
  }

  return success;
}

List<DropdownMenuEntry<int>> getParentEntries(){
  List<DropdownMenuEntry<int>> parentEntries = projectList.map((project){
    return DropdownMenuEntry<int>(
      value: project.id,
      label: project.name,
    );
  }).toList();

  parentEntries.insert(0, DropdownMenuEntry<int>(value: -1, label: 'N/A'));

  return parentEntries;
}

List<Project> sortList(String sort){
  List<Project> newList = [...projectList];

  switch(sort){
    case 'Newest':
      newList.sort((a, b) {
        return a.createdAt.compareTo(b.createdAt);
      });
      newList = [...newList.reversed];
    case 'Oldest':
      newList.sort((a, b) {
        return a.createdAt.compareTo(b.createdAt);
      });
    case 'A-Z':
      newList.sort((a, b) {
        return compareNatural(a.name.toLowerCase(), (b.name.toLowerCase()));
      });
    case 'Z-A':
      newList.sort((a, b) {
        return compareNatural(a.name.toLowerCase(), (b.name.toLowerCase()));
      });
      newList = [...newList.reversed];
  }
  return newList;
}

class ProjectInfoPage extends StatelessWidget {
  const ProjectInfoPage({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white,),
        title: Text(project.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            tooltip: "Actions",
            onPressed: (){
              showMenu(
                context: context,
                position: const RelativeRect.fromLTRB(110.0, 80.0, 0.0, 0.0),
                items: ['Edit', 'Delete']
                  .map(
                    (value) => PopupMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
                elevation: 8.0,
              );
            },
          ),
        ],
        actionsPadding: EdgeInsets.only(right: 8),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Project Description", style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 227, 227, 227),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(project.description),
                    ),
                  ],
                )
              ),
            ),
            // Expanded(
            //   child: Padding(
            //     padding: EdgeInsets.all(8),
            //     child: SingleChildScrollView(
            //       scrollDirection: Axis.vertical,
            //       child: Container(
            //         padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
            //         decoration: BoxDecoration(
            //           color: Color.fromARGB(255, 227, 227, 227),
            //           borderRadius: BorderRadius.circular(8.0),
            //         ),
            //         child: Text(project.description),
            //       )
            //     )
            //   ),
            // ),
            SizedBox(height: 10,),
            Text("Start Date", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(project.startedAt != null
              ? '${project.startedAt!.month}/${project.startedAt!.day}/${project.startedAt!.year}'
              : 'No date selected',
            ),
            SizedBox(height: 10,),
            Text("Completion Date", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(project.finishedAt != null
              ? '${project.finishedAt!.month}/${project.finishedAt!.day}/${project.finishedAt!.year}'
              : 'No date selected',
            ),
            SizedBox(height: 10,),
          ],
        ),
      )
    );
  }
}

class ArmiesPage extends StatefulWidget {
  const ArmiesPage({super.key, required this.selectedProject});
  
  final Project selectedProject;

  @override
  State<ArmiesPage> createState() => _ArmiesPageState();
}

class _ArmiesPageState extends State<ArmiesPage> {
  @override
  Widget build(BuildContext context) {
    // Only shows subprojects
    final List<Army> armiesList = createdArmiesList.where((army) => army.projectId == widget.selectedProject.id).toList();

    if(armiesList.isEmpty){
      return Scaffold(
        appBar: AppBar(title: Text(widget.selectedProject.name)),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => AddProject(parentProject: widget.selectedArmy))
            // );
          },
          child: const Icon(Icons.add),
        ),
        body: Text("No Armies Found"),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectedProject.name),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => AddProject(parentProject: widget.selectedArmy))
          // );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
        itemCount: armiesList.length,
        itemBuilder: (BuildContext context, int index) {
          final currentProject = armiesList[index];
          return ListTile(
            title: Text(currentProject.name),
            shape: Border(
              bottom: BorderSide(color: Colors.black, width: 1),
            ), 
            
            onTap: (){
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (_) => SubProjectsPage(
              //       selectedProject: currentProject
              //     )
              //   )
              // );
            }
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          height: 0,
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   final List<Project> subProjectList = projectList.where((project) => project.parentId == widget.selectedProject.id).toList();

  //   if(subProjectList.isEmpty){
  //     return Scaffold(
  //       appBar: AppBar(title: Text(widget.selectedProject.name)),
  //       floatingActionButton: FloatingActionButton(
  //       onPressed: (){
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => AddProject(parentProject: widget.selectedProject))
  //         );
  //       },
  //       child: const Icon(Icons.add),
  //     ),
  //       body: Text("No Sub Projects Found"),
  //       );
  //   }
  //   return Scaffold(
  //     appBar: AppBar(title: Text(widget.selectedProject.name)),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: (){
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => AddProject(parentProject: widget.selectedProject))
  //         );
  //       },
  //       child: const Icon(Icons.add),
  //     ),
  //     body: ListView.separated(
  //       padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
  //       itemCount: subProjectList.length,
  //       itemBuilder: (BuildContext context, int index) {
  //         final currentProject = subProjectList[index];

  //         return ListTile(
  //           title: Text(currentProject.name),
  //           onTap: (){

  //           }
  //         );
  //       },
  //       separatorBuilder: (context, index) => SizedBox(
  //         height: 10,
  //       ),
  //     ),
  //   );
  // }
}

class Army{
  final int id;
  final String name;
  final String notes;
  final String picture;
  final int projectId;
  final int armyTypeId;

  Army({required this.id, required this.name, required this.notes, required this.picture, required this.projectId, required this.armyTypeId});
}

List<Army> createdArmiesList = [];