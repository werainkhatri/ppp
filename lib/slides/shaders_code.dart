import 'package:flutter/material.dart';
import 'package:ppp/shader_widgets/hello_world_shader.dart';
import 'package:umbra_flutter/umbra_flutter.dart';

// class HelloWorld extends StatelessWidget {
//   const HelloWorld({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: AspectRatio(
//         aspectRatio: 1,
//         child: HelloWorldShader(),
//       ),
//     );
//   }
// }

class HelloWorld extends StatefulWidget {
  const HelloWorld({super.key});

  @override
  State<HelloWorld> createState() => _HelloWorldState();
}

class _HelloWorldState extends State<HelloWorld> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  Vector2 mouse = Vector2(0, 0);

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
                  mouse.x = event.localPosition.dx / 100;
                  mouse.y = event.localPosition.dy / 100;
                });
              },
              child: HelloWorldShader(
                uTime: controller.value,
                uMouse: mouse,
              ),
            );
          },
        ),
      ),
    );
  }
}
