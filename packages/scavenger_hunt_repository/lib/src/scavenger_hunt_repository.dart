import 'dart:convert';
import 'dart:math' show Random;
import 'dart:typed_data';

import 'package:google_generative_ai/google_generative_ai.dart';

import 'models/models.dart';
import 'scavenger_hunt_client.dart';

class ScavengerHuntRepository {
  const ScavengerHuntRepository({
    required ScavengerHuntClient client,
  }) : _client = client;

  final ScavengerHuntClient _client;

  Future<List<String>> loadHunt(GameLocation gameLocation) async {
    final location = switch (gameLocation) {
      GameLocation.home => 'at home',
      GameLocation.outside => 'outside',
    };

    try {
      final response = await _client.generateScavengerHuntItems(location);

      if (response == null) {
        throw const ScavengerHuntRepositoryException('Response is empty');
      }

      if (jsonDecode(response) case {'items': List<dynamic> items}) {
        return List<String>.from(items);
      }

      throw const ScavengerHuntRepositoryException('Invalid JSON schema');
    } on GenerativeAIException {
      throw const ScavengerHuntRepositoryException(
        'Problem with the Generative AI service',
      );
    } catch (e) {
      if (e is ScavengerHuntRepositoryException) rethrow;

      throw const ScavengerHuntRepositoryException();
    }
  }

  Future<bool> validateImage(String item, Uint8List image) async {
    try {
      final response = await _client.validateImage(item, image);

      if (response == null) {
        throw const ScavengerHuntRepositoryException('Response is empty');
      }

      if (jsonDecode(response) case {'valid': bool valid}) return valid;

      throw const ScavengerHuntRepositoryException('Invalid JSON schema');
    } on GenerativeAIException {
      throw const ScavengerHuntRepositoryException(
        'Problem with the Generative AI service',
      );
    } catch (e) {
      if (e is ScavengerHuntRepositoryException) rethrow;

      throw const ScavengerHuntRepositoryException();
    }
  }
}

class FakeScavengerHuntRepository implements ScavengerHuntRepository {
  const FakeScavengerHuntRepository();

  @override
  Future<List<String>> loadHunt(GameLocation location) async {
    await Future.delayed(const Duration(seconds: 2));

    return switch (location) {
      GameLocation.home => const ['Couch', 'Table', 'TV', 'Lamp', 'Book'],
      GameLocation.outside => const ['Tree', 'Bench', 'Car', 'Mailbox', 'Bird'],
    };
  }

  @override
  Future<bool> validateImage(String item, Uint8List image) async {
    await Future.delayed(const Duration(seconds: 2));

    return Random().nextDouble() < 0.8;
  }

  @override
  // ignore: unused_element
  ScavengerHuntClient get _client => throw UnimplementedError();
}

class ScavengerHuntRepositoryException implements Exception {
  const ScavengerHuntRepositoryException([this.message = 'Unkown problem']);

  final String message;

  @override
  String toString() => 'ScavengerHuntRepositoryException: $message';
}
