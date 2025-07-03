import 'dart:convert';

class ChatResponse {
  final String sessionId;
  final String response;

  ChatResponse({
    required this.sessionId,
    required this.response,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      sessionId: json['session_id'] as String,
      response: json['response'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'session_id': sessionId,
      'response': response,
    };
  }

  @override
  String toString() => 'ChatResponse(sessionId: $sessionId, response: $response)';
}

// Helper functions for converting from/to JSON string
ChatResponse chatResponseFromJson(String str) =>
    ChatResponse.fromJson(json.decode(str));

String chatResponseToJson(ChatResponse data) => json.encode(data.toJson());
