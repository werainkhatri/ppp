// import 'dart:js' as js;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ppp/utils/extensions.dart';
import 'package:ppp/utils/strings.dart';
import 'package:url_launcher/url_launcher_string.dart';

class F {
  static Widget getSlideFromName(String? name, List<Widget> slides) {
    return slides.tryGet(int.tryParse(name ?? '') ?? -1) ?? const SizedBox();
  }

  static void launchGithubProfile() {
    if (kIsWeb) {
      // js.context.callMethod('open', [S.githubProfile]);
    } else {
      launchUrlString(S.githubUrl);
    }
  }

  static TextStyle getDTS(BuildContext context) {
    return DefaultTextStyle.of(context).style;
  }
}
