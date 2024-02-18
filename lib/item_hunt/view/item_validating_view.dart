import 'package:flutter/material.dart';

import '../../widgets/view_layout.dart';
import '../widgets/hunt_progress.dart';

class ItemValidatingView extends StatelessWidget {
  const ItemValidatingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewLayout(
      header: const HuntProgress(),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('🤖', style: Theme.of(context).textTheme.displayLarge),
          const SizedBox(height: 16),
          Text(
            'AI is validating the photo...',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
      footer: const CircularProgressIndicator(),
    );
  }
}
