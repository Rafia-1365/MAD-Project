import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WikipediaPage extends StatelessWidget {
  final String query;

  WikipediaPage({required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wikipedia Page: $query'),
        backgroundColor: Colors.purple.shade100,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse('https://en.wikipedia.org/wiki/$query'),
        ),
      ),
    );
  }
}
