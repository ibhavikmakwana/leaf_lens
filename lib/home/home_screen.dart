import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leaf_lens/home/indentifying_screen/identifying_screen.dart';
import 'package:leaf_lens/home/store/image_capture_store.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImageCaptureStore _imageCaptureStore = ImageCaptureStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lens_blur_rounded),
            SizedBox(width: 8),
            Text('Leaf Lens'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'Leaf Lens',
                applicationVersion: '1.0.0',
                applicationIcon: const Icon(Icons.lens_blur_rounded),
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      'Leaf Lens is a mobile application that uses Gemini Pro Vision to identify diseases in plants.',
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              onTap: () async {
                bool canNavigate =
                    await _imageCaptureStore.pickImage(ImageSource.camera);
                if (canNavigate) {
                  if (context.mounted) {
                    Navigator.pushNamed(
                      context,
                      IdentifyingScreen.routeName,
                      arguments: _imageCaptureStore.mediaFileList.last,
                    );
                  }
                }
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.document_scanner_outlined),
                      const SizedBox(width: 16),
                      Flexible(
                        child: Text(
                          'Scan and identify the plant',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
