part of 'game_bloc.dart';

enum GameStatus { initial, inProgress, finished }

final class GameState extends Equatable {
  const GameState({
    this.status = GameStatus.initial,
    this.score = 0,
    this.location,
  });

  final GameStatus status;
  final int score;
  final GameLocation? location;

  @override
  List<Object?> get props => [status, score, location];

  GameState copyWith({
    GameStatus? status,
    int? score,
    GameLocation? location,
  }) {
    return GameState(
      status: status ?? this.status,
      score: score ?? this.score,
      location: location ?? this.location,
    );
  }
}
