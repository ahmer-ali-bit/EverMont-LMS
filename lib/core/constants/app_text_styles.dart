import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import '../utils/responsive_helper.dart';

class AppTextStyles {
  static TextStyle display(BuildContext context,
      {Color? color, FontWeight? fontWeight}) {
    return GoogleFonts.poppins(
      fontSize: context.sp(28),
      fontWeight: fontWeight ?? FontWeight.w700,
      color: color ?? AppColors.textPrimary,
    );
  }

  static TextStyle h1(BuildContext context,
      {Color? color, FontWeight? fontWeight}) {
    return GoogleFonts.poppins(
      fontSize: context.sp(24),
      fontWeight: fontWeight ?? FontWeight.w700,
      color: color ?? AppColors.textPrimary,
    );
  }

  static TextStyle h2(BuildContext context,
      {Color? color, FontWeight? fontWeight}) {
    return GoogleFonts.poppins(
      fontSize: context.sp(20),
      fontWeight: fontWeight ?? FontWeight.w600,
      color: color ?? AppColors.textPrimary,
    );
  }

  static TextStyle bodyLarge(BuildContext context,
      {Color? color, FontWeight? fontWeight}) {
    return GoogleFonts.inter(
      fontSize: context.sp(16),
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color ?? AppColors.textPrimary,
    );
  }

  static TextStyle bodyMedium(BuildContext context,
      {Color? color, FontWeight? fontWeight}) {
    return GoogleFonts.inter(
      fontSize: context.sp(14),
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color ?? AppColors.textSecondary,
    );
  }

  static TextStyle bodySmall(BuildContext context,
      {Color? color, FontWeight? fontWeight}) {
    return GoogleFonts.inter(
      fontSize: context.sp(12),
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color ?? AppColors.textTertiary,
    );
  }
}
