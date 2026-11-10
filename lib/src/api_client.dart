import 'dart:convert';
import 'package:http/http.dart' as http;

class OneAiApiClient {
  OneAiApiClient({required this.baseUri, required this.token, http.Client? client}) : _client = client ?? http.Client();

  final Uri baseUri;
  final String token;
  final http.Client _client;

  Map<String, String> get _headers => {'Authorization': 'Bearer $token', 'Content-Type': 'application/json', 'Accept': 'text/event-stream'};

  Stream<String> chat({required String message, String? sessionId, String locale = 'en', String featureMode = 'general', List<String> knowledgeDocumentIds = const []}) async* {
    final response = await _client.send(http.Request('POST', baseUri.resolve('/api/chat'))
      ..headers.addAll(_headers)
      ..body = jsonEncode({'sessionId': sessionId, 'featureMode': featureMode, 'locale': locale, 'displayText': message, 'messages': [{'role': 'user', 'content': message}], if (knowledgeDocumentIds.isNotEmpty) 'knowledgeDocumentIds': knowledgeDocumentIds}));
    if (response.statusCode < 200 || response.statusCode >= 300) throw http.ClientException('OneAI API returned ${response.statusCode}', response.request?.url);
    await for (final line in response.stream.transform(utf8.decoder).transform(const LineSplitter())) {
      if (line.startsWith('data: ') && line.substring(6) != '[DONE]') yield line.substring(6);
    }
  }
}
