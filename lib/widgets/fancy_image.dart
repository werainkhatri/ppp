import 'package:flutter/material.dart';

class FancyImage extends StatelessWidget {
  const FancyImage({super.key, required this.width, required this.height});

  final double width, height;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://picsum.photos/${width * 3 ~/ 4}/${height * 2.3 ~/ 10}',
      color: Theme.of(context).colorScheme.primary,
      colorBlendMode: BlendMode.overlay,
      filterQuality: FilterQuality.high,
    );
  }
}
