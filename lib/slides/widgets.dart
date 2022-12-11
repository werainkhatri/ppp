import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ppp/widgets/fancy_container.dart';
import 'package:ppp/widgets/fancy_elevated_button.dart';
import 'package:ppp/widgets/fancy_image.dart';

class Widgets extends StatelessWidget {
  const Widgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      double minDim = min(constraints.maxHeight, constraints.maxWidth);

      return Stack(
        children: [
          Positioned(
            top: minDim / 15,
            left: minDim / 15,
            child: FancyContainer(size: minDim),
          ),
          Positioned(
            top: minDim / 5,
            right: minDim / 5,
            child: FancyElevatedButton(size: minDim),
          ),
          Positioned(
            bottom: minDim / 10,
            left: constraints.maxWidth / 8,
            child: FancyImage(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
            ),
          ),
          Center(
            child: Text(
              'Widgets',
              style: TextStyle(fontSize: constraints.maxWidth / 10),
            ),
          ),
        ],
      );
    });
  }
}
