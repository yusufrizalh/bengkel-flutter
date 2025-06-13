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
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: const Text('Display Page'),
              centerTitle: true,
              expandedHeight: 200,
              floating: true,
              snap: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/images/sliver_header_bg.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.person),
                  onPressed: () {
                    // Handle person action
                  },
                ),
              ],
            ),
          ];
        },
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[],
          ),
        ),
      ),
    );
  }
}
