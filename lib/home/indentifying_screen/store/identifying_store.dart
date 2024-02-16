import 'dart:developer';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leaf_lens/build_config.dart';
import 'package:mobx/mobx.dart';
import 'package:mime/mime.dart' show lookupMimeType;

part 'identifying_store.g.dart';

// ignore: library_private_types_in_public_api
class IdentifyingStore = _IdentifyingStore with _$IdentifyingStore;

abstract class _IdentifyingStore with Store {
  @observable
  String? identifyError;

  @observable
  GenerateContentResponse? response;

  @action
  void setIdentifyError(String? value) => identifyError = value;

  final model = GenerativeModel(
    model: 'gemini-pro-vision',
    apiKey: BuildConfig.apiKey,
  );

  @action
  Future<void> identifyImage(XFile image) async {
    try {
      final String? mime = lookupMimeType(image.path);
      if (mime == null) {
        setIdentifyError('Invalid image type');
        return;
      }
      final bytes = await image.readAsBytes();
      final prompt = TextPart(
        'Please identify this plant and any potential diseases based on the image and details provided. If a disease is present, offer suggestions for treatment and prevention. Format the response in a way suitable for Markdown (.md) file, also if the image is not clear, or does not contain a plant, please indicate so and return it as an error message.',
      );
      final imageParts = [
        DataPart('image/jpeg', bytes),
      ];
      response = await model.generateContent([
        Content.multi([prompt, ...imageParts])
      ]);
    } catch (e, st) {
      log('identifyImage Error: $e\n$st');
      setIdentifyError('$e');
    }
  }
}
