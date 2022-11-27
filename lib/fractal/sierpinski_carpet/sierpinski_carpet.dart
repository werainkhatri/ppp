import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ppp/fractal/sierpinski_carpet/sierpinski_carpet_shader.dart';
import 'package:ppp/utils/functions.dart';

class SierpinksiCarpet extends StatefulWidget {
  const SierpinksiCarpet({Key? key}) : super(key: key);

  @override
  State<SierpinksiCarpet> createState() => _SierpinksiCarpetState();
}

class _SierpinksiCarpetState extends State<SierpinksiCarpet> {
  final TransformationController _controller = TransformationController();
  int maxByZoom = 0;

  int _iterationsFromZoom(double zoom) {
    // increase one for every 3x zoom
    final double logZoom = log(zoom) / log(3);
    return logZoom.floor();
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      transformationController: _controller,
      onInteractionUpdate: (_) {
        final int newDueToZoom = _iterationsFromZoom(_controller.value.row0[0]);
        // only update if the zoom level has changed
        if (newDueToZoom != maxByZoom) {
          setState(() {
            maxByZoom = newDueToZoom;
          });
        }
      },
      maxScale: 1000,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double maxSize = min(constraints.maxHeight, constraints.maxWidth);
          // start with 1 and for every 500 pixels increase by 1
          final double maxBySize = 2.0 + (maxSize / 400).floor();

          return Center(
            child: AspectRatio(
              aspectRatio: 1,
              child: SierpinskiCarpetShader(
                iterations: maxBySize + maxByZoom,
                carpetColor: F.colorToVector4(Theme.of(context).colorScheme.primary),
                backgroundColor: F.colorToVector4(Theme.of(context).colorScheme.primaryContainer),
              ),
            ),
          );
        },
      ),
    );
  }
}
