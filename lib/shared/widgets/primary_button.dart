import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magang/config/themes/colors.dart';


class PrimaryButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final VisualDensity? visualDensity;
  final bool isCompact;

  const PrimaryButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.visualDensity,
  }) : isCompact = false,
        super(key: key);

  const PrimaryButton.compact({
    Key? key,
    required this.text,
    this.onPressed,
  })  : visualDensity = VisualDensity.compact,
        isCompact = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: blueColor,
        elevation: 3,
        textStyle: GoogleFonts.montserrat(
          fontSize: 14.sp,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          height: 1.219,
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: darkBlueColor, width: 1),
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Text(text),
    );
  }
}