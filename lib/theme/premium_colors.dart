import 'package:flutter/material.dart';

// Premium Color Palette for MoodMate
class PremiumColors {
	// Primary Colors - Sophisticated and Calming
	static const Color primaryPurple = Color(0xFF6B4CE6);
	static const Color primaryBlue = Color(0xFF4D7CFE);
	static const Color primaryPink = Color(0xFFFF6B9D);
	static const Color primaryTeal = Color(0xFF00BFA6);
	
	// Accent Colors - Vibrant but Sophisticated
	static const Color accentOrange = Color(0xFFFF8C42);
	static const Color accentYellow = Color(0xFFFFD93D);
	static const Color accentGreen = Color(0xFF6BCF7F);
	static const Color accentCyan = Color(0xFF4FC3F7);
	
	// Neutral Colors - Premium Grays
	static const Color gray50 = Color(0xFFFAFAFA);
	static const Color gray100 = Color(0xFFF5F5F7);
	static const Color gray200 = Color(0xFFE8E8ED);
	static const Color gray300 = Color(0xFFD1D1D6);
	static const Color gray400 = Color(0xFFACACAC);
	static const Color gray500 = Color(0xFF8E8E93);
	static const Color gray600 = Color(0xFF636366);
	static const Color gray700 = Color(0xFF48484A);
	static const Color gray800 = Color(0xFF2C2C2E);
	static const Color gray900 = Color(0xFF1C1C1E);
	
	// Background Colors - Clean and Modern
	static const Color backgroundLight = Color(0xFFFFFFFF);
	static const Color backgroundGray = Color(0xFFF8F9FB);
	static const Color backgroundDark = Color(0xFF1A1A2E);
	
	// Semantic Colors
	static const Color success = Color(0xFF34C759);
	static const Color warning = Color(0xFFFF9500);
	static const Color error = Color(0xFFFF3B30);
	static const Color info = Color(0xFF007AFF);
	
	// Gradient Combinations
	static const List<Color> purpleGradient = [Color(0xFF6B4CE6), Color(0xFF9B7EF7)];
	static const List<Color> blueGradient = [Color(0xFF4D7CFE), Color(0xFF7BA5FF)];
	static const List<Color> pinkGradient = [Color(0xFFFF6B9D), Color(0xFFFF9EC9)];
	static const List<Color> tealGradient = [Color(0xFF00BFA6), Color(0xFF5DD9C1)];
	static const List<Color> orangeGradient = [Color(0xFFFF8C42), Color(0xFFFFB178)];
	static const List<Color> sunsetGradient = [Color(0xFFFF6B9D), Color(0xFFFF8C42)];
	static const List<Color> oceanGradient = [Color(0xFF4D7CFE), Color(0xFF00BFA6)];
	
	// Age-Based Themes
	static LinearGradient getAgeGradient(String ageGroup) {
		switch (ageGroup.toLowerCase()) {
			case 'junior':
				return const LinearGradient(
					colors: [Color(0xFFFF6B9D), Color(0xFFFFB178)],
					begin: Alignment.topLeft,
					end: Alignment.bottomRight,
				);
			case 'middle':
				return const LinearGradient(
					colors: [Color(0xFF4D7CFE), Color(0xFF00BFA6)],
					begin: Alignment.topLeft,
					end: Alignment.bottomRight,
				);
			case 'senior':
				return const LinearGradient(
					colors: [Color(0xFF6B4CE6), Color(0xFF9B7EF7)],
					begin: Alignment.topLeft,
					end: Alignment.bottomRight,
				);
			default:
				return const LinearGradient(
					colors: [Color(0xFF6B4CE6), Color(0xFF4D7CFE)],
					begin: Alignment.topLeft,
					end: Alignment.bottomRight,
				);
		}
	}
	
	// Card Shadows
	static List<BoxShadow> cardShadow = [
		BoxShadow(
			color: Colors.black.withValues(alpha: 0.06),
			blurRadius: 20,
			offset: const Offset(0, 4),
			spreadRadius: 0,
		),
	];
	
	static List<BoxShadow> elevatedShadow = [
		BoxShadow(
			color: Colors.black.withValues(alpha: 0.1),
			blurRadius: 30,
			offset: const Offset(0, 8),
			spreadRadius: 0,
		),
	];
	
	static List<BoxShadow> accentShadow(Color color) => [
		BoxShadow(
			color: color.withValues(alpha: 0.3),
			blurRadius: 20,
			offset: const Offset(0, 6),
			spreadRadius: 0,
		),
	];
}


