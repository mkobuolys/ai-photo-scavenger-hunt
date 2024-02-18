part of 'item_hunt_bloc.dart';

enum ItemHuntStatus {
  initial,
  validationInProgress,
  validationSuccess,
  validationFailure
}

final class ItemHuntState extends Equatable {
  const ItemHuntState({
    this.status = ItemHuntStatus.initial,
    this.score = 0,
  });

  final ItemHuntStatus status;
  final int score;

  @override
  List<Object> get props => [status, score];

  ItemHuntState copyWith({
    ItemHuntStatus? status,
    int? score,
  }) {
    return ItemHuntState(
      status: status ?? this.status,
      score: score ?? this.score,
    );
  }
}
