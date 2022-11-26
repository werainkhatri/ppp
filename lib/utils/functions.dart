import 'package:flutter/material.dart';
import 'package:ppp/utils/extensions.dart';

class F {
  static Widget getSlideFromName(String? name, List<Widget> slides) {
    return slides.tryGet(int.tryParse(name ?? '') ?? -1) ?? const SizedBox();
  }
}
