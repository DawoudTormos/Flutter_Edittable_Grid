import 'package:flutter/material.dart';
import 'widgets/gridview/editable_grid.dart';
import "widgets/Grid_of_Gridviews/mainGrid.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            physics: RangeMaintainingScrollPhysics() ,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Editable Grid Example",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                MainGrid(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
