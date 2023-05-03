import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class MandelbrotSetShader extends StatelessWidget {
  const MandelbrotSetShader({super.key});

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      maxScale: 1e5,
      child: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: ShaderBuilder(
            assetKey: 'shaders/mandelbrot_set.frag',
            (context, shader, child) {
              return CustomPaint(painter: _MandelbrotSetPainter(shader: shader));
            },
          ),
        ),
      ),
    );
  }
}

class _MandelbrotSetPainter extends CustomPainter {
  _MandelbrotSetPainter({required this.shader});

  final FragmentShader shader;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);

    canvas.drawRect(Offset.zero & size, Paint()..shader = shader);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
