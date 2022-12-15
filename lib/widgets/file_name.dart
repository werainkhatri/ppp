import 'package:flutter/material.dart';

class FileName extends StatelessWidget {
  const FileName({super.key, required this.child, this.name});

  final Widget child;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (name != null)
          Text(
            name!,
            style: const TextStyle(
              fontSize: 15,
              fontStyle: FontStyle.italic,
            ),
          ),
        ColoredBox(
          color: Colors.white24,
          child: child,
        ),
      ],
    );
  }
}
