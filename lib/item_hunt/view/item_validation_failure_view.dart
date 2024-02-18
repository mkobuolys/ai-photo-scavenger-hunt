import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/view_layout.dart';
import '../bloc/item_hunt_bloc.dart';
import '../widgets/hunt_progress.dart';
import '../widgets/skip_item_button.dart';

class ItemValidationFailureView extends StatelessWidget {
  const ItemValidationFailureView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewLayout(
      header: const HuntProgress(),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('🫠', style: Theme.of(context).textTheme.displayLarge),
          const SizedBox(height: 16),
          Text(
            "Nope, doesn't look like it.",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SkipItemButton(),
          const SizedBox(width: 8),
          FilledButton(
            onPressed: () => context
                .read<ItemHuntBloc>()
                .add(const ItemHuntReset(resetTimer: false)),
            child: const Text('Try again'),
          ),
        ],
      ),
    );
  }
}
