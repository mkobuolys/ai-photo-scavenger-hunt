part of 'scavenger_hunt_bloc.dart';

enum ScavengerHuntStatus { initial, loading, success, failure, started }

final class ScavengerHuntState extends Equatable {
  const ScavengerHuntState({
    this.status = ScavengerHuntStatus.initial,
    this.items = const [],
    this.index = 0,
  });

  final ScavengerHuntStatus status;
  final List<String> items;
  final int index;

  @override
  List<Object> get props => [status, items, index];

  ScavengerHuntState copyWith({
    ScavengerHuntStatus? status,
    List<String>? items,
    int? index,
  }) {
    return ScavengerHuntState(
      status: status ?? this.status,
      items: items ?? this.items,
      index: index ?? this.index,
    );
  }
}
