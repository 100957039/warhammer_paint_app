import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:warhammer_paint_app/assets/citadel_paint_list.dart';

class PaintsPage extends StatefulWidget {
  const PaintsPage({super.key});
  
  @override
  State<PaintsPage> createState() => _PaintsPageState();
}

class _PaintsPageState extends State<PaintsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(68),
          child: AppBar(
            bottom: const TabBar(tabs: [
            Tab(text: "All",),
            Tab(text: "Inventory",),
            Tab(text: "Wishlist",),
          ]),
          ),
        ),
        body: TabBarView(
          children: [
            // All Paints
            BuildPaintList(paints: citadelPaintList),
            // Owned Paints
            BuildPaintList(paints: paintInventoryList),
            // Not Owned Paints
            BuildPaintList(paints: notOwnedPaintList),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddPaint())
            );
          },
          child: const Icon(Icons.add),
        ),
        
      ),
    );
  }
}

class PaintDetailsPage extends StatelessWidget {
  const PaintDetailsPage({super.key, required this.selectedPaint});

  final Paint selectedPaint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white,),
        title: Text("Paint Details",
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

class BuildPaintList extends StatefulWidget{
  const BuildPaintList({super.key, required this.paints});

  final List<Paint> paints;
  
  @override
  State<BuildPaintList> createState() => _BuildPaintListState();
}

class _BuildPaintListState extends State<BuildPaintList>{
  @override
  Widget build(BuildContext context){
    widget.paints.sort((a, b) {
      return compareNatural(a.name.toLowerCase(), (b.name.toLowerCase()));
    });

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 4
      ),
      padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
      itemCount: widget.paints.length,
      itemBuilder: (BuildContext context, int index) {
        final currentPaint = widget.paints[index];
        return ListTile(
          title: Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.horizontal,
                children: [
                  Center(
                    child: SizedBox(
                      width: 116,
                      height: 36, 
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                        color: Color(int.parse(currentPaint.hex)),
                        borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      currentPaint.name, 
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.end,
                direction: Axis.horizontal,
                children: [
                  Center(
                    child: IconButton(
                      icon: isOwned(currentPaint)
                      ? Icon(
                        Icons.check_circle,
                        color: Theme.of(context).colorScheme.tertiary,
                        )
                      : Icon(
                        Icons.check_circle_outline,
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        ),
                      tooltip: "Add to Inventory",
                      onPressed: (){
                        setState(() {
                          if(isOwned(currentPaint)){
                            Paint newPaint = Paint(id: currentPaint.id, name: currentPaint.name, hex: currentPaint.hex, metallic: currentPaint.metallic, typeId: currentPaint.typeId, colourId: currentPaint.colourId, accountId: currentPaint.accountId);
                            notOwnedPaintList.add(newPaint);
                            int index = paintInventoryList.indexWhere((checkingInventory) => checkingInventory.id == currentPaint.id);
                            paintInventoryList.removeAt(index);
                          }
                          else {
                            PaintInventory newPaint = PaintInventory(id: currentPaint.id, name: currentPaint.name, hex: currentPaint.hex, metallic: currentPaint.metallic, typeId: currentPaint.typeId, colourId: currentPaint.colourId, accountId: currentPaint.accountId, boughtAt: DateTime.now(), inventoryAccountId: 2);
                            paintInventoryList.add(newPaint);
                            int index = notOwnedPaintList.indexWhere((checkingInventory) => checkingInventory.id == currentPaint.id);
                            if(index != -1){
                              notOwnedPaintList.removeAt(index);
                            }
                            
                          }
                        });
                      },
                    ),
                  ),
                  
                ],
              ),
            ],
          ),
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PaintDetailsPage(
                  selectedPaint: currentPaint
                )
              )
            );
          }
          
        );
      },
    );
  }
}

bool isOwned(Paint currentPaint){
  final bool isOwned = paintInventoryList.any((checkingInventory) => checkingInventory.id == currentPaint.id);

  return isOwned;
}

class AddPaint extends StatefulWidget {
  const AddPaint({super.key});

  @override
  AddPaintState createState() {
    return AddPaintState();
  }
}

class AddPaintState extends State<AddPaint> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Paint"), 
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text("Paint Name"),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a paint name';
                }
                return null;
              },
            ),
            SizedBox(height: 10,),
            Text("Paint Description"),
            TextFormField(),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Project Added!')),
                  );
                  
                }
              },
              child: const Text('Add Paint'),
            ),
          ],
        ),
      ),
    );
  }
}

class PaintInventory extends Paint{
  final DateTime boughtAt;
  final int inventoryAccountId;


  PaintInventory({required super.id, required super.name, required super.hex, required super.metallic, required super.typeId, required super.colourId, required super.accountId, required this.boughtAt, required this.inventoryAccountId});
}

final List<PaintInventory> paintInventoryList = <PaintInventory>[];

final List<Paint> notOwnedPaintList = [...citadelPaintList];