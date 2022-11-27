import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ppp/widgets/nav_button.dart';
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
  final HeroController _heroController = HeroController(
    createRectTween: (Rect? begin, Rect? end) {
      return MaterialRectArcTween(begin: begin, end: end);
    },
  );

  void _updatePage() {
    Navigator.of(_navigatorKey.currentContext!).pushReplacementNamed(_currentSlide.toString());
  }

  void _onNext() {
    if (_currentSlide < widget.slides.length - 1) {
      _currentSlide++;
      _updatePage();
    }
  }

  void _onPrevious() {
    if (_currentSlide > 0) {
      _currentSlide--;
      _updatePage();
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
      body: HeroControllerScope(
        controller: _heroController,
        child: Navigator(
          key: _navigatorKey,
          initialRoute: _currentSlide.toString(),
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (_) => DefaultTextStyle(
              style: GoogleFonts.openSans(fontWeight: FontWeight.w600),
              child: F.getSlideFromName(settings.name, widget.slides),
            ),
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