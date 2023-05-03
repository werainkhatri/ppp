import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ppp/slides/shaders_hello_world.dart';
import 'package:ppp/utils/functions.dart';
import 'package:ppp/widgets/image_source.dart';

class ShadersSlide extends StatelessWidget {
  const ShadersSlide({super.key, this.state = 0});

  final int state;

  static int get totalStates => states.length;
  static final states = [
    _someShadyStuff,
    _shaders,
    _gutenbergPress,
    _cpuVsGpuGoogle,
    _cpuVsGpuTBOS,
    _shadersExample,
  ].asMap();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double minDim = min(constraints.maxWidth, constraints.maxHeight);

        return states[state]!(constraints.maxWidth, minDim, context);
      },
    );
  }

  static Widget _someShadyStuff(double w, double minDim, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          'assets/wanna buy some widgets.jpg',
          scale: 0.1,
          width: minDim / 1.2,
        ),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(text: 'Some '),
              WidgetSpan(
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        for (int i in [0, 1, 2, 3, 2, 1, 0, 1, 2, 3, 2, 1, 0])
                          [
                            Colors.grey.shade500,
                            Colors.grey.shade600,
                            Colors.grey.shade700,
                            Colors.grey.shade800,
                          ][i],
                      ],
                    ).createShader(rect);
                  },
                  child: Text(
                    'Shady',
                    style: TextStyle(fontSize: w / 10),
                  ),
                ),
              ),
              const TextSpan(text: ' Stuff'),
            ],
            style: TextStyle(fontSize: w / 10),
          ),
        ),
      ],
    );
  }

  static Widget _shaders(double w, double minDim, BuildContext context) {
    return Center(
      child: Hero(
        tag: 'shaders_slide',
        child: Text('Shaders ', style: F.getDTS(context).copyWith(fontSize: w / 10)),
      ),
    );
  }

  static Widget _gutenbergPress(double w, double minDim, BuildContext context) {
    final double hPadding = w / 9;

    return Stack(
      children: [
        Positioned(
          top: minDim / 15,
          left: hPadding,
          right: hPadding,
          child: ImageSource(
            text: 'source: the book of shaders',
            url: 'https://thebookofshaders.com/01/',
            child: Image.asset('assets/gutenberg press.png', scale: 0.2),
          ),
        ),
        Positioned(
          right: minDim / 15,
          bottom: minDim / 15,
          child: _shaders(w / 3, minDim, context),
        ),
      ],
    );
  }

  static Widget _cpuVsGpuTBOS(double w, double minDim, BuildContext context) {
    final double padding = minDim / 15;

    return Stack(
      children: [
        Positioned(
          top: padding * 2,
          left: padding,
          right: padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ImageSource(
                text: 'source: the book of shaders',
                url: 'https://thebookofshaders.com/01/',
                child: Image.asset('assets/cpu.jpeg', width: w / 2 - padding * 1.5),
              ),
              ImageSource(
                text: 'source: the book of shaders',
                url: 'https://thebookofshaders.com/01/',
                child: Image.asset('assets/gpu.jpeg', width: w / 2 - padding * 1.5),
              ),
            ],
          ),
        ),
        Positioned(
          right: minDim / 15,
          bottom: minDim / 15,
          child: _shaders(w / 3, minDim, context),
        ),
      ],
    );
  }

  static Widget _cpuVsGpuGoogle(double w, double minDim, BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: minDim / 15,
          left: w / 8,
          right: w / 8,
          child: ImageSource(
            text: 'source: google',
            url: 'https://images.app.goo.gl/y5C1ApCU6edzsSfL7',
            child: Image.asset('assets/cpu-vs-gpu.webp', scale: 0.2, width: w / 1.25),
          ),
        ),
        Positioned(
          right: minDim / 15,
          bottom: minDim / 15,
          child: _shaders(w / 3, minDim, context),
        ),
      ],
    );
  }

  static Widget _shadersExample(double w, double minDim, BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(minDim / 15),
          child: const HelloWorld(),
        ),
        Positioned(
          right: minDim / 15,
          bottom: minDim / 15,
          child: _shaders(w / 3, minDim, context),
        ),
      ],
    );
  }
}
