import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:leaf_lens/home/indentifying_screen/store/identifying_store.dart';

class IdentifyingScreen extends StatefulWidget {
  static const String routeName = '/identifying';
  const IdentifyingScreen({super.key, this.image});

  final XFile? image;

  @override
  State<IdentifyingScreen> createState() => _IdentifyingScreenState();
}

class _IdentifyingScreenState extends State<IdentifyingScreen>
    with SingleTickerProviderStateMixin {
  final IdentifyingStore _identifyingStore = IdentifyingStore();
  late AnimationController _animationController;
  late Animation<Offset> _scanLineAnimation;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _scanLineAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: const Offset(0.0, 1.0),
    ).animate(_animationController);
    _animationController.repeat(reverse: true);
    if (widget.image != null) {
      await _identifyingStore.identifyImage(widget.image!);
      _animationController.stop();
      if (_identifyingStore.response != null) {
        showTextBottomSheet();
      }
    }
  }

  Future<void> showTextBottomSheet() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.7,
          maxChildSize: 1,
          expand: false,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Markdown(
                data: '${_identifyingStore.response?.text}',
                controller: scrollController,
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _identifyingStore.identifyImage(widget.image!);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: widget.image == null
          ? const Text('No image selected.')
          : Stack(
              children: [
                AspectRatio(
                  aspectRatio: MediaQuery.of(context).size.aspectRatio,
                  child: Image.file(
                    File(widget.image!.path),
                    fit: BoxFit.cover,
                  ),
                ),
                AspectRatio(
                  aspectRatio: MediaQuery.of(context).size.aspectRatio,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      color: Colors.green.withOpacity(0.1),
                    ),
                  ),
                ),
                AspectRatio(
                  aspectRatio: MediaQuery.of(context).size.aspectRatio,
                  child: Image.file(
                    File(widget.image!.path),
                  ),
                ),
                AspectRatio(
                  aspectRatio: MediaQuery.of(context).size.aspectRatio,
                  child: Observer(
                    builder: (context) {
                      if (_identifyingStore.response != null) {
                        return const SizedBox.shrink();
                      }
                      return AnimatedBuilder(
                        animation: _scanLineAnimation,
                        builder: (context, child) {
                          return ColoredBox(
                            color: Colors.green.withOpacity(0.2),
                            child: CustomPaint(
                              painter: ScanLinePainter(
                                offset: _scanLineAnimation.value,
                                lineWidth: 4,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
    );
  }
}

class ScanLinePainter extends CustomPainter {
  final Offset offset;
  final double lineWidth;

  const ScanLinePainter({required this.offset, required this.lineWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..moveTo(0.0, size.height * offset.dy)
      ..lineTo(size.width, size.height * offset.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ScanLinePainter oldDelegate) =>
      oldDelegate.offset != offset;
}
