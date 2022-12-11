import 'dart:collection';

import 'package:flutter/material.dart';

class SierpinskiCarpetCustomPaint extends StatelessWidget {
  const SierpinskiCarpetCustomPaint({super.key, required this.generation});

  /// generation of the sierpinski carpet, starting from 1.
  final int generation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1,
        child: CustomPaint(
          painter: SierpinskiCarpetPainter(
            carpetColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.background,
            generation: generation,
          ),
        ),
      ),
    );
  }
}

/// [CustomPainter] that handles painting the sierpinski carpet.
class SierpinskiCarpetPainter extends CustomPainter {
  /// Make sure the [CustomPaint] using this is wrapped with [AspectRatio]
  /// with aspectRatio set to `FractalConfig.aspectRatio`.
  SierpinskiCarpetPainter({
    required this.carpetColor,
    required this.backgroundColor,
    required this.generation,
  });
  final Color carpetColor;
  final Color backgroundColor;
  final int generation;

  final Paint carpetPaint = Paint()..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    final Queue<Rect> currentRects = Queue()
      ..add(Rect.fromPoints(Offset.zero, Offset(size.width, size.height)));

    /// draws the first generation carpet.
    carpetPaint.color = carpetColor;
    canvas.drawRect(Rect.fromPoints(Offset.zero, Offset(size.width, size.height)), carpetPaint);

    carpetPaint.color = backgroundColor;

    // simple breadth first search.
    for (int i = 2; i <= generation; i++) {
      int rectCount = currentRects.length;

      if (i.isEven) {
        for (Rect rect in currentRects) {
          drawMatrix(canvas, rect.size, rect.topLeft, generation / i);
        }
        continue;
      }

      while (rectCount-- > 0) {
        final Rect currentRect = currentRects.removeFirst();

        // since width and height are the same, we can use either.
        // get the middle rect.
        final Rect rectToRemove = currentRect.deflate(currentRect.width / 3);

        // remove the middle rect.
        canvas.drawRect(rectToRemove, carpetPaint);

        // skip preprocessing the next generation for the last generation.
        if (i == generation) continue;

        // do the same for the other 8 rects.
        currentRects.add(_getTopLeftRect(currentRect));
        currentRects.add(_getTopMiddleRect(currentRect));
        currentRects.add(_getTopRightRect(currentRect));
        currentRects.add(_getMiddleLeftRect(currentRect));
        currentRects.add(_getMiddleRightRect(currentRect));
        currentRects.add(_getBottomLeftRect(currentRect));
        currentRects.add(_getBottomMiddleRect(currentRect));
        currentRects.add(_getBottomRightRect(currentRect));
      }
    }
  }

  void drawMatrix(Canvas canvas, Size size, Offset dxy, double width) {
    final Paint linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = width;
    canvas.drawLine(
      Offset(dxy.dx + size.height / 3, dxy.dy),
      Offset(dxy.dx + size.height / 3, dxy.dy + size.width),
      linePaint,
    );
    canvas.drawLine(
      Offset(dxy.dx + size.height / 3 * 2, dxy.dy),
      Offset(dxy.dx + size.height / 3 * 2, dxy.dy + size.width),
      linePaint,
    );
    canvas.drawLine(
      Offset(dxy.dx + 0, dxy.dy + size.height / 3),
      Offset(dxy.dx + size.width, dxy.dy + size.height / 3),
      linePaint,
    );
    canvas.drawLine(
      Offset(dxy.dx + 0, dxy.dy + size.height / 3 * 2),
      Offset(dxy.dx + size.width, dxy.dy + size.height / 3 * 2),
      linePaint,
    );
  }

  static Rect _getTopLeftRect(Rect rect) {
    return Rect.fromLTRB(
      rect.left,
      rect.top,
      rect.left + rect.width / 3,
      rect.top + rect.height / 3,
    );
  }

  static Rect _getTopMiddleRect(Rect rect) {
    return Rect.fromLTRB(
      rect.left + rect.width / 3,
      rect.top,
      rect.left + (rect.width / 3) * 2,
      rect.top + rect.height / 3,
    );
  }

  static Rect _getTopRightRect(Rect rect) {
    return Rect.fromLTRB(
      rect.left + (rect.width / 3) * 2,
      rect.top,
      rect.right,
      rect.top + rect.height / 3,
    );
  }

  static Rect _getMiddleLeftRect(Rect rect) {
    return Rect.fromLTRB(
      rect.left,
      rect.top + rect.height / 3,
      rect.left + rect.width / 3,
      rect.top + (rect.height / 3) * 2,
    );
  }

  static Rect _getMiddleRightRect(Rect rect) {
    return Rect.fromLTRB(
      rect.left + (rect.width / 3) * 2,
      rect.top + rect.height / 3,
      rect.right,
      rect.top + (rect.height / 3) * 2,
    );
  }

  static Rect _getBottomLeftRect(Rect rect) {
    return Rect.fromLTRB(
      rect.left,
      rect.top + (rect.height / 3) * 2,
      rect.left + rect.width / 3,
      rect.bottom,
    );
  }

  static Rect _getBottomMiddleRect(Rect rect) {
    return Rect.fromLTRB(
      rect.left + rect.width / 3,
      rect.top + (rect.height / 3) * 2,
      rect.left + (rect.width / 3) * 2,
      rect.bottom,
    );
  }

  static Rect _getBottomRightRect(Rect rect) {
    return Rect.fromLTRB(
      rect.left + (rect.width / 3) * 2,
      rect.top + (rect.height / 3) * 2,
      rect.right,
      rect.bottom,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
