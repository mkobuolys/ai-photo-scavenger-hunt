part of 'game_bloc.dart';

sealed class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

final class GameStarted extends GameEvent {
  const GameStarted();
}

final class GameReset extends GameEvent {
  const GameReset();
}

final class GameLocationChanged extends GameEvent {
  const GameLocationChanged(this.location);

  final GameLocation location;

  @override
  List<Object> get props => [location];
}

final class GameScoreUpdated extends GameEvent {
  const GameScoreUpdated(this.score);

  final int score;

  @override
  List<Object> get props => [score];
}

final class GameFinished extends GameEvent {
  const GameFinished();
}
