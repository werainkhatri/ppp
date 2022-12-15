import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:ppp/slide_scaffold.dart';
import 'package:ppp/slides/slides.dart';
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
          for (int i in List.generate(Fractals.finalState, (i) => i)) Fractals(state: i),
          const Widgets(),
          for (int i in List.generate(CustomPaintSlide.totalStates, (i) => i))
            CustomPaintSlide(state: i),
          const CustomPaintCode(),
          for (final bool show in [false, true]) RenderObjectSlide(showVideos: show),
          for (final int i in List.generate(ShadersSlide.totalStates, (i) => i))
            ShadersSlide(state: i),
          const AboutMe(),
        ],
      ),
    );
  }
}
