import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ppp/utils/colors.dart';

class NullSafety extends StatelessWidget {
  const NullSafety({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: C.flutterBlue, width: 1.5),
      ),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
          child: Tooltip(
            message: 'Supports the null safety language feature.',
            child: Text(
              'Null safety',
              style: GoogleFonts.sairaCondensed(
                color: C.flutterBlue,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
