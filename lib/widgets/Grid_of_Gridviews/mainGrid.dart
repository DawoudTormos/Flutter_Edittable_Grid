import 'package:flutter/material.dart';
import "package:Edittable_Grid_Flutter/widgets/Gridview_/editable_grid.dart";

class MainGrid extends StatefulWidget {

    Map<String , List<Map<String, dynamic>>>? gridItems ;
   List<String>? gridItemsIndexes ;

   MainGrid({super.key ,
                  required Map<String , List<Map<String, dynamic>>>? gridItems ,
                  required List<String>? gridItemsIndexes 
                  }){
                    this.gridItems = gridItems;
                    this.gridItemsIndexes =gridItemsIndexes ;
                  }
    


  @override
  State<MainGrid> createState() => _MainGridState();
}

class _MainGridState extends State<MainGrid> {



  final GlobalKey _gridKey = GlobalKey();
  bool editMode = false;


  

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double innerGridWidth =screenWidth <570 ? screenWidth : 570 ;
    final columnsCount = getGridColumnsCount(screenWidth, widget.gridItems!.length);

    return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 30),
          
            //padding: EdgeInsets.symmetric(horizontal:(screenWidth+4 - columnsCount * 500)/2),
            Container(
              width: columnsCount * innerGridWidth, 
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                          "Editable Grid Example",
                          style: TextStyle(fontSize: screenWidth < 430 ? 20 : 24, fontWeight: FontWeight.bold),
                        ),
                        //SizedBox(width: columnsCount * 500 - 330),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          editMode = !editMode;
                        });
                      },
                      child: Text(editMode ? "Done Editing" : "Edit"),
                    ),
                    
                  ],
                          
                ),
            ),
            
          
           SizedBox(height: screenWidth < 430 ? 60 : 110),
          Container(
            width: columnsCount * innerGridWidth,
            child:listOrGrid( screenWidth,  innerGridWidth, columnsCount),
          ),
        ],
      );
    
  }



  int getGridColumnsCount( double screenWidth , int len){

      int count = (screenWidth / 570).toInt(); // 500 + 50   50 for padding
      //if (count > 2 ){count = (screenWidth / 570).toInt();} //when 3 columns , make padding 70
      if(count == 0){return 1;}

      if(count > len){ return len;}
      return count;
                   
    }


Widget listOrGrid(double screenWidth, double innerGridWidth, int columnsCount){
if(screenWidth > 430){
  return GridView.builder(
              key: _gridKey,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:  columnsCount,
                mainAxisSpacing: 10,
                
               
               
              ),
              itemCount: widget.gridItems!.length,
              itemBuilder: (context, index) {
                final item = widget.gridItems![widget.gridItemsIndexes![index]]!;
      
                 Widget gridItem =  EditableGrid(title: widget.gridItemsIndexes![index] , data: item);
                    
      
                if (editMode) {
                  return Draggable<int>(
                    
                    data: index,
                    feedback: Material(
                      elevation: 0,
                      color: Colors.transparent,
                      child: Container(
                        width: innerGridWidth ,
                        color: Colors.transparent,
                        child: gridItem,
                      ),
                    ),
                    childWhenDragging: Container(color: Colors.transparent),
                    child: DragTarget<int>(
                      onAcceptWithDetails: (fromIndex) {
                        setState(() {
                          final temp = widget.gridItemsIndexes!.removeAt(fromIndex.data);
                          widget.gridItemsIndexes!.insert(index, temp);
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
            );
}else{
  return   Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: ListView.builder(
                key: _gridKey,
                shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),

                itemCount: widget.gridItems!.length,
                itemBuilder: (context, index) {
                  final item = widget.gridItems![widget.gridItemsIndexes![index]]!;
        
                   Widget gridItem =  EditableGrid(title: widget.gridItemsIndexes![index] , data: item);
                      
        
                  if (editMode) {
                    return Draggable<int>(
                      
                      data: index,
                      feedback: Material(
                        elevation: 0,
                        color: Colors.transparent,
                        child: Container(
                          width: screenWidth - 40 ,
                          
                          color: Colors.transparent,
                          child: gridItem,
                        ),
                      ),
                      childWhenDragging: Container(color: Colors.transparent, height:item.length*90),
                      child: DragTarget<int>(
                        onAcceptWithDetails: (fromIndex) {
                          setState(() {
                            final temp = widget.gridItemsIndexes!.removeAt(fromIndex.data);
                            widget.gridItemsIndexes!.insert(index, temp);
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
  );
}

}

  }



