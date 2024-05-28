import 'package:flutter/material.dart';
import 'package:voice_assistant/screens/Help_page.dart';
import 'package:voice_assistant/screens/signin_screen.dart';
import 'package:voice_assistant/utils/color_utils.dart';
import 'package:voice_assistant/api_pages/voice_assistant.dart';
import 'package:voice_assistant/screens/history_page.dart';
import 'package:voice_assistant/screens/interaction.dart';

class HomePage extends StatelessWidget {
  final List<Interaction> interactions = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pink.shade50,
        iconTheme: IconThemeData(size: 35.0),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 100,
              child: DrawerHeader(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.purple.shade50,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.purple,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.purple,
                ),
              ),
              leading: Icon(
                Icons.logout,
                color: Colors.purple, // Set icon color to purple
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
              },
            ),
            ListTile(
              title: Text(
                'History',
                style: TextStyle(
                  color: Colors.purple,
                ),
              ),
              leading: Icon(
                Icons.history,
                color: Colors.purple,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoryPage(interactions: interactions),
                  ),
                );// Add your history functionality here
              },
            ),
            ListTile(
              title: Text(
                'Help',
                style: TextStyle(
                  color: Colors.purple,
                ),
              ),
              leading: Icon(
                Icons.help,
                color: Colors.purple,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HelpPage())); // Add your help functionality here
              },
            ),
          ],
        ),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(// Wrap the Text widget with Center widget
              child: Text(
                'Welcome to the Voice \n \t \t \t \t \t Assistant',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 80),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VoiceAssistant(interactions: interactions), // Pass interactions list here
                    ),
                  );
                },
                child: Icon(Icons.mic),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Colors.purple.shade100,
                  padding: EdgeInsets.all(25),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Press here',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
