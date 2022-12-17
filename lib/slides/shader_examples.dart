import 'package:flutter/material.dart';
import 'package:ppp/fractal/sierpinski_carpet/sierpinski_carpet.dart';
import 'package:ppp/shader_widgets/mandelbrot_set_shader.dart';
import 'package:ppp/shader_widgets/water_shader.dart';
import 'package:umbra_flutter/umbra_flutter.dart';

class ShaderExamples extends StatelessWidget {
  const ShaderExamples({super.key, required this.state});

  final int state;
  static final List<Widget> states = [
    const SierpinksiCarpet(),
    const MandelbrotSet(),
    const Water(),
  ];

  @override
  Widget build(BuildContext context) => states[state];
}

class MandelbrotSet extends StatelessWidget {
  const MandelbrotSet({super.key});

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      maxScale: 1e3,
      child: const Center(
        child: MandelbrotSetShader(),
      ),
    );
  }
}

class Water extends StatefulWidget {
  const Water({Key? key}) : super(key: key);

  @override
  State<Water> createState() => _WaterState();
}

class _WaterState extends State<Water> with SingleTickerProviderStateMixin {
  Offset position = Offset.zero;
  double time = 0;
  late AnimationController controller;
  double dimension = 4.0;

  @override
  void initState() {
    super.initState();
    const Duration waterDuration = Duration(minutes: 10);
    controller = AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: waterDuration.inSeconds.toDouble(),
      duration: waterDuration,
    );
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double shaderHeight = 700,
        shaderWidth = MediaQuery.of(context).size.aspectRatio * shaderHeight;

    return Scaffold(
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                dimension++;
              });
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                dimension--;
              });
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) => MouseRegion(
          onHover: (event) {
            setState(() {
              position = event.position;
            });
          },
          child: Transform.scale(
            scale: width / shaderWidth * 1.5,
            child: SizedBox(
              height: shaderHeight,
              width: shaderWidth,
              child: WaterShader(
                speed: 0.8,
                freq: dimension / 10,
                choppy: dimension / 2,
                height: 0.6,
                iTime: controller.value,
                iMouse: Vector2(position.dx, position.dy),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
