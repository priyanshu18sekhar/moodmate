import 'package:flutter/material.dart';
import 'age_group.dart';

class AgeColorSchemes {
	static ColorScheme junior() {
		return const ColorScheme(
			brightness: Brightness.light,
			primary: Color(0xFFFFC107), // sunny yellow
			onPrimary: Color(0xFF1A1A1A),
			secondary: Color(0xFF4FC3F7), // sky blue
			onSecondary: Color(0xFF0C1B2A),
			error: Color(0xFFE53935),
			onError: Colors.white,
			background: Color(0xFFFFF8E1),
			onBackground: Color(0xFF1A1A1A),
			surface: Color(0xFFFFFFFF),
			onSurface: Color(0xFF1A1A1A),
		);
	}

	static ColorScheme middle() {
		return const ColorScheme(
			brightness: Brightness.light,
			primary: Color(0xFFFF6F61), // coral
			onPrimary: Colors.white,
			secondary: Color(0xFF26A69A), // teal
			onSecondary: Colors.white,
			error: Color(0xFFD32F2F),
			onError: Colors.white,
			background: Color(0xFFFDF3F1),
			onBackground: Color(0xFF121212),
			surface: Color(0xFFFFFFFF),
			onSurface: Color(0xFF121212),
		);
	}

	static ColorScheme senior() {
		return const ColorScheme(
			brightness: Brightness.light,
			primary: Color(0xFF3F51B5), // indigo
			onPrimary: Colors.white,
			secondary: Color(0xFF80CBC4), // mint
			onSecondary: Color(0xFF0A0A0A),
			error: Color(0xFFC62828),
			onError: Colors.white,
			background: Color(0xFFEEF1FF),
			onBackground: Color(0xFF0F0F0F),
			surface: Color(0xFFFFFFFF),
			onSurface: Color(0xFF0F0F0F),
		);
	}

	static ColorScheme forGroup(AgeGroup group) {
		switch (group) {
			case AgeGroup.junior:
			 return junior();
			case AgeGroup.middle:
			 return middle();
			case AgeGroup.senior:
			 return senior();
		}
	}
}


