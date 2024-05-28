import 'package:flutter/material.dart';
import 'package:voice_assistant/screens/Discription1_page.dart';
import 'package:voice_assistant/utils/color_utils.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.purple.shade100,
        iconTheme: IconThemeData(size: 30.0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.8, // Adjust this value as needed
                  children: List.generate(
                    8,
                        (index) => WidgetCard(index + 1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WidgetCard extends StatelessWidget {
  final int index;

  WidgetCard(this.index);

  void _navigateToDescriptionPage(BuildContext context) {
    String title;
    String description;
    String imagePath;

    // Set title, description, and image path based on the index
    switch (index) {
      case 1:
        title = 'YouTube';
        description = 'YouTube is a video-sharing platform. If you want to play a video, just speak into the mic.';
        imagePath = 'assets/youtube.png';
        break;
      case 2:
        title = 'Facts';
        description = 'Facts are all about random happening all around the world. If you want to know facts, just speak into the mic.';
        imagePath = 'assets/facts.png';
        break;
      case 3:
        title = 'Wikipedia';
        description = 'Wikipedia is a free online encyclopedia. If you want any document, just speak into the mic.';
        imagePath = 'assets/wikipedia.png';
        break;
      case 4:
        title = 'Jokes';
        description = 'Enjoy some funny jokes! If you want jokes, just speak into the mic.';
        imagePath = 'assets/jokes.png';
        break;
      case 5:
        title = 'News';
        description = 'Stay updated with the latest news. If you want some latest news, just speak into the mic.';
        imagePath = 'assets/news.png';
        break;
      case 6:
        title = 'Weather';
        description = 'Check the current weather conditions. If you want to know about the weather, just speak into the mic.';
        imagePath = 'assets/weather.png';
        break;
      case 7:
        title = 'Introductory';
        description = 'Introduction to something. If you want to have friendly chit-chat, just speak into the mic.';
        imagePath = 'assets/introductory.png';
        break;
      default:
        title = 'Date & Time';
        description = 'Display current date and time. If you want to know about the time or date, just speak into the mic.';
        imagePath = 'assets/datetime.png';
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Description(
          title: title,
          description: description,
          imagePath: imagePath,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String imagePath;
    String title;

    // Set image path and title based on the index
    switch (index) {
      case 1:
        imagePath = 'assets/youtube.png';
        title = 'YouTube';
        break;
      case 2:
        imagePath = 'assets/facts.png';
        title = 'Facts';
        break;
      case 3:
        imagePath = 'assets/wikipedia.png';
        title = 'Wikipedia';
        break;
      case 4:
        imagePath = 'assets/jokes.png';
        title = 'Jokes';
        break;
      case 5:
        imagePath = 'assets/news.png';
        title = 'News';
        break;
      case 6:
        imagePath = 'assets/weather.png';
        title = 'Weather';
        break;
      case 7:
        imagePath = 'assets/introductory.png';
        title = 'Introductory';
        break;
      default:
        imagePath = 'assets/datetime.png'; // Provide a default image if index doesn't match
        title = 'Date & time';
    }

    return GestureDetector(
      onTap: () => _navigateToDescriptionPage(context),
      child: Card(
        elevation: 5.0,
        color: Colors.purple.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 2,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 5),
            Flexible(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
