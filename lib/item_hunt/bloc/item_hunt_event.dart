part of 'item_hunt_bloc.dart';

sealed class ItemHuntEvent extends Equatable {
  const ItemHuntEvent();

  @override
  List<Object> get props => [];
}

final class ItemHuntItemFound extends ItemHuntEvent {
  const ItemHuntItemFound(this.item);

  final String item;

  @override
  List<Object> get props => [item];
}

final class ItemHuntReset extends ItemHuntEvent {
  const ItemHuntReset({
    this.resetTimer = true,
  });

  final bool resetTimer;

  @override
  List<Object> get props => [resetTimer];
}
