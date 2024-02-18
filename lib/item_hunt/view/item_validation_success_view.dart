import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../game/bloc/game_bloc.dart';
import '../../scavenger_hunt/bloc/scavenger_hunt_bloc.dart';
import '../../widgets/view_layout.dart';
import '../bloc/item_hunt_bloc.dart';
import '../widgets/hunt_progress.dart';

class ItemValidationSuccessView extends StatelessWidget {
  const ItemValidationSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ItemHuntBloc, ItemHuntState, int>(
      selector: (state) => state.score,
      builder: (context, score) => ViewLayout(
        header: const HuntProgress(),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('🤩', style: Theme.of(context).textTheme.displayLarge),
            const SizedBox(height: 16),
            Text(
              'You found it!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '+$score',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        footer: BlocBuilder<ScavengerHuntBloc, ScavengerHuntState>(
          builder: (context, state) {
            final ScavengerHuntState(items: items, index: index) = state;
            final lastItem = index == items.length - 1;

            return lastItem
                ? FilledButton(
                    onPressed: () => context
                      ..read<GameBloc>().add(GameScoreUpdated(score))
                      ..read<GameBloc>().add(const GameFinished()),
                    child: const Text('End your hunt'),
                  )
                : FilledButton(
                    onPressed: () => context
                      ..read<GameBloc>().add(GameScoreUpdated(score))
                      ..read<ScavengerHuntBloc>().add(
                        const ScavengerHuntIndexIncremented(),
                      )
                      ..read<ItemHuntBloc>().add(const ItemHuntReset()),
                    child: const Text('Next item'),
                  );
          },
        ),
      ),
    );
  }
}
