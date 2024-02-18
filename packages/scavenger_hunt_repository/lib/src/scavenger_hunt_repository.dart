import 'dart:math' show Random;
import 'dart:typed_data';

import 'models/models.dart';

abstract interface class ScavengerHuntRepository {
  Future<List<String>> loadHunt(GameLocation location);
  Future<bool> validateImage(String item, Uint8List image);
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
}
