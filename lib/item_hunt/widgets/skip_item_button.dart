import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../game/bloc/game_bloc.dart';
import '../../scavenger_hunt/bloc/scavenger_hunt_bloc.dart';
import '../bloc/item_hunt_bloc.dart';

class SkipItemButton extends StatelessWidget {
  const SkipItemButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScavengerHuntBloc, ScavengerHuntState>(
      builder: (context, state) {
        final ScavengerHuntState(items: items, index: index) = state;
        final lastItem = index == items.length - 1;

        return OutlinedButton(
          onPressed: lastItem
              ? () => context.read<GameBloc>().add(const GameFinished())
              : () => context
                ..read<ScavengerHuntBloc>()
                    .add(const ScavengerHuntIndexIncremented())
                ..read<ItemHuntBloc>().add(const ItemHuntReset()),
          child: const Text('Skip'),
        );
      },
    );
  }
}
