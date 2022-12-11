import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ppp/utils/extensions.dart';
import 'package:ppp/utils/strings.dart';
import 'package:umbra_flutter/umbra_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'line.dart';

class F {
  static Widget getSlideFromName(String? name, List<Widget> slides) {
    return slides.tryGet(int.tryParse(name ?? '') ?? -1) ?? const SizedBox();
  }

  static void openPPPRepo() {
    openUrl(S.githubPPPUrl);
  }

  static void openUrl(String url) {
    if (kIsWeb) {
      // TODO: handle kIsWeb
    } else {
      launchUrlString(url);
    }
  }

  static TextStyle getDTS(BuildContext context) {
    return DefaultTextStyle.of(context).style;
  }

  static void drawSierpinskiCarpetMatrix(Canvas canvas, Size size, Offset dxy, double width) {
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

  static Rect getTopLeftRect(Rect rect) {
    return Rect.fromLTRB(
      rect.left,
      rect.top,
      rect.left + rect.width / 3,
      rect.top + rect.height / 3,
    );
  }

  static Rect getTopMiddleRect(Rect rect) {
    return Rect.fromLTRB(
      rect.left + rect.width / 3,
      rect.top,
      rect.left + (rect.width / 3) * 2,
      rect.top + rect.height / 3,
    );
  }

  static Rect getTopRightRect(Rect rect) {
    return Rect.fromLTRB(
      rect.left + (rect.width / 3) * 2,
      rect.top,
      rect.right,
      rect.top + rect.height / 3,
    );
  }

  static Rect getMiddleLeftRect(Rect rect) {
    return Rect.fromLTRB(
      rect.left,
      rect.top + rect.height / 3,
      rect.left + rect.width / 3,
      rect.top + (rect.height / 3) * 2,
    );
  }

  static Rect getMiddleRightRect(Rect rect) {
    return Rect.fromLTRB(
      rect.left + (rect.width / 3) * 2,
      rect.top + rect.height / 3,
      rect.right,
      rect.top + (rect.height / 3) * 2,
    );
  }

  static Rect getBottomLeftRect(Rect rect) {
    return Rect.fromLTRB(
      rect.left,
      rect.top + (rect.height / 3) * 2,
      rect.left + rect.width / 3,
      rect.bottom,
    );
  }

  static Rect getBottomMiddleRect(Rect rect) {
    return Rect.fromLTRB(
      rect.left + rect.width / 3,
      rect.top + (rect.height / 3) * 2,
      rect.left + (rect.width / 3) * 2,
      rect.bottom,
    );
  }

  static Rect getBottomRightRect(Rect rect) {
    return Rect.fromLTRB(
      rect.left + (rect.width / 3) * 2,
      rect.top + (rect.height / 3) * 2,
      rect.right,
      rect.bottom,
    );
  }

  static Vector4 colorToVector4(Color color) => Vector4(
        color.red / 255,
        color.green / 255,
        color.blue / 255,
        color.alpha / 255,
      );

  /// Returns the point at a perpendicular distance of [distance] from the midpoint
  /// of [line].
  ///
  /// ```
  ///            p3
  ///            |
  ///            |
  /// p1 ----------------- p2
  ///            |
  ///            |
  ///            p4
  /// ```
  ///
  /// Given Line(p1, p2):
  /// * if [below] is true, p4 will be returned,
  /// * else p3 will be returned.
  ///
  /// [distance] should be more than zero.
  static Offset getPerpBisectingPoint(Line line, double distance, bool below) {
    assert(distance > 0);
    if (line.slope.abs() < 1e-5) {
      return line.midpoint + Offset(0, distance * line.delX.sign * (below ? -1 : 1));
    }
    Offset midpoint = line.midpoint;
    double slope = -1 / line.slope;
    double dx = distance / sqrt(1 + slope * slope);
    double dy = distance * slope / sqrt(1 + slope * slope);
    for (int xs = -1; xs <= 1; xs += 2) {
      for (int ys = -1; ys <= 1; ys += 2) {
        Offset potentialPoint = midpoint.translate(xs * dx, ys * dy);
        if (line.isPerpTo(Line(potentialPoint, midpoint)) &&
            !line.valueOf(potentialPoint).isNegative == below) {
          return potentialPoint;
        }
      }
    }
    // Will never reach here.
    throw UnimplementedError(
      'Line: $line\ndistance: $distance\nbelow: $below\nslope: $slope\ndx: $dx; dy: $dy',
    );
  }
}
