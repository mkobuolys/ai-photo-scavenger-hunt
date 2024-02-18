import 'dart:math' as math;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scavenger_hunt_repository/scavenger_hunt_repository.dart';

import '../../photo/photo_picker.dart';

part 'item_hunt_event.dart';
part 'item_hunt_state.dart';

class ItemHuntBloc extends Bloc<ItemHuntEvent, ItemHuntState> {
  ItemHuntBloc({
    required this.photoPicker,
    required this.repository,
  }) : super(const ItemHuntState()) {
    on<ItemHuntItemFound>(_onItemFound);
    on<ItemHuntReset>(_onReset);
  }

  final PhotoPicker photoPicker;
  final ScavengerHuntRepository repository;

  final _stopwatch = Stopwatch();

  @override
  Future<void> close() async {
    _stopwatch.stop();

    super.close();
  }

  Future<void> _onItemFound(
    ItemHuntItemFound event,
    Emitter<ItemHuntState> emit,
  ) async {
    emit(state.copyWith(status: ItemHuntStatus.validationInProgress));

    try {
      final image = await photoPicker.takePhoto();

      _stopwatch.stop();

      final itemFound = await repository.validateImage(event.item, image);

      if (!itemFound) {
        return emit(state.copyWith(status: ItemHuntStatus.validationFailure));
      }

      final scorePenalty = _stopwatch.elapsedMilliseconds ~/ 5000 * 5;
      final score = 100 - math.min<int>(scorePenalty, 50);

      emit(
        state.copyWith(status: ItemHuntStatus.validationSuccess, score: score),
      );
    } on PhotoPickerException {
      emit(state.copyWith(status: ItemHuntStatus.validationFailure));
    } on ScavengerHuntRepositoryException {
      emit(state.copyWith(status: ItemHuntStatus.validationFailure));
    }
  }

  void _onReset(ItemHuntReset event, Emitter<ItemHuntState> emit) {
    if (event.resetTimer) _stopwatch.reset();

    _stopwatch.start();

    emit(const ItemHuntState());
  }
}
