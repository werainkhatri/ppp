import 'package:flutter/material.dart';

class FancyElevatedButton extends StatelessWidget {
  const FancyElevatedButton({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        visualDensity: VisualDensity.standard,
        shape: BeveledRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.inverseSurface,
            width: size / 200,
            strokeAlign: StrokeAlign.center,
          ),
          borderRadius: BorderRadius.circular(size / 30),
        ),
        shadowColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 20,
      ),
      child: Padding(
        padding: EdgeInsets.all(size / 50),
        child: Text(
          'ElevatedButton',
          style: TextStyle(fontSize: size / 20),
        ),
      ),
    );
  }
}
