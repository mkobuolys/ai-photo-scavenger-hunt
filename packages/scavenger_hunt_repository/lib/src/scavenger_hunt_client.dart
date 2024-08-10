import 'dart:typed_data';

import 'package:firebase_vertexai/firebase_vertexai.dart';

class ScavengerHuntClient {
  ScavengerHuntClient()
      : _model = FirebaseVertexAI.instance.generativeModel(
          model: 'gemini-pro-vision',
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
    final promptText =
        'You are a scavenger hunt game where objects are found by taking a photo of them.'
        'You have been given the item "$item" and a photo of the item.'
        'Determine if the photo is a valid photo of the item.'
        'Provide your response as a JSON object with the following schema: {"valid": true/false}.'
        'Do not return your result as Markdown.';

    final response = await _model.generateContent([
      Content.multi([TextPart(promptText), DataPart('image/jpeg', image)]),
    ]);

    return response.text;
  }
}
