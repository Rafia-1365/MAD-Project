import 'package:flutter/material.dart';
import 'interaction.dart';
import 'package:voice_assistant/utils/color_utils.dart';

class HistoryPage extends StatelessWidget {
  final List<Interaction> interactions;

  HistoryPage({required this.interactions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: Colors.purple.shade100,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              hexStringToColor("CB22B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4"),
            ],
          ),
        ),
      child: ListView.builder(
        itemCount: interactions.length,
        itemBuilder: (context, index) {
          var interaction = interactions[index];
          return ListTile(
            title: Text(interaction.query),
            subtitle: Text(interaction.response),
            trailing: Text(interaction.timestamp.toString()),
          );
        },
      ),
    ));
  }
}
