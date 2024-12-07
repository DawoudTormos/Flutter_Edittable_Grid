import 'package:flutter/material.dart';
import "package:Edittable_Grid_Flutter/widgets/gridview/editable_grid.dart";

class MainGrid extends StatefulWidget {
  const MainGrid({super.key});

  @override
  State<MainGrid> createState() => _MainGridState();
}

class _MainGridState extends State<MainGrid> {



  final GlobalKey _gridKey = GlobalKey();
  bool editMode = false;

  final List<Map<String, dynamic>> gridItems = [
    {
      "name": 'Lamp 1',
      "color": Colors.red,
      "icon": Icons.lightbulb,
      "value": true
    },
    {
      "name": 'Lamp 2',
      "color": Colors.green,
      "icon": Icons.lightbulb,
      "value": true
    },
    {
      "name": 'Lamp 3',
      "color": Colors.blue,
      "icon": Icons.lightbulb,
      "value": true
    },
    {
      "name": 'Spotlight 1',
      "color": Colors.orange,
      "icon": Icons.light,
      "value": 0.86
    },
    {
      "name": 'AC 2',
      "color": Colors.purple,
      "icon": Icons.ac_unit,
      "value": true
    },
    {
      "name": 'Door Lock',
      "color": Colors.teal,
      "icon": Icons.lock_outlined,
      "value": true
    },
    {
      "name": 'Heater',
      "color": Colors.pink,
      "icon": Icons.air_rounded,
      "value": true
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double gridWidth = screenWidth ;

    return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                editMode = !editMode;
              });
            },
            child: Text(editMode ? "Done Editing" : "Edit"),
          ),
          const SizedBox(height: 20),
          Container(
            width: gridWidth,
            child: GridView.builder(
              key: _gridKey,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
               
              ),
              itemCount: gridItems.length,
              itemBuilder: (context, index) {
                final item = gridItems[index];
      
                 Widget gridItem =  EditableGrid(title: index.toString());
                    
      
                if (editMode) {
                  return Draggable<int>(
                    data: index,
                    feedback: Material(
                      elevation: 0,
                      color: Colors.transparent,
                      child: Container(
                        width: gridWidth / 2,
                        //height: gridWidth / (2 * 2.5),
                        color: Colors.transparent,
                        child: gridItem,
                      ),
                    ),
                    childWhenDragging: Container(color: Colors.transparent),
                    child: DragTarget<int>(
                      onAcceptWithDetails: (fromIndex) {
                        setState(() {
                          final temp = gridItems.removeAt(fromIndex.data);
                          gridItems.insert(index, temp);
                        });
                      },
                      builder: (context, candidateData, rejectedData) {
                        return gridItem;
                      },
                    ),
                  );
                }
      
                return gridItem;
              },
            ),
          ),
        ],
      );
    
  }
  }



