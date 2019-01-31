import 'package:flutter/material.dart';
import 'dart:async';

class DataEmpty extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text("Aucune donnée n'est présente",
        textScaleFactor: 2.5,
        style: new TextStyle(
          color: Colors.red,
          fontStyle: FontStyle.italic
        ),
      ),
    );
  }
}