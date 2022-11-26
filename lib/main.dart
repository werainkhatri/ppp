import 'package:flutter/material.dart';
import 'package:ppp/slide_scaffold/slide_scaffold.dart';
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: C.vir3n),
      ),
      home: const SlideScaffold(slides: [
        AboutMe(),
      ]),
    );
  }
}
