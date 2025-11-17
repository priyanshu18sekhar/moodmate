import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/premium_colors.dart';
import '../../theme/premium_text_styles.dart';

class LoginPage extends StatefulWidget {
	const LoginPage({super.key});

	@override
	State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
	final _nameController = TextEditingController();

	@override
	void dispose() {
		_nameController.dispose();
		super.dispose();
	}

	void _proceedToRegistration() {
		if (_nameController.text.trim().isEmpty) {
			ScaffoldMessenger.of(context).showSnackBar(
				SnackBar(
					content: Text('Please enter your name', style: PremiumTextStyles.bodyMedium.copyWith(color: Colors.white)),
					backgroundColor: PremiumColors.error,
					behavior: SnackBarBehavior.floating,
					shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
				),
			);
			return;
		}
		context.go('/register');
	}

	@override
	Widget build(BuildContext context) {
		final size = MediaQuery.of(context).size;
		
		return Scaffold(
			backgroundColor: PremiumColors.backgroundLight,
			body: SafeArea(
				child: SingleChildScrollView(
					child: SizedBox(
						height: size.height - MediaQuery.of(context).padding.top,
						child: Column(
							children: [
								Expanded(
									child: Padding(
										padding: const EdgeInsets.all(32),
										child: Column(
											mainAxisAlignment: MainAxisAlignment.center,
											children: [
												// Logo/Icon
												Container(
													width: 120,
													height: 120,
													decoration: BoxDecoration(
														gradient: const LinearGradient(
															colors: PremiumColors.purpleGradient,
															begin: Alignment.topLeft,
															end: Alignment.bottomRight,
														),
														shape: BoxShape.circle,
														boxShadow: PremiumColors.accentShadow(PremiumColors.primaryPurple),
													),
													child: const Icon(
														Icons.psychology_rounded,
														size: 60,
														color: Colors.white,
													),
												).animate()
													.fadeIn(duration: 600.ms)
													.scale(begin: const Offset(0.5, 0.5), curve: Curves.elasticOut),
												
												const SizedBox(height: 40),
												
												// Welcome Text
												Text(
													'Welcome to',
													style: PremiumTextStyles.h4.copyWith(color: PremiumColors.gray600),
												).animate()
													.fadeIn(delay: 200.ms)
													.slide(begin: const Offset(0, 0.3)),
												
												const SizedBox(height: 8),
												
												Text(
													'MoodMate',
													style: PremiumTextStyles.display1.copyWith(
														foreground: Paint()
															..shader = const LinearGradient(
																colors: PremiumColors.purpleGradient,
															).createShader(const Rect.fromLTWH(0, 0, 300, 100)),
													),
												).animate()
													.fadeIn(delay: 300.ms)
													.slide(begin: const Offset(0, 0.3)),
												
												const SizedBox(height: 12),
												
												Text(
													'Your AI-powered learning companion',
													style: PremiumTextStyles.bodyMedium.copyWith(color: PremiumColors.gray600),
													textAlign: TextAlign.center,
												).animate()
													.fadeIn(delay: 400.ms),
												
												const SizedBox(height: 60),
												
												// Name Input
												Container(
													decoration: BoxDecoration(
														color: PremiumColors.gray100,
														borderRadius: BorderRadius.circular(16),
														border: Border.all(color: PremiumColors.gray200),
													),
													child: TextField(
														controller: _nameController,
														style: PremiumTextStyles.bodyLarge,
														decoration: InputDecoration(
															hintText: 'Enter your name',
															hintStyle: PremiumTextStyles.bodyLarge.copyWith(color: PremiumColors.gray400),
															prefixIcon: const Icon(Icons.person_outline_rounded, color: PremiumColors.primaryPurple),
															border: InputBorder.none,
															contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
														),
														onSubmitted: (_) => _proceedToRegistration(),
													),
												).animate()
													.fadeIn(delay: 500.ms)
													.slide(begin: const Offset(0, 0.2)),
												
												const SizedBox(height: 24),
												
												// Continue Button
												SizedBox(
													width: double.infinity,
													height: 56,
													child: Container(
														decoration: BoxDecoration(
															gradient: const LinearGradient(colors: PremiumColors.purpleGradient),
															borderRadius: BorderRadius.circular(16),
															boxShadow: PremiumColors.accentShadow(PremiumColors.primaryPurple),
														),
														child: Material(
															color: Colors.transparent,
															child: InkWell(
																borderRadius: BorderRadius.circular(16),
																onTap: _proceedToRegistration,
																child: Center(
																	child: Text(
																		'Continue',
																		style: PremiumTextStyles.buttonLarge.copyWith(color: Colors.white),
																	),
																),
															),
														),
													),
												).animate()
													.fadeIn(delay: 600.ms)
													.scale(begin: const Offset(0.95, 0.95)),
											],
										),
									),
								),
								
								// Bottom Features
								Container(
									padding: const EdgeInsets.all(24),
									decoration: BoxDecoration(
										color: PremiumColors.gray100,
										borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
									),
									child: Column(
										children: [
											Row(
												mainAxisAlignment: MainAxisAlignment.spaceAround,
												children: [
													_buildFeature(Icons.school_rounded, 'AI Tutor'),
													_buildFeature(Icons.bar_chart_rounded, 'Analytics'),
													_buildFeature(Icons.videogame_asset_rounded, 'Games'),
												],
											),
										],
									),
								).animate()
													.fadeIn(delay: 700.ms)
													.slide(begin: const Offset(0, 0.3)),
							],
						),
					),
				),
			),
		);
	}

	Widget _buildFeature(IconData icon, String label) {
		return Column(
			children: [
				Container(
					padding: const EdgeInsets.all(12),
					decoration: BoxDecoration(
						color: PremiumColors.backgroundLight,
						borderRadius: BorderRadius.circular(14),
						boxShadow: PremiumColors.cardShadow,
					),
					child: Icon(icon, color: PremiumColors.primaryPurple, size: 24),
				),
				const SizedBox(height: 8),
				Text(
					label,
					style: PremiumTextStyles.labelSmall.copyWith(color: PremiumColors.gray700),
				),
			],
		);
	}
}
