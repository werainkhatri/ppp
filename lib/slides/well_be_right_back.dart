import 'package:flutter/material.dart';

class WellBeRightBack extends StatelessWidget {
  const WellBeRightBack({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: width / 15),
          child: Text(
            "We'll\nBe\nRight\nBack",
            style: TextStyle(
              fontSize: width / 12,
              color: Theme.of(context).colorScheme.primary,
              shadows: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  offset: Offset(width / 300, width / 300),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
