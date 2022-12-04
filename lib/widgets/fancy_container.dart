import 'package:flutter/material.dart';

class FancyContainer extends StatelessWidget {
  const FancyContainer({Key? key, required this.size}) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.inverseSurface,
          width: size / 75,
          strokeAlign: StrokeAlign.center,
        ),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.inversePrimary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            offset: Offset(size / 30, size / 30),
            color: Theme.of(context).colorScheme.secondary,
            blurRadius: 10,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: SizedBox.square(
        dimension: size / 3.5,
        child: Center(
          child: Text(
            'Container',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontSize: size / 25,
            ),
          ),
        ),
      ),
    );
  }
}
