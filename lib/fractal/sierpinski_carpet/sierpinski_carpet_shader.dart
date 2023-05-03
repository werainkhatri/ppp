import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';
import 'package:ppp/utils/functions.dart';

class SierpinskiCarpetShader extends StatefulWidget {
  final bool showZoomLabel;
  const SierpinskiCarpetShader({super.key, this.showZoomLabel = false});

  @override
  State<SierpinskiCarpetShader> createState() => _SierpinskiCarpetShaderState();
}

class _SierpinskiCarpetShaderState extends State<SierpinskiCarpetShader> {
  final TransformationController _controller = TransformationController();
  int maxByZoom = 0;

  int _iterationsFromZoom(double zoom) {
    // increase one for every 3x zoom
    final double logZoom = log(zoom) / log(3);
    return logZoom.floor();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        InteractiveViewer(
          maxScale: 2e4,
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
          child: ShaderBuilder(
            assetKey: 'shaders/sierpinski_carpet.frag',
            (context, shader, child) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final double maxSize = min(constraints.maxHeight, constraints.maxWidth);
                  // start with 2 and for every 400 pixels increase by 1
                  final double maxBySize = 2.0 + (maxSize / 400).floor();

                  return Center(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CustomPaint(
                        painter: _SierpinskiCarpetShaderPainter(
                          shader: shader,
                          carpetColor: colorScheme.primary,
                          backgroundColor: colorScheme.background,
                          iterations: maxBySize + maxByZoom,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        if (widget.showZoomLabel)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Zoom: ${_controller.value.row0[0].toInt()}',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          ),
      ],
    );
  }
}

class _SierpinskiCarpetShaderPainter extends CustomPainter {
  final FragmentShader shader;
  final Color carpetColor, backgroundColor;
  final double iterations;

  const _SierpinskiCarpetShaderPainter({
    required this.shader,
    required this.carpetColor,
    required this.backgroundColor,
    required this.iterations,
  });

  @override
  void paint(Canvas canvas, Size size) {
    updateShader(size);

    canvas.drawRect(
      Rect.fromLTRB(0, 0, size.width, size.height),
      Paint()..shader = shader,
    );
  }

  void updateShader(Size size) {
    assert(size.width == size.height);

    final floats = [
      size.width,
      size.height,
      iterations,
      ...F.getFloatColor(carpetColor),
      ...F.getFloatColor(backgroundColor),
    ];

    for (int i = 0; i < floats.length; i++) {
      shader.setFloat(i, floats[i]);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
