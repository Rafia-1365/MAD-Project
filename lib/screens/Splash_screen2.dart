import 'package:voice_assistant/screens/Home_page.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller; // Declare a VideoPlayerController variable

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/Splash_video3.mp4'); // Provide the path to your video file
    _controller.initialize().then((_) {
      setState(() {
        _controller.play(); // Play the video once it's initialized
      });
    })
        .catchError((error) {
      print("Error initializing video player: $error");
    });
    // Navigate to SignInScreen after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose(); // Dispose the VideoPlayerController when the widget is disposed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller), // Show VideoPlayer widget
        )
            : CircularProgressIndicator(), // Show loading indicator until video is initialized
      ),
    );
  }
}
