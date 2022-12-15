import 'package:flutter/material.dart';
import 'package:ppp/widgets/link_text.dart';

class ImageSource extends StatelessWidget {
  const ImageSource({super.key, required this.child, required this.text, required this.url});

  final Widget child;
  final String text, url;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        child,
        LinkText(
          text: text,
          url: url,
        ),
      ],
    );
  }
}
