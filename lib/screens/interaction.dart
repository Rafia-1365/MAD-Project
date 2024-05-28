class Interaction {
  final String query;
  final String response;
  final DateTime timestamp;

  Interaction({
    required this.query,
    required this.response,
    required this.timestamp,
  });

  // Method to convert an Interaction object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'query': query,
      'response': response,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  // Optional: factory constructor to create an Interaction from a JSON map
  factory Interaction.fromJson(Map<String, dynamic> json) {
    return Interaction(
      query: json['query'],
      response: json['response'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
