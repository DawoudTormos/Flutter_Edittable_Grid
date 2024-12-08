import 'package:flutter/material.dart';
import 'grid_item_switch.dart';
import 'grid_item_slider.dart';

class EditableGrid extends StatefulWidget {

   String title = '';
   final List<Map<String, dynamic>> data; 

   EditableGrid({super.key , required this.title , required this.data});
  @override
  _EditableGridState createState() => _EditableGridState();
}

class _EditableGridState extends State<EditableGrid> {
  final Key _gridKey =  UniqueKey();
  bool editMode = false;

  

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double gridWidth = screenWidth < 500 ? screenWidth : 500;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.title),
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
            //key: _gridKey,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
            ),
            itemCount: widget.data.length,
            itemBuilder: (context, index) {
              final item = widget.data[index];

              Widget gridItem = item['value'] is bool
                  ? GridItemSwitch(item: item)
                  : GridItemSlider(item: item);

              if (editMode) {
                return Draggable<int>(
                  data: index,
                  feedback: Material(
                    elevation: 0,
                    color: Colors.transparent,
                    child: Container(
                      width: gridWidth / 2,
                      height: gridWidth / (2 * 2.5),
                      color: Colors.transparent,
                      child: gridItem,
                    ),
                  ),
                  childWhenDragging: Container(color: Colors.transparent),
                  child: DragTarget<int>(
                    onAcceptWithDetails: (fromIndex) {
                      setState(() {
                        final temp = widget.data.removeAt(fromIndex.data);
                        widget.data.insert(index, temp);
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
