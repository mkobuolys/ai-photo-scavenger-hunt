import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/view_layout.dart';
import '../bloc/scavenger_hunt_bloc.dart';

class ScavengerHuntLoadedView extends StatelessWidget {
  const ScavengerHuntLoadedView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewLayout(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('🤖', style: Theme.of(context).textTheme.displayLarge),
          const SizedBox(height: 16),
          Text(
            'Your hunt is ready!',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
      footer: FilledButton(
        onPressed: () =>
            context.read<ScavengerHuntBloc>().add(const ScavengerHuntStarted()),
        child: const Text('Bring it on!'),
      ),
    );
  }
}
