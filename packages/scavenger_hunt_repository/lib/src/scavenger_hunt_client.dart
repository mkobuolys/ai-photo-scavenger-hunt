import 'dart:typed_data';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart';

class ScavengerHuntClient {
  ScavengerHuntClient({
    required String apiKey,
  }) : _model = GenerativeModel(
          model: 'gemini-pro-vision',
          apiKey: apiKey,
        );

  ScavengerHuntClient.vertexAi({
    required String apiKey,
    required String projectUrl,
  }) : _model = GenerativeModel(
          model: 'gemini-pro-vision',
          apiKey: apiKey,
          httpClient: VertexHttpClient(projectUrl),
        );

  final GenerativeModel _model;

  Future<String?> generateScavengerHuntItems(String location) async {
    final prompt =
        'You are a scavenger hunt game where objects are found by taking a photo of them.'
        'Generate a list of 5 items that could be found in the following location: $location.'
        'The difficulty to find the items should be easy, but some items could be a little bit more difficult to find.'
        'Keep the item name concise. All letters should be uppercase. Do not include articles (a, an, the).'
        'Provide your response as a JSON object with the following schema: {"items": ["", "", ...]}.'
        'Do not return your result as Markdown.';

    final response = await _model.generateContent([Content.text(prompt)]);

    return response.text;
  }

  Future<String?> validateImage(String item, Uint8List image) async {
    final prompt =
        'You are a scavenger hunt game where objects are found by taking a photo of them.'
        'You have been given the item "$item" and a photo of the item.'
        'Determine if the photo is a valid photo of the item.'
        'Provide your response as a JSON object with the following schema: {"valid": true/false}.'
        'Do not return your result as Markdown.';

    final response = await _model.generateContent([
      Content.multi([TextPart(prompt), DataPart('image/jpeg', image)]),
    ]);

    return response.text;
  }
}

// This class is borrowed from here:
// https://github.com/leancodepl/arb_translate/blob/main/lib/src/translation_delegates/gemini_translation_delegate.dart#L233
class VertexHttpClient extends BaseClient {
  VertexHttpClient(this._projectUrl);

  final String _projectUrl;
  final _client = Client();

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    if (request is! Request ||
        request.url.host != 'generativelanguage.googleapis.com') {
      return _client.send(request);
    }

    final vertexRequest = Request(
      request.method,
      Uri.parse(
        request.url.toString().replaceAll(
              'https://generativelanguage.googleapis.com/v1/models',
              _projectUrl,
            ),
      ),
    )..bodyBytes = request.bodyBytes;

    for (final header in request.headers.entries) {
      if (header.key != 'x-goog-api-key') {
        vertexRequest.headers[header.key] = header.value;
      }
    }

    vertexRequest.headers['Authorization'] =
        'Bearer ${request.headers['x-goog-api-key']}';

    return _client.send(vertexRequest);
  }
}
