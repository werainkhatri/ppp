import 'package:flutter/material.dart';
import 'package:ppp/fractal/koch_snowflake/koch_snowflake.dart';
import 'package:ppp/fractal/sierpinski_carpet/sierpinski_carpet.dart';

class Fractals extends StatefulWidget {
  const Fractals({Key? key, required this.state})
      : assert(state <= finalState && state > 0),
        super(key: key);

  final int state;
  static const finalState = 2;

  @override
  State<Fractals> createState() => _FractalsState();
}

class _FractalsState extends State<Fractals> {
  @override
  Widget build(BuildContext context) => <int, Widget>{
        1: const _Title(),
        2: const Hero(tag: 'sierpinski carpet', child: SierpinksiCarpet()),
      }[widget.state]!;
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => Stack(
        children: [
          Positioned(
            top: constraints.maxHeight / 6,
            left: constraints.maxWidth / 6,
            child: SizedBox.square(
              dimension: constraints.maxHeight / 2.5,
              child: const Hero(
                tag: 'sierpinski carpet',
                child: SierpinksiCarpet(),
              ),
            ),
          ),
          Positioned(
            top: constraints.maxHeight / 6,
            right: constraints.maxWidth / 6,
            child: SizedBox(
              height: constraints.maxHeight / 2.5,
              child: const KochSnowflake(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text(
                'Fractals',
                style: TextStyle(
                  fontFamily: 'Rubik Maze',
                  fontSize: constraints.maxWidth / 7,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
