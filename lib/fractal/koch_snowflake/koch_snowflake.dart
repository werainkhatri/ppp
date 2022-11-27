import 'package:flutter/material.dart';
import 'package:ppp/fractal/koch_snowflake/painter.dart';

/// Base class for animating a fractal.
class KochSnowflake extends StatelessWidget {
  const KochSnowflake({super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Center(
        child: InteractiveViewer(
          maxScale: 50,
          child: AspectRatio(
            aspectRatio: 0.866,
            child: CustomPaint(
              painter: KochSnowflakePainter(
                iterations: 5,
                curveColor: Theme.of(context).colorScheme.primary,
                width: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
