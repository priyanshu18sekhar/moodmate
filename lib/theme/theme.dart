import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'age_group.dart';
import 'color_schemes.dart';

ThemeData buildTheme(AgeGroup group) {
	final colorScheme = AgeColorSchemes.forGroup(group);
	final baseText = GoogleFonts.fredokaTextTheme().copyWith(
		displayLarge: GoogleFonts.baloo2(fontSize: 48, fontWeight: FontWeight.w700),
		displayMedium: GoogleFonts.baloo2(fontSize: 36, fontWeight: FontWeight.w700),
		displaySmall: GoogleFonts.baloo2(fontSize: 28, fontWeight: FontWeight.w700),
		titleLarge: GoogleFonts.fredoka(fontSize: 22, fontWeight: FontWeight.w700),
		titleMedium: GoogleFonts.fredoka(fontSize: 18, fontWeight: FontWeight.w600),
		titleSmall: GoogleFonts.fredoka(fontSize: 16, fontWeight: FontWeight.w600),
		bodyLarge: GoogleFonts.nunito(fontSize: 18, height: 1.4),
		bodyMedium: GoogleFonts.nunito(fontSize: 16, height: 1.4),
		bodySmall: GoogleFonts.nunito(fontSize: 14, height: 1.4),
	);

	return ThemeData(
		colorScheme: colorScheme,
		useMaterial3: true,
		textTheme: baseText,
	 scaffoldBackgroundColor: colorScheme.background,
		appBarTheme: AppBarTheme(
			backgroundColor: colorScheme.primary,
			foregroundColor: colorScheme.onPrimary,
			elevation: 0,
			centerTitle: true,
			titleTextStyle: baseText.titleLarge?.copyWith(color: colorScheme.onPrimary),
		),
		cardTheme: CardThemeData(
			color: colorScheme.surface,
			shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
			elevation: 4,
		),
		inputDecorationTheme: InputDecorationTheme(
			filled: true,
			fillColor: colorScheme.surface,
			border: OutlineInputBorder(
				borderRadius: BorderRadius.circular(20),
				borderSide: BorderSide(color: colorScheme.secondary.withOpacity(.5)),
			),
			enabledBorder: OutlineInputBorder(
				borderRadius: BorderRadius.circular(20),
				borderSide: BorderSide(color: colorScheme.secondary.withOpacity(.5)),
			),
			focusedBorder: OutlineInputBorder(
				borderRadius: BorderRadius.circular(20),
				borderSide: BorderSide(color: colorScheme.primary, width: 2),
			),
		),
		buttonTheme: const ButtonThemeData(height: 56),
	);
}


