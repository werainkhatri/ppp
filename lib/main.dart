import 'package:flutter/material.dart';
import 'package:ppp/slide_scaffold/slide_scaffold.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff711234)),
      ),
      home: const SlideScaffold(slides: []),
    );
  }
}
