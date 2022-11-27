import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ppp/utils/functions.dart';

import '../../utils/line.dart';

/// [CustomPainter] that handles painting the koch snowflake.
class KochSnowflakePainter extends CustomPainter {
  /// Make sure the [CustomPaint] using this is wrapped with [AspectRatio]
  /// with aspectRatio set to `FractalConfig.aspectRatio`.
  KochSnowflakePainter({
    required this.curveColor,
    required this.iterations,
    this.width = 0.3,
  });

  final Color curveColor;
  final int iterations;
  final double width;

  final Paint painter = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    painter
      ..strokeWidth = width
      ..color = curveColor;

    double side = size.width, smallHeight = side / (2 * sqrt(3));

    //       /\
    // left /  \ right
    //     /    \
    //    /      \
    //   ---------
    //     bottom
    Line left = Line(Offset(0, size.height - smallHeight), Offset(side / 2, 0)),
        right = Line(left.p2, Offset(side, size.height - smallHeight)),
        bottom = Line(right.p2, left.p1);

    paintKochCurve(
      canvas: canvas,
      painter: painter,
      initialLine: left,
      generation: iterations,
    );
    paintKochCurve(
      canvas: canvas,
      painter: painter,
      initialLine: right,
      generation: iterations,
    );
    paintKochCurve(
      canvas: canvas,
      painter: painter,
      initialLine: bottom,
      generation: iterations,
    );
  }

  static void paintKochCurve({
    required Canvas canvas,
    required Paint painter,
    required Line initialLine,
    required int generation,
  }) {
    final Queue<Line> lines = Queue();
    lines.add(initialLine);

    for (int i = 2; i <= generation; i++) {
      int len = lines.length;
      while (len-- > 0) {
        Line line = lines.removeFirst();

        Line l1 = line.copyWith(p2: line.onethird);
        lines.add(l1);

        Line l2 = line.copyWith(p1: line.onethird, p2: line.twothird);
        // here, below is set to true because origin is on the top right.
        Offset p3 = F.getPerpBisectingPoint(l2, l2.length * sqrt(3) / 2, true);
        lines.add(l2.copyWith(p2: p3));
        lines.add(l2.copyWith(p1: p3));

        Line l3 = line.copyWith(p1: line.twothird);
        lines.add(l3);
      }
    }

    for (Line line in lines) {
      canvas.drawLine(line.p1, line.p2, painter);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
