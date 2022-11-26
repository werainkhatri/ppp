import 'package:flutter/material.dart';
import 'package:ppp/utils/colors.dart';

class LinkText extends StatefulWidget {
  const LinkText({Key? key, required this.text, required this.url}) : super(key: key);

  final String text;
  final String url;

  @override
  State<LinkText> createState() => _LinkTextState();
}

class _LinkTextState extends State<LinkText> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        setState(() {
          isHovering = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovering = false;
        });
      },
      child: GestureDetector(
        child: Text(
          widget.text,
          style: TextStyle(
            color: isHovering ? C.flutterBlue : Colors.lightBlue,
            inherit: true,
          ),
        ),
      ),
    );
  }
}
