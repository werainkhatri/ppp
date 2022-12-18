import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ppp/utils/functions.dart';

class RenderObjectSlide extends StatelessWidget {
  const RenderObjectSlide({super.key, required this.showVideos});

  final bool showVideos;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double minDim = min(constraints.maxWidth, constraints.maxHeight);
        final double padding = minDim / 15, size = minDim / 3.2;

        return Stack(
          children: [
            if (showVideos)
              Positioned(
                top: padding,
                left: padding,
                child: TextButton(
                  onPressed: () {
                    F.openUrl('https://www.youtube.com/watch?v=zmbmrw07qBc');
                  },
                  child: Image.asset('assets/flutter_renderobjects.jpg', height: size),
                ),
              ),
            if (showVideos)
              Positioned(
                top: padding,
                right: padding,
                child: TextButton(
                  onPressed: () {
                    F.openUrl('https://www.youtube.com/watch?v=54yoCqkew6g');
                  },
                  child: Image.asset('assets/flutter_rendering.jpg', height: size),
                ),
              ),
            if (showVideos)
              Positioned(
                bottom: padding,
                height: size,
                left: 0,
                right: 0,
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      F.openUrl('https://www.youtube.com/watch?v=svb41OLzCDY');
                    },
                    child: Image.asset('assets/fluttervikings_renderbox.jpg'),
                  ),
                ),
              ),
            Center(
              child: Hero(
                tag: 'renderbox_slide',
                child: Text(
                  'RenderObject ',
                  style: F.getDTS(context).copyWith(fontSize: constraints.maxWidth / 10),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
