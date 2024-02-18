import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class PhotoPicker {
  const PhotoPicker({
    required this.imagePicker,
  });

  final ImagePicker imagePicker;

  Future<Uint8List> takePhoto() async {
    try {
      final photo = await imagePicker.pickImage(source: ImageSource.camera);

      if (photo == null) throw const PhotoPickerException();

      final bytes = await photo.readAsBytes();

      return bytes;
    } on Exception {
      throw const PhotoPickerException();
    }
  }
}

class PhotoPickerException implements Exception {
  const PhotoPickerException();
}
