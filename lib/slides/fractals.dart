import 'package:flutter/material.dart';
import 'package:ppp/fractal/koch_snowflake/koch_snowflake.dart';
import 'package:ppp/fractal/sierpinski_carpet/sierpinski_carpet_shader.dart';
import 'package:ppp/fractal/sierpinski_carpet/sierpinski_carpet_custom_paint.dart';
import 'package:ppp/utils/functions.dart';
import 'package:ppp/utils/strings.dart';

class Fractals extends StatefulWidget {
  const Fractals({Key? key, required this.state}) : super(key: key);

  static const List<Widget> _states = [
    _Title(showFractals: false), // 0
    _Title(showFractals: true), // 1
    Hero(tag: S.sierpinksiCarpetTag, child: SierpinskiCarpetShader()), // 2
    Hero(tag: S.sierpinksiCarpetTag, child: SierpinskiCarpetCustomPaint(generation: 1)), // 3
    Hero(tag: S.sierpinksiCarpetTag, child: SierpinskiCarpetCustomPaint(generation: 2)), // 4
    Hero(tag: S.sierpinksiCarpetTag, child: SierpinskiCarpetCustomPaint(generation: 3)), // 5
    Hero(tag: S.sierpinksiCarpetTag, child: SierpinskiCarpetCustomPaint(generation: 4)), // 6
    Hero(tag: S.sierpinksiCarpetTag, child: SierpinskiCarpetCustomPaint(generation: 5)), // 7
    Hero(tag: S.sierpinksiCarpetTag, child: SierpinskiCarpetCustomPaint(generation: 6)), // 8
    Hero(tag: S.sierpinksiCarpetTag, child: SierpinskiCarpetCustomPaint(generation: 7)), // 9
    Hero(tag: S.sierpinksiCarpetTag, child: SierpinskiCarpetShader()), // 10
    _Title(showFractals: true), // 11
    Hero(tag: S.kochSnowflakeTag, child: KochSnowflake()), // 12
    _Title(showFractals: true), // 13
  ];

  final int state;
  static int get finalState => states.length;
  static Map<int, Widget> states = _states.asMap();

  @override
  State<Fractals> createState() => _FractalsState();
}

class _FractalsState extends State<Fractals> {
  @override
  Widget build(BuildContext context) => Fractals.states[widget.state]!;
}

class _Title extends StatelessWidget {
  // todo: add a way to view/visit sources via app.
  // 3b1b: https://www.youtube.com/watch?v=gB9n2gHsHN4
  // ted: https://www.youtube.com/watch?v=ay8OMOsf6AQ
  // wikipedia: https://en.wikipedia.org/wiki/Fractal

  const _Title({Key? key, required this.showFractals}) : super(key: key);

  final bool showFractals;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => Stack(
        children: [
          if (showFractals)
            Positioned(
              top: constraints.maxHeight / 6,
              left: constraints.maxWidth / 6,
              child: SizedBox.square(
                dimension: constraints.maxHeight / 2.5,
                child: const Hero(
                  tag: S.sierpinksiCarpetTag,
                  child: SierpinskiCarpetShader(),
                ),
              ),
            ),
          if (showFractals)
            Positioned(
              top: constraints.maxHeight / 6,
              right: constraints.maxWidth / 6,
              child: SizedBox(
                height: constraints.maxHeight / 2.5,
                child: const Hero(
                  tag: S.kochSnowflakeTag,
                  child: KochSnowflake(),
                ),
              ),
            ),
          Align(
            alignment: showFractals ? Alignment.bottomCenter : Alignment.center,
            child: Hero(
              tag: S.fractalsTag,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Text(
                  'Fractals ',
                  style: F.getDTS(context).copyWith(
                        fontFamily: 'Rubik Maze',
                        fontSize: constraints.maxWidth / 7,
                        fontWeight: FontWeight.w100,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
