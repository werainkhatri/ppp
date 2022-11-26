import 'package:flutter/material.dart';
import 'package:ppp/utils/functions.dart';

class Thumbnail extends StatelessWidget {
  const Thumbnail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Painting',
          style: F.getDTS(context).copyWith(fontSize: 100),
          children: const [
            TextSpan(text: ' Pretty ', style: TextStyle(fontFamily: 'Nabla')),
            TextSpan(text: 'Pixels'),
          ],
        ),
      ),
    );
  }
}
