import 'package:flutter/material.dart';

class LottieSlide extends StatelessWidget {
  const LottieSlide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Text(
            'Lottie',
            style: TextStyle(fontSize: constraints.maxWidth / 10),
          ),
        );
      },
    );
  }
}
