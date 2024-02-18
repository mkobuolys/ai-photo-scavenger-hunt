part of 'scavenger_hunt_bloc.dart';

sealed class ScavengerHuntEvent extends Equatable {
  const ScavengerHuntEvent();

  @override
  List<Object?> get props => [];
}

final class ScavengerHuntLoadStarted extends ScavengerHuntEvent {
  const ScavengerHuntLoadStarted(this.location);

  final GameLocation? location;

  @override
  List<Object?> get props => [location];
}

final class ScavengerHuntStarted extends ScavengerHuntEvent {
  const ScavengerHuntStarted();
}

final class ScavengerHuntIndexIncremented extends ScavengerHuntEvent {
  const ScavengerHuntIndexIncremented();
}
