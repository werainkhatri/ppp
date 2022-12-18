import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ppp/utils/functions.dart';

class RiveSlide extends StatelessWidget {
  const RiveSlide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      final double minDim = min(constraints.maxWidth, constraints.maxHeight);
      final double padding = minDim / 15, size = minDim / 2.3;

      return Stack(
        children: [
          Positioned(
            top: padding,
            right: padding,
            child: TextButton(
              onPressed: () {
                F.openUrl('https://www.youtube.com/watch?v=6QZy5sYozVI');
              },
              child: Image.asset('assets/flutter_rive.jpg', height: size),
            ),
          ),
          Positioned(
            top: padding,
            left: padding,
            child: TextButton(
              onPressed: () {
                F.openUrl('https://www.youtube.com/watch?v=Td3xEWwRAQA');
              },
              child: Image.asset('assets/flutterway_rive.jpg', height: size),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: minDim / 7),
              child: Text(
                'Rive',
                style: TextStyle(fontSize: constraints.maxWidth / 10),
              ),
            ),
          ),
        ],
      );
    });
  }
}
