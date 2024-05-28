import 'dart:math';

import 'package:flutter/material.dart';
import 'package:voice_assistant/utils/color_utils.dart';
class Description extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  Description({
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.pink.shade100,
      ),
    body: Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
    gradient: LinearGradient(
    colors: [
    hexStringToColor("CB22B93"),
    hexStringToColor("9546C4"),
    hexStringToColor("5E61F4"),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    ),
    ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,

                ),
                color: Colors.pink.shade100,
              ),

            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
