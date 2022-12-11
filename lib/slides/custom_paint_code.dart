import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:ppp/utils/functions.dart';

class CustomPaintCode extends StatelessWidget {
  const CustomPaintCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1,
        child: CustomPaint(
          painter: SierpinskiCarpetPainter(
            carpetColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.background,
            generation: 1,
          ),
        ),
      ),
    );
  }
}

/// [CustomPainter] that handles painting the sierpinski carpet.
class SierpinskiCarpetPainter extends CustomPainter {
  SierpinskiCarpetPainter({
    required this.carpetColor,
    required this.backgroundColor,
    required this.generation,
  });

  final Color carpetColor;
  final Color backgroundColor;
  final int generation;

  late final Paint carpetBrush = Paint()
    ..style = PaintingStyle.fill
    ..color = carpetColor;
  late final Paint backgroundBrush = Paint()
    ..style = PaintingStyle.fill
    ..color = backgroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Queue<Rect> currentRects = Queue()
      ..add(Rect.fromPoints(Offset.zero, Offset(size.width, size.height)));

    /// draws the first generation carpet.
    canvas.drawRect(currentRects.first, carpetBrush);

    // simple breadth first search.
    for (int i = 2; i <= generation; i++) {
      int rectCount = currentRects.length;

      while (rectCount-- > 0) {
        final Rect currentRect = currentRects.removeFirst();

        // since width and height are the same, we can use either.
        // get the middle rect.
        final Rect rectToRemove = currentRect.deflate(currentRect.width / 3);

        // remove the middle rect.
        canvas.drawRect(rectToRemove, backgroundBrush);

        // skip preprocessing the next generation for the last generation.
        if (i == generation) continue;

        // do the same for the other 8 rects.
        currentRects.add(F.getTopLeftRect(currentRect));
        currentRects.add(F.getTopMiddleRect(currentRect));
        currentRects.add(F.getTopRightRect(currentRect));
        currentRects.add(F.getMiddleLeftRect(currentRect));
        currentRects.add(F.getMiddleRightRect(currentRect));
        currentRects.add(F.getBottomLeftRect(currentRect));
        currentRects.add(F.getBottomMiddleRect(currentRect));
        currentRects.add(F.getBottomRightRect(currentRect));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
