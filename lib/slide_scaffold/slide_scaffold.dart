import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ppp/slide_scaffold/nav_button.dart';
import 'package:ppp/utils/functions.dart';

class SlideScaffold extends StatefulWidget {
  const SlideScaffold({Key? key, required this.slides}) : super(key: key);

  final List<Widget> slides;

  @override
  State<SlideScaffold> createState() => _SlideScaffoldState();
}

class _SlideScaffoldState extends State<SlideScaffold> {
  int _currentSlide = -1;
  final GlobalKey _navigatorKey = GlobalKey<NavigatorState>();

  void _onNext() {
    if (_currentSlide < widget.slides.length - 1) {
      _currentSlide++;
      Navigator.of(_navigatorKey.currentContext!).pushNamed(_currentSlide.toString());
    }
  }

  void _onPrevious() {
    if (_currentSlide > 0) {
      _currentSlide--;
      Navigator.of(_navigatorKey.currentContext!).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.slides.isNotEmpty) {
      _currentSlide = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: _navigatorKey,
        initialRoute: _currentSlide.toString(),
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => DefaultTextStyle(
            style: GoogleFonts.openSans(fontWeight: FontWeight.w600, color: Colors.black),
            child: F.getSlideFromName(settings.name, widget.slides),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NavButton(icon: Icons.arrow_left_rounded, onPressed: _onPrevious),
          const SizedBox(width: 10),
          NavButton(icon: Icons.arrow_right_rounded, onPressed: _onNext),
        ],
      ),
    );
  }
}
