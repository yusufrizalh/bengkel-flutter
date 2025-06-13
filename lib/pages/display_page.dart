// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class DisplayPage extends StatefulWidget {
  const DisplayPage({super.key});

  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display Page'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text('Display Page')],
        ),
      ),
    );
  }
}
