import 'package:flutter/material.dart';
import 'widgets/Gridview_/editable_grid.dart';
import "widgets/Grid_of_Gridviews/mainGrid.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        final double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            physics: const RangeMaintainingScrollPhysics() ,
            child: Container(
              width: screenWidth,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: [
                  Text(
                    "Editable Grid Example",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  MainGrid(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
