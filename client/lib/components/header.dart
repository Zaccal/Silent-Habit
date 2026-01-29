import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.dayNumber});

  final int dayNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 8,
            children: [
              Text('Today:', style: GoogleFonts.rubikSprayPaint(fontSize: 24)),
              Row(
                children: [
                  Text(
                    dayNumber.toString(),
                    style: GoogleFonts.rubikSprayPaint(fontSize: 24),
                  ),
                  Text('/7', style: GoogleFonts.rubikSprayPaint(fontSize: 24)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
