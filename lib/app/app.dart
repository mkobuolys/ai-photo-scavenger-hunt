import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scavenger_hunt_repository/scavenger_hunt_repository.dart';

import '../game/view/game_page.dart';
import '../photo/photo_picker.dart';

class App extends StatelessWidget {
  const App({
    required this.photoPicker,
    required this.repository,
    super.key,
  });

  final PhotoPicker photoPicker;
  final ScavengerHuntRepository repository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: photoPicker),
        RepositoryProvider.value(value: repository),
      ],
      child: const _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI scavenger hunt',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GamePage(),
    );
  }
}
