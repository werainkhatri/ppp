import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class HelloWorld extends StatelessWidget {
  const HelloWorld({super.key});

  @override
  Widget build(BuildContext context) => const StaticHelloWorld();
}

class StaticHelloWorld extends StatelessWidget {
  const StaticHelloWorld({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1,
        child: ShaderBuilder(
          assetKey: 'shaders/hello_world.frag',
          (context, shader, child) => CustomPaint(painter: ShaderPainter(shader: shader)),
        ),
      ),
    );
  }
}

class DynamicHelloWorld extends StatefulWidget {
  const DynamicHelloWorld({super.key});

  @override
  State<DynamicHelloWorld> createState() => _DynamicHelloWorldState();
}

class _DynamicHelloWorldState extends State<DynamicHelloWorld> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  double mouseX = 0, mouseY = 0;

  @override
  void initState() {
    super.initState();
    const duration = Duration(minutes: 10);
    controller = AnimationController(
      vsync: this,
      upperBound: duration.inSeconds.toDouble() * 10,
      duration: duration,
    );
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return MouseRegion(
              onHover: (event) {
                setState(() {
                  mouseX = event.localPosition.dx / 100;
                  mouseY = event.localPosition.dy / 100;
                });
              },
              child: ShaderBuilder(
                assetKey: 'shaders/hello_world.frag',
                (context, shader, child) {
                  final uniforms = [controller.value, mouseX, mouseY];
                  return CustomPaint(
                    painter: ShaderPainter(shader: shader, uniforms: uniforms),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class ShaderPainter extends CustomPainter {
  ShaderPainter({required this.shader, this.uniforms = const []});

  final FragmentShader shader;
  final List<double> uniforms;

  @override
  void paint(Canvas canvas, Size size) {
    final floats = [size.width, size.height, ...uniforms];
    for (int i = 0; i < floats.length; i++) {
      shader.setFloat(i, floats[i]);
    }
    canvas.drawRect(Offset.zero & size, Paint()..shader = shader);
  }

  @override
  bool shouldRepaint(ShaderPainter oldDelegate) => true;
}
