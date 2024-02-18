import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../game/bloc/game_bloc.dart';
import '../../widgets/view_layout.dart';

class ScavengerHuntErrorView extends StatelessWidget {
  const ScavengerHuntErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewLayout(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('🫠', style: Theme.of(context).textTheme.displayLarge),
          const SizedBox(height: 16),
          Text(
            'AI decided to take a break...',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
      footer: FilledButton(
        onPressed: () => context.read<GameBloc>().add(const GameReset()),
        child: const Text('Try again'),
      ),
    );
  }
}
