import 'package:draggablesnappable/pages/home_bottom_sheet.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Draggable and Snappable'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.lightBlue.shade100,
          ),
          HomeBottomSheet()
        ],
      ),
    );
  }
}
