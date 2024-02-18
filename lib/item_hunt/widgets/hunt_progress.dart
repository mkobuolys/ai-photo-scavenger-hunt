import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../game/bloc/game_bloc.dart';
import '../../scavenger_hunt/bloc/scavenger_hunt_bloc.dart';

class HuntProgress extends StatelessWidget {
  const HuntProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScavengerHuntBloc, ScavengerHuntState>(
      builder: (context, state) {
        final ScavengerHuntState(items: items, index: index) = state;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Items left: ${items.length - index}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            BlocSelector<GameBloc, GameState, int>(
              selector: (state) => state.score,
              builder: (context, score) => Text(
                '$score/${items.length * 100}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        );
      },
    );
  }
}
