import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:ppp/slide_scaffold.dart';
import 'package:ppp/slides/about_me.dart';
import 'package:ppp/slides/fractals.dart';
import 'package:ppp/slides/thumbnail.dart';
import 'package:ppp/slides/widgets.dart';
import 'package:ppp/utils/colors.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: FlexThemeData.dark(
        colorScheme: ColorScheme.fromSeed(seedColor: C.viren),
        applyElevationOverlayColor: true,
      ),
      home: SlideScaffold(
        slides: [
          const Thumbnail(),
          for (int i in [0, 1, 2]) Fractals(state: i),
          const Widgets(),
          const AboutMe(),
        ],
      ),
    );
  }
}
