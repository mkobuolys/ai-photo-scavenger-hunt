import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scavenger_hunt_repository/scavenger_hunt_repository.dart';

import '../../widgets/view_layout.dart';
import '../bloc/game_bloc.dart';

class SelectLocationView extends StatelessWidget {
  const SelectLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<GameBloc, GameState, GameLocation?>(
      selector: (state) => state.location,
      builder: (context, location) => ViewLayout(
        content: Column(
          children: [
            Image.asset('assets/logo.png', width: 200),
            const SizedBox(height: 32),
            Text(
              'Choose your hunting location',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: _LocationCard(
                    icon: '🏠',
                    title: 'Home',
                    selected: location == GameLocation.home,
                    onTap: () => context
                        .read<GameBloc>()
                        .add(const GameLocationChanged(GameLocation.home)),
                  ),
                ),
                Expanded(
                  child: _LocationCard(
                    icon: '🌳',
                    title: 'Outside',
                    selected: location == GameLocation.outside,
                    onTap: () => context
                        .read<GameBloc>()
                        .add(const GameLocationChanged(GameLocation.outside)),
                  ),
                ),
              ],
            ),
          ],
        ),
        footer: FilledButton(
          onPressed: location != null
              ? () => context.read<GameBloc>().add(const GameStarted())
              : null,
          child: const Text('Start hunting'),
        ),
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  const _LocationCard({
    required this.icon,
    required this.onTap,
    required this.selected,
    required this.title,
  });

  final String icon;
  final VoidCallback onTap;
  final bool selected;
  final String title;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16);

    return Card(
      color: selected ? Theme.of(context).primaryColor : null,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      margin: const EdgeInsets.all(8),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(icon, style: Theme.of(context).textTheme.displayLarge),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: selected
                          ? Theme.of(context).colorScheme.onPrimary
                          : null,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
