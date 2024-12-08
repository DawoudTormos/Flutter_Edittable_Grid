import 'package:flutter/material.dart';
import "package:Edittable_Grid_Flutter/widgets/Gridview_/editable_grid.dart";

class MainGrid extends StatefulWidget {
  const MainGrid({super.key});

  @override
  State<MainGrid> createState() => _MainGridState();
}

class _MainGridState extends State<MainGrid> {



  final GlobalKey _gridKey = GlobalKey();
  bool editMode = false;

  final Map<String , List<Map<String, dynamic>>> gridItems = { 
    "Kitchen" :[
    {
      "name": 'Lamp 1',
      "color": Colors.red,
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
    ],

    "Living Room" : [
      {
      "name": 'Heater',
      "color": Colors.pink,
      "icon": Icons.air_rounded,
      "value": true
    },{
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
    ]
  };

  final List<String> dataKeysIndexs = ["Kitchen" , "Living Room"];// used to keep the index of keys and to be retrived from the db
  

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double innerGridWidth = 570 ;

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
            width: getGridColumnsCount(screenWidth, gridItems.length) * innerGridWidth,
            child: GridView.builder(
              key: _gridKey,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:  getGridColumnsCount(screenWidth, gridItems.length),
                mainAxisSpacing: 10
               
              ),
              itemCount: gridItems.length,
              itemBuilder: (context, index) {
                final item = gridItems[dataKeysIndexs[index]]!;
      
                 Widget gridItem =  EditableGrid(title: dataKeysIndexs[index] , data: item);
                    
      
                if (editMode) {
                  return Draggable<int>(
                    data: index,
                    feedback: Material(
                      elevation: 0,
                      color: Colors.transparent,
                      child: Container(
                        width: innerGridWidth ,
                        //height: gridWidth / (2 * 2.5),
                        color: Colors.transparent,
                        child: gridItem,
                      ),
                    ),
                    childWhenDragging: Container(color: Colors.transparent),
                    child: DragTarget<int>(
                      onAcceptWithDetails: (fromIndex) {
                        setState(() {
                          final temp = dataKeysIndexs.removeAt(fromIndex.data);
                          dataKeysIndexs.insert(index, temp);
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



  int getGridColumnsCount( double screenWidth , int len){

      int count = (screenWidth / 550).toInt(); // 500 + 50   50 for padding
      if (count > 2 ){count = (screenWidth / 570).toInt();} //when 3 columns , make padding 70
      if(count == 0){return 1;}

      if(count > len){ return len;}
      return count;
                   
    }


  }



