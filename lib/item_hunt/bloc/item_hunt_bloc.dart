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

  Future<void> _onItemFound(
    ItemHuntItemFound event,
    Emitter<ItemHuntState> emit,
  ) async {
    emit(state.copyWith(status: ItemHuntStatus.validationInProgress));

    try {
      final image = await photoPicker.takePhoto();

      final itemFound = await repository.validateImage(event.item, image);

      final updatedState = itemFound
          ? state.copyWith(status: ItemHuntStatus.validationSuccess, score: 100)
          : state.copyWith(status: ItemHuntStatus.validationFailure);

      emit(updatedState);
    } on PhotoPickerException {
      emit(state.copyWith(status: ItemHuntStatus.validationFailure));
    }
  }

  void _onReset(ItemHuntReset event, Emitter<ItemHuntState> emit) {
    emit(const ItemHuntState());
  }
}
