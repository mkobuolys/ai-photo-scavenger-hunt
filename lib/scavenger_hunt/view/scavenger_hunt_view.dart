import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scavenger_hunt_repository/scavenger_hunt_repository.dart';

import '../../game/bloc/game_bloc.dart';
import '../../item_hunt/view/item_hunt_view.dart';
import '../bloc/scavenger_hunt_bloc.dart';
import 'scavenger_hunt_error_view.dart';
import 'scavenger_hunt_loaded_view.dart';
import 'scavenger_hunt_loading_view.dart';

class ScavengerHuntView extends StatelessWidget {
  const ScavengerHuntView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<GameBloc, GameState, GameLocation?>(
      selector: (state) => state.location,
      builder: (context, location) => BlocProvider(
        create: (context) => ScavengerHuntBloc(
          repository: context.read<ScavengerHuntRepository>(),
        )..add(ScavengerHuntLoadStarted(location)),
        child: const _View(),
      ),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScavengerHuntBloc, ScavengerHuntState>(
      builder: (context, state) => switch (state.status) {
        ScavengerHuntStatus.initial ||
        ScavengerHuntStatus.loading =>
          const ScavengerHuntLoadingView(),
        ScavengerHuntStatus.success => const ScavengerHuntLoadedView(),
        ScavengerHuntStatus.failure => const ScavengerHuntErrorView(),
        ScavengerHuntStatus.started => const ItemHuntView(),
      },
    );
  }
}
