import 'package:flutter/material.dart';

import '../../widgets/view_layout.dart';

class ScavengerHuntLoadingView extends StatelessWidget {
  const ScavengerHuntLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewLayout(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('🤖', style: Theme.of(context).textTheme.displayLarge),
          const SizedBox(height: 16),
          Text(
            'AI is preparing your hunt...',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
      footer: const CircularProgressIndicator(),
    );
  }
}
