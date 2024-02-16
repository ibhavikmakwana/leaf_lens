import 'dart:developer';

import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'image_capture_store.g.dart';

// ignore: library_private_types_in_public_api
class ImageCaptureStore = _ImageCaptureStore with _$ImageCaptureStore;

abstract class _ImageCaptureStore with Store {
  final ImagePicker _picker = ImagePicker();

  @observable
  ObservableList<XFile> mediaFileList = ObservableList<XFile>();

  @observable
  String? _pickImageError;

  @action
  void setPickImageError(String? value) => _pickImageError = value;

  @action
  void _setImageFileListFromFile(XFile? value) {
    if (value != null) {
      mediaFileList.add(value);
    }
  }

  Future<bool> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
      );
      if (pickedFile == null) {
        return false;
      }
      _setImageFileListFromFile(pickedFile);
      return true;
    } catch (e, st) {
      setPickImageError('$e');
      log('onImageButtonPressed Error: $e\n$st');
      return false;
    }
  }
}
