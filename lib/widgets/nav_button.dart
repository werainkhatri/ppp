import 'package:flutter/material.dart';

class NavButton extends StatefulWidget {
  const NavButton({Key? key, required this.icon, this.onPressed}) : super(key: key);

  final IconData icon;
  final VoidCallback? onPressed;

  static const buttonSize = 50.0;

  @override
  State<NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Theme.of(context).colorScheme.primary.withAlpha(50)),
      ),
      child: MouseRegion(
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
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: widget.onPressed,
          hoverColor: Theme.of(context).colorScheme.onPrimary,
          splashColor: Theme.of(context).colorScheme.surface,
          child: isHovering
              ? Icon(
                  widget.icon,
                  color: Theme.of(context).colorScheme.primary,
                  size: NavButton.buttonSize,
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
