// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_capture_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ImageCaptureStore on _ImageCaptureStore, Store {
  late final _$mediaFileListAtom =
      Atom(name: '_ImageCaptureStore.mediaFileList', context: context);

  @override
  ObservableList<XFile> get mediaFileList {
    _$mediaFileListAtom.reportRead();
    return super.mediaFileList;
  }

  @override
  set mediaFileList(ObservableList<XFile> value) {
    _$mediaFileListAtom.reportWrite(value, super.mediaFileList, () {
      super.mediaFileList = value;
    });
  }

  late final _$_pickImageErrorAtom =
      Atom(name: '_ImageCaptureStore._pickImageError', context: context);

  @override
  String? get _pickImageError {
    _$_pickImageErrorAtom.reportRead();
    return super._pickImageError;
  }

  @override
  set _pickImageError(String? value) {
    _$_pickImageErrorAtom.reportWrite(value, super._pickImageError, () {
      super._pickImageError = value;
    });
  }

  late final _$_ImageCaptureStoreActionController =
      ActionController(name: '_ImageCaptureStore', context: context);

  @override
  void setPickImageError(String? value) {
    final _$actionInfo = _$_ImageCaptureStoreActionController.startAction(
        name: '_ImageCaptureStore.setPickImageError');
    try {
      return super.setPickImageError(value);
    } finally {
      _$_ImageCaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setImageFileListFromFile(XFile? value) {
    final _$actionInfo = _$_ImageCaptureStoreActionController.startAction(
        name: '_ImageCaptureStore._setImageFileListFromFile');
    try {
      return super._setImageFileListFromFile(value);
    } finally {
      _$_ImageCaptureStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
mediaFileList: ${mediaFileList}
    ''';
  }
}
