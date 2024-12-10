/*import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Editable Grid Example",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              EditableGrid(),
            ],
          ),
        ),
      ),
    );
  }
}

class EditableGrid extends StatefulWidget {
  
  const EditableGrid({super.key});

  @override
  _EditableGridState createState() => _EditableGridState();
}

class _EditableGridState extends State<EditableGrid> {
  final GlobalKey _gridKey = GlobalKey();
  bool editMode = false;

  final List<Map<String, dynamic>> gridItems = [
    {"name": 'Lamp 1', "color": Colors.red, "icon": Icons.lightbulb, "value": true},
    {"name": 'Lamp 2', "color": Colors.green, "icon": Icons.lightbulb, "value": true},
    {"name": 'Lamp 3', "color": Colors.blue, "icon": Icons.lightbulb, "value": true},
    {"name": 'Spotlight 1', "color": Colors.orange, "icon": Icons.light, "value": 0.86},
    {"name": 'AC 2', "color": Colors.purple, "icon": Icons.ac_unit, "value": true},
    {"name": 'Door Lock', "color": Colors.teal, "icon": Icons.lock_outlined, "value": true},
    {"name": 'Heater', "color": Colors.pink, "icon": Icons.air_rounded, "value": true},
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double gridWidth = screenWidth < 500 ? screenWidth : 500;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              editMode = !editMode;
            });
          },
          child: Text(editMode ? "Done Editing" : "Edit"),
        ),
        SizedBox(height: 20),
        Container(
          width: gridWidth,
          child: GridView.builder(
            key: _gridKey,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
            ),
            itemCount: gridItems.length,
            itemBuilder: (context, index) {
              final item = gridItems[index];

              Widget gridItem = item['value'] is bool
                  ? _buildSwitchGridItem(item, screenWidth)
                  : _buildSliderGridItem(item, screenWidth);

              if (editMode) {
                return Draggable<int>(
                  data: index,
                  feedback: Material(
                    elevation: 0,
                    color: Colors.transparent,
                    child: Container(
                        width: gridWidth / 2,
                        height: gridWidth / (2*2.5),
                        color: Colors.transparent,
                        child: gridItem,
                    ),
                  ),
                  childWhenDragging: Container(color: Colors.transparent),
                  child: DragTarget<int>(
                    onAcceptWithDetails: (fromIndex) {
                      setState(() {
                        final temp  = gridItems.removeAt(fromIndex.data);
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

  Widget _buildSwitchGridItem(Map<String, dynamic> item, double screenWidth) {
     double factor = screenWidth<550 ? 0.75 :0.83;
      if(screenWidth < 460){factor = 0.6;}
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: item["value"]== true ? item["color"]:Colors.grey[700], width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: screenWidth > 600
            ? EdgeInsets.fromLTRB(25 * factor , 8* factor, 25* factor, 8* factor)
            :  EdgeInsets.fromLTRB(20* factor, 8* factor, 20* factor, 8* factor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(item["icon"],
                    color:  item["value"]== true ? item["color"]:Colors.grey[700], size: (screenWidth < 600 ? 36 : 38)*factor),
                const SizedBox(width: 12),
                Text(
                  item["name"],
                  style: TextStyle(
                    color:  item["value"]== true ? item["color"]:Colors.grey[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 16*factor,
                  ),
                ),
              ],
            ),
            Transform.scale(
              scale:factor,
              child: Switch(
                value: item['value'],
                onChanged: (newValue) {
                  setState(() {
                    item['value'] = newValue;
                  });
                },
                activeColor:  item["value"]== true ? item["color"]:Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliderGridItem(Map<String, dynamic> item, double screenWidth) {
     double factor = screenWidth<550 ?0.75 :0.83;
      if(screenWidth < 460){factor = 0.6;}

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: item["value"]> 0 ? item["color"]:Colors.grey[700], width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
                padding: screenWidth > 600
            ? EdgeInsets.fromLTRB(25 * factor , 8* factor, 25* factor, 8* factor)
            :  EdgeInsets.fromLTRB(20* factor, 8* factor, 20* factor, 8* factor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Icon(item["icon"],
                      color: item["value"]> 0 ? item["color"]:Colors.grey[700], size: (screenWidth < 600 ? 36 : 38)*factor),
                  const SizedBox(width: 12),
                  Text(
                    item["name"],
                    style: TextStyle(
                      color: item["value"]> 0 ? item["color"]:Colors.grey[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 16* factor,
                    ),
                  ),
                ]),
                Padding(
                  padding:  EdgeInsets.only(right: 15 * factor),
                  child: Text(
                    "Value: ${(item['value'] * 100).toInt()}%",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 13*factor,
                    ),
                  ),
                ),
              ],
            ),
            SliderTheme(

              data: SliderTheme.of(context).copyWith(
    trackHeight: 5 * factor, // Adjust the height of the track
    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8*factor), // Reduce thumb size
    overlayShape: RoundSliderOverlayShape(overlayRadius: 25*factor*0.81), // Adjust the overlay size
  ),
              child: Slider(
                value: (item['value'] as double),
                min: 0,
                max: 1,
                divisions: 100,
                onChanged: (newValue) {
                  setState(() {
                    item['value'] = newValue;
                  });
                },
                activeColor: item["value"]> 0 ? item["color"]:Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

*/
