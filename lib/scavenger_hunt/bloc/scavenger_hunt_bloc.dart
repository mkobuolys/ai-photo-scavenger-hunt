import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scavenger_hunt_repository/scavenger_hunt_repository.dart';

part 'scavenger_hunt_event.dart';
part 'scavenger_hunt_state.dart';

class ScavengerHuntBloc extends Bloc<ScavengerHuntEvent, ScavengerHuntState> {
  ScavengerHuntBloc({
    required this.repository,
  }) : super(const ScavengerHuntState()) {
    on<ScavengerHuntLoadStarted>(_onLoadStarted);
    on<ScavengerHuntStarted>(_onStarted);
    on<ScavengerHuntIndexIncremented>(_onIndexIncremented);
  }

  final ScavengerHuntRepository repository;

  Future<void> _onLoadStarted(
    ScavengerHuntLoadStarted event,
    Emitter<ScavengerHuntState> emit,
  ) async {
    final location = event.location;

    if (location == null) return;

    emit(state.copyWith(status: ScavengerHuntStatus.loading));

    try {
      final items = await repository.loadHunt(location);

      emit(state.copyWith(status: ScavengerHuntStatus.success, items: items));
    } on ScavengerHuntRepositoryException {
      emit(state.copyWith(status: ScavengerHuntStatus.failure));
    }
  }

  void _onStarted(
    ScavengerHuntStarted event,
    Emitter<ScavengerHuntState> emit,
  ) {
    emit(state.copyWith(status: ScavengerHuntStatus.started));
  }

  void _onIndexIncremented(
    ScavengerHuntIndexIncremented event,
    Emitter<ScavengerHuntState> emit,
  ) {
    emit(state.copyWith(index: state.index + 1));
  }
}
