import 'package:flutter/material.dart';
import 'package:ppp/utils/colors.dart';
import 'package:ppp/utils/functions.dart';
import 'package:ppp/utils/strings.dart';
import 'package:ppp/widgets/link_text.dart';
import 'package:ppp/widgets/null_safety_chip.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: ListView(
        physics: const RangeMaintainingScrollPhysics(),
        children: [
          Row(
            children: const [
              Text('Viren Khatri', style: TextStyle(fontSize: 50)),
              SizedBox(width: 10),
              NullSafety(),
              Spacer(),
              IconButton(
                onPressed: F.openPPPRepo,
                icon: Icon(Icons.description, color: C.flutterBlue, size: 30),
              )
            ],
          ),
          const SizedBox(height: 20),
          const Text(S.oneLineAboutMe, style: TextStyle(fontSize: 20)),
          const SizedBox(height: 50),
          LayoutBuilder(builder: (_, constraints) {
            final List<Widget> children = [
              const _YouCanFindMe(),
              const SizedBox.square(dimension: 50),
              Flexible(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Image.asset('assets/google-search.png', height: 500),
                  ),
                ),
              ),
            ];
            if (constraints.maxWidth < 1000) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: children,
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: children,
            );
          }),
        ],
      ),
    );
  }
}

class _YouCanFindMe extends StatelessWidget {
  const _YouCanFindMe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: F.getDTS(context).copyWith(fontSize: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('You can find me', style: TextStyle(fontSize: 30)),
          SizedBox(height: 15),
          LinkText(text: 'on YouTube', url: S.youtubeUrl),
          Text('livestreaming my flutter contributions ⏯.'),
          SizedBox(height: 15),
          LinkText(text: 'on GitHub', url: S.githubUrl),
          Text('contributing to the flutter org and building personal projects 🧑🏻‍💻.'),
          SizedBox(height: 15),
          LinkText(text: 'on Twitter', url: S.twitterUrl),
          Text('tweeting about software and stuff and engaging with the flutter '
              'community 💙.'),
          SizedBox(height: 15),
          LinkText(text: 'on LinkedIn', url: S.linkedinUrl),
          Text("if you want to connect there."),
          SizedBox(height: 15),
          LinkText(text: 'on Medium', url: S.mediumUrl),
          Text("where i have posted one blog 😅. I'll publish more if I get time."),
          SizedBox(height: 15),
          LinkText(text: 'in Bangalore', url: S.mediumUrl),
          Text("where i'll me moving to soon and work out of."),
        ],
      ),
    );
  }
}
