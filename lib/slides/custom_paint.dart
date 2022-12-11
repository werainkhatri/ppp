import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ppp/utils/functions.dart';

class CustomPaintSlide extends StatelessWidget {
  const CustomPaintSlide({super.key, required this.state});

  /// current state of the slide
  ///
  /// 0 -> only title
  /// 1 -> title with the tools
  /// 2... -> move icon for each tool
  ////
  //// 2 -> move icon
  //// 3 -> expand tool to show code
  //// 4 -> deflate tool
  ////
  //// 5 -> same as 2 for the next tool
  //// ...
  final int state;
  static int get totalStates => states.length + 2;
  static final states = <StateData>[
    StateData(
      Icons.brush_outlined,
      'Paint',
//       code: '''
// final Paint paint = Paint()
//   ..color = Colors.red
//   ..strokeWidth = 5
//   ..style = PaintingStyle.stroke
//   ..strokeCap = StrokeCap.round;
// ''',
      top: (padding) => padding,
      left: (padding) => padding,
    ),
    StateData(
      Icons.straighten_outlined,
      'Path',
      top: (padding) => padding,
    ),
    StateData(
      Icons.image_outlined,
      'Canvas',
      top: (padding) => padding,
      right: (padding) => padding,
    ),
    StateData(
      Icons.person_outline,
      'CustomPainter',
      bottom: (padding) => padding,
      left: (padding) => padding * 2,
      aspectRatio: 2,
    ),
    StateData(
      Icons.push_pin_outlined,
      'CustomPaint',
      bottom: (padding) => padding,
      right: (padding) => padding * 2,
      aspectRatio: 2,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      double minDim = min(constraints.maxHeight, constraints.maxWidth);
      final padding = minDim / 15;

      return Stack(
        alignment: Alignment.center,
        children: [
          for (int i = 0; i < states.length; i++)
            Visibility(
              visible: state > 0,
              child: Positioned(
                left: states[i].left?.call(padding),
                top: states[i].top?.call(padding),
                right: states[i].right?.call(padding),
                bottom: states[i].bottom?.call(padding),
                child: ToolWidget(
                  size: minDim,
                  data: states[i],
                  showChild: state >= i + 2,
                  // expandChild: ,
                ),
              ),
            ),
          Hero(
            tag: 'custom paint',
            child: Center(
              child: Text(
                'CustomPaint',
                style: F.getDTS(context).copyWith(fontSize: constraints.maxWidth / 15),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class StateData {
  const StateData(
    this.icon,
    this.text, {
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.aspectRatio = 1.0,
    // this.code,
  });

  final String text;
  final IconData icon;
  final double Function(double)? left, top, right, bottom;
  final double aspectRatio;
  // final String? code;
}

class ToolWidget extends StatelessWidget {
  const ToolWidget({
    super.key,
    required this.data,
    required this.size,
    required this.showChild,
    // this.expandChild = false,
  });

  final StateData data;
  final double size;
  final bool showChild;
  // final bool expandChild;

  double get _maxHeight => size / 3.3;
  double get _minSize => size / 15;

  @override
  Widget build(BuildContext context) {
    Widget buildBorderedChild(Widget child, String tag, {double? width, required double height}) {
      return Hero(
        tag: tag,
        child: SizedBox(
          width: width ?? height * data.aspectRatio,
          height: height,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              border: Border.all(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            child: child,
          ),
        ),
      );
    }

    Widget iconChild = Icon(data.icon, size: showChild ? size / 20 : size / 10);
    Widget codeChild = Text(data.text, style: GoogleFonts.firaCode(fontSize: _minSize));

    Widget result = Stack(
      children: [
        buildBorderedChild(
          codeChild,
          data.text,
          height: _maxHeight,
        ),
        Positioned(
          left: 0,
          top: 0,
          child: buildBorderedChild(
            iconChild,
            data.icon.codePoint.toString(),
            height: showChild ? _minSize : _maxHeight,
            width: showChild ? _minSize : null,
          ),
        ),
      ],
    );

    return result;
  }
}
