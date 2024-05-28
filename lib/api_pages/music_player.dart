import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MusicPlayer extends StatelessWidget {
  final String query;

  MusicPlayer({required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('You Tube: $query'),
        backgroundColor: Colors.purple.shade100,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse('https://www.youtube.com/results?search_query=/$query')),
      ),
    );
  }
}
