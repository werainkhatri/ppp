import 'package:flutter/material.dart';
import 'package:ppp/fractal/sierpinski_carpet/sierpinski_carpet_shader.dart';
import 'package:ppp/shader_widgets/mandelbrot_set_shader.dart';
import 'package:ppp/shader_widgets/water_shader.dart';

class ShaderExamples extends StatelessWidget {
  const ShaderExamples({super.key, required this.state});

  final int state;
  static final List<Widget> states = [
    const SierpinskiCarpetShader(showZoomLabel: true),
    const MandelbrotSetShader(),
    const WaterShader(),
  ];

  @override
  Widget build(BuildContext context) => states[state];
}
