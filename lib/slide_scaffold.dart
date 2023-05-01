import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ppp/utils/remote_controller.dart';
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
  final FocusNode keyboardFocusNode = FocusNode();

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
    RemoteController.onNext(_onNext);
    RemoteController.onPrevious(_onPrevious);
  }

  @override
  Widget build(BuildContext context) {
    // todo: also listen to ppt remote next/previous.
    return KeyboardListener(
      focusNode: keyboardFocusNode,
      onKeyEvent: (KeyEvent event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
            _onNext();
          } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            _onPrevious();
          }
        }
      },
      child: Scaffold(
        body: HeroControllerScope(
          controller: _heroController,
          child: Navigator(
            key: _navigatorKey,
            initialRoute: _currentSlide.toString(),
            onGenerateRoute: (settings) => PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => DefaultTextStyle(
                style: GoogleFonts.rubik(fontWeight: FontWeight.w600),
                child: F.getSlideFromName(settings.name, widget.slides),
              ),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const right = Offset(-1.0, 0.0);
                const center = Offset.zero;
                const left = Offset(1.0, 0.0);
                final inTween = Tween(begin: left, end: center);
                final outTween = Tween(begin: center, end: right);
                final Animation<Offset> offsetAnimation;

                if (animation.value == 1.0 && secondaryAnimation.value != 0.0) {
                  offsetAnimation = secondaryAnimation.drive(outTween);
                } else {
                  offsetAnimation = animation.drive(inTween);
                }

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
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
      ),
    );
  }
}
