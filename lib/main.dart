import 'package:flutter/material.dart';
import 'widgets/Gridview_/editable_grid.dart';
import "widgets/Grid_of_Gridviews/mainGrid.dart";

void main() {
  runApp(MyApp());
}




class MyApp extends StatelessWidget {

 Map<String, List<Map<String, dynamic>>> gridItems = {
  "Kitchen": [
    {"name": "Lamp 1", "color": Colors.red, "icon": Icons.lightbulb, "value": true},
    {"name": "Spotlight 1", "color": Colors.orange, "icon": Icons.light, "value": 0.86},
    {"name": "AC 2", "color": Colors.purple, "icon": Icons.ac_unit, "value": true},
    {"name": "Door Lock", "color": Colors.teal, "icon": Icons.lock_outlined, "value": true},
  ],
  "Living Room": [
    {"name": "Heater", "color": Colors.pink, "icon": Icons.air_rounded, "value": true},
    {"name": "Lamp 2", "color": Colors.green, "icon": Icons.lightbulb, "value": true},
    {"name": "Lamp 3", "color": Colors.blue, "icon": Icons.lightbulb, "value": true},
  ],
};


   List<String> gridItemsIndexes = ["Kitchen" , "Living Room"];// used to keep the index of keys and to be retrived from the db
  


  @override
  Widget build(BuildContext context) {
        final double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        body: 
          SingleChildScrollView(
            //physics: BouncingScrollPhysics(),
            child: Container(
              width: screenWidth,
              child: 
                  MainGrid(gridItems: gridItems , gridItemsIndexes : gridItemsIndexes),
                
              ),
            ),
          
        ),
      )
    ;
  }
}
