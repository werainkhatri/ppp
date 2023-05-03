import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class WaterShader extends StatefulWidget {
  const WaterShader({Key? key}) : super(key: key);

  @override
  State<WaterShader> createState() => _WaterShaderState();
}

class _WaterShaderState extends State<WaterShader> with SingleTickerProviderStateMixin {
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
  void dispose() {
    controller.dispose();
    super.dispose();
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
            heroTag: '1',
            onPressed: () {
              setState(() {
                dimension++;
              });
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: '2',
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
              child: ShaderBuilder(
                assetKey: 'shaders/water.frag',
                (context, shader, child) {
                  return CustomPaint(
                    painter: WaterPainter(
                      shader: shader,
                      uniforms: [
                        controller.value,
                        position.dx,
                        position.dy,
                        dimension / 2,
                        dimension / 10,
                        0.8,
                        0.6,
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WaterPainter extends CustomPainter {
  WaterPainter({
    required this.shader,
    required this.uniforms,
  });

  final FragmentShader shader;
  final List<double> uniforms;

  @override
  void paint(Canvas canvas, Size size) {
    final floats = [size.width, size.height, ...uniforms];
    for (var i = 0; i < floats.length; i++) {
      shader.setFloat(i, floats[i]);
    }

    canvas.drawRect(Offset.zero & size, Paint()..shader = shader);
  }

  @override
  bool shouldRepaint(WaterPainter oldDelegate) {
    return true;
  }
}
