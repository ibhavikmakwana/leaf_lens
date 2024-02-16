// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identifying_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$IdentifyingStore on _IdentifyingStore, Store {
  late final _$identifyErrorAtom =
      Atom(name: '_IdentifyingStore.identifyError', context: context);

  @override
  String? get identifyError {
    _$identifyErrorAtom.reportRead();
    return super.identifyError;
  }

  @override
  set identifyError(String? value) {
    _$identifyErrorAtom.reportWrite(value, super.identifyError, () {
      super.identifyError = value;
    });
  }

  late final _$responseAtom =
      Atom(name: '_IdentifyingStore.response', context: context);

  @override
  GenerateContentResponse? get response {
    _$responseAtom.reportRead();
    return super.response;
  }

  @override
  set response(GenerateContentResponse? value) {
    _$responseAtom.reportWrite(value, super.response, () {
      super.response = value;
    });
  }

  late final _$identifyImageAsyncAction =
      AsyncAction('_IdentifyingStore.identifyImage', context: context);

  @override
  Future<void> identifyImage(XFile image) {
    return _$identifyImageAsyncAction.run(() => super.identifyImage(image));
  }

  late final _$_IdentifyingStoreActionController =
      ActionController(name: '_IdentifyingStore', context: context);

  @override
  void setIdentifyError(String? value) {
    final _$actionInfo = _$_IdentifyingStoreActionController.startAction(
        name: '_IdentifyingStore.setIdentifyError');
    try {
      return super.setIdentifyError(value);
    } finally {
      _$_IdentifyingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
identifyError: ${identifyError},
response: ${response}
    ''';
  }
}
