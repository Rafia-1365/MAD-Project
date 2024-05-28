import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'weather.dart'; // Import Weather class
import 'news.dart';
import 'jokes.dart';
import 'datetime.dart';
import 'music_player.dart';
import 'randfacts.dart'; // Import getFact function
import 'wikipedia_page.dart';
import 'package:voice_assistant/utils/color_utils.dart';
import 'package:voice_assistant/screens/interaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VoiceAssistant extends StatefulWidget {
  final List<Interaction> interactions;

  VoiceAssistant({required this.interactions});

  @override
  _VoiceAssistantState createState() => _VoiceAssistantState();
}

class _VoiceAssistantState extends State<VoiceAssistant> {
  FlutterTts flutterTts = FlutterTts();
  stt.SpeechToText speech = stt.SpeechToText();
  bool isListening = false;
  String text = "How can I help you?";
  String spokenText = "";

  @override
  void initState() {
    super.initState();
    initializeTtsAndStt();
    greetUser(); // Greet the user when the app initializes
  }

  void initializeTtsAndStt() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    bool available = await speech.initialize();
    if (available) {
      setState(() {
        text = "Voice assistant is ready";
        print("Speech recognition initialized");
      });
    } else {
      setState(() {
        text = "Speech recognition not available";
        print("Speech recognition not available");
      });
    }
  }

  void greetUser() {
    speak("", "Hello Ma'am. Good " + wishMe() + ". I am your voice assistant. How are you?");
  }

  void speak(String query, String response) async {
    print("Assistant: $response"); // Print assistant's response
    print("Speaking: $response");
    setState(() {
      spokenText = response; // Update spoken text
    });
    await flutterTts.speak(response);

    // Store interaction in Firestore
    Interaction interaction = Interaction(
      query: query,
      response: response,
      timestamp: DateTime.now(),
    );
    FirebaseFirestore.instance.collection('interactions').add(interaction.toJson());

    // Update local interactions list
    setState(() {
      widget.interactions.add(interaction);
    });
  }

  void listen() async {
    if (!isListening) {
      bool available = await speech.initialize();
      if (available) {
        setState(() => isListening = true);
        print("Listening...");
        speech.listen(onResult: (val) {
          setState(() {
            text = val.recognizedWords;
          });
          if (val.finalResult) {
            setState(() {
              isListening = false;
              processCommand(val.recognizedWords); // Store the recognized command
            });
            speech.stop(); // Process the stored command
          }
        });
      }
    } else {
      setState(() => isListening = false);
      speech.stop();
      print("Stopped listening");
    }
  }

  String wishMe() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return "morning";
    } else if (hour < 17) {
      return "afternoon";
    } else if (hour < 20) {
      return "evening";
    } else {
      return "night";
    }
  }

  void processCommand(String command) async {
    print("Processing command: $command"); // Debug print
    command = command.toLowerCase();
    if (command.contains("how are you") || command.contains("about you")) {
      speak(command, "I'm doing well, thank you for asking. How can I assist you?");
    } else if (command.contains("i am good") || command.contains("fine") || command.contains("good")) {
      speak(command, "Good! How can I help you?");
    } else if (command.contains("what is your name") || command.contains("your name") || command.contains("name")) {
      speak(command, "My name is Robo. What's yours?");
    } else if (command.contains("my name is")) {
      speak(command, "Beautiful name.");
    } else if (command.contains("am i beautiful")) {
      speak(command, "I can't see you but I think you are beautiful with a good soul.");
    } else if (command.contains("thank you") || command.contains("thanks")) {
      speak(command, "You are welcome. Feel free to ask anything.");
    } else if (command.contains("hello") || command.contains("hi")) {
      speak(command, "Yes Dear! How can I help you?");
    } else if (command.contains("favourite")) {
      speak(command, "I am a Virtual assistant. I don't have favorites like humans.");
    } else if (command.contains("you can provide") || command.contains("you provided")) {
      speak(command, "I can provide you every kind of information. Which kind of information do you need?");
    } else if (command.contains("information")) {
      speak(command, "Which information do you need?");
      listenForWikipediaQuery();
    } else if (command.contains("video") || command.contains("play")) {
      speak(command, "Which video do you want to play?");
      listenForMusicQuery();
    } else if (command.contains("fact")) {
      speak(command, "Sure! Now I will tell you a fact.");
      String fact = await getFact();
      speak(command, fact);
    } else if (command.contains("news")) {
      speak(command, "Sure! Now I will read news for you.");
      List<String> news = await fetchNews();
      for (var item in news) {
        speak(command, item);
      }
    } else if (command.contains("joke")) {
      speak(command, "Sure! Get ready for some chuckles.");
      List<String> joke = await fetchJoke();
      speak(command, joke[0]);
      speak(command, joke[1]);
    } else if (command.contains("date")) {
      speak(command, "Today is:");
      String date = getDate();
      speak(command, date);
    } else if (command.contains("time")) {
      speak(command, "The time is:");
      String time = getTime();
      speak(command, time);
    } else if (command.contains("temperature") || command.contains("weather")) {
      fetchWeather("Faisalabad");
    } else {
      speak(command, "Sorry, I didn't understand your command. Please try some other words.");
    }
  }

  void fetchWeather(String city) async {
    Weather weather = Weather(city: city);
    double temperature = await weather.getTemperature();
    String description = await weather.getDescription();
    speak("", "The current temperature in $city is $temperature degrees Celsius and it is $description outside.");
  }

  void listenForWikipediaQuery() async {
    // Activate listening mode to get the next command
    if (!isListening) {
      bool available = await speech.initialize();
      if (available) {
        setState(() => isListening = true);
        print("Listening for Wikipedia query...");
        speech.listen(onResult: (val) {
          if (val.finalResult) {
            setState(() {
              isListening = false;
              String query = val.recognizedWords;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WikipediaPage(query: query),
                ),
              );
            });
            speech.stop();
          }
        });
      }
    } else {
      setState(() => isListening = false);
      speech.stop();
      print("Stopped listening");
    }
  }

  void listenForMusicQuery() async {
    // Activate listening mode to get the next command
    if (!isListening) {
      bool available = await speech.initialize();
      if (available) {
        setState(() => isListening = true);
        print("Listening for music query...");
        speech.listen(onResult: (val) {
          if (val.finalResult) {
            setState(() {
              isListening = false;
              String query = val.recognizedWords;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MusicPlayer(query: query),
                ),
              );
            });
            speech.stop();
          }
        });
      }
    } else {
      setState(() => isListening = false);
      speech.stop();
      print("Stopped listening");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Voice Assistant',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/assistant.png', // Replace 'your_image.png' with your image path
                height: 280, // Adjust the height as needed
                width: 280, // Adjust the width as needed
              ),
              Text(
                text,
                style: TextStyle(fontSize: 20), // Change the font size as needed
              ),
              SizedBox(height: 30),
              Text(
                spokenText,
                style: TextStyle(fontSize: 20),
              ), // Display spoken text
              SizedBox(height: 20),
              FloatingActionButton(
                onPressed: () async{
                  await Permission.microphone.request();
                  listen();
                  },
                child: Icon(isListening ? Icons.mic : Icons.mic_none, size: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
