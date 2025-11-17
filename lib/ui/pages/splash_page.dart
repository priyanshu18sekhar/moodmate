import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../state/app_state.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/premium_colors.dart';
import '../../theme/premium_text_styles.dart';

class SplashPage extends StatefulWidget {
	const SplashPage({super.key});

	@override
	State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
	@override
	void initState() {
		super.initState();
		_navigate();
	}

	void _navigate() async {
		await Future.delayed(const Duration(seconds: 2));
		if (!mounted) return;
		
		final appState = context.read<AppState>();
		final hasProfile = appState.childName != null;
		
		if (hasProfile) {
			context.go('/home');
		} else {
			context.go('/login');
		}
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Container(
				decoration: const BoxDecoration(
					gradient: LinearGradient(
						begin: Alignment.topLeft,
						end: Alignment.bottomRight,
						colors: PremiumColors.purpleGradient,
					),
				),
				child: Center(
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							Container(
								width: 140,
								height: 140,
								decoration: BoxDecoration(
									color: Colors.white.withValues(alpha: 0.2),
									shape: BoxShape.circle,
								),
								child: const Icon(
									Icons.psychology_rounded,
									size: 80,
									color: Colors.white,
								),
							).animate(onPlay: (controller) => controller.repeat())
								.scale(
									begin: const Offset(1.0, 1.0),
									end: const Offset(1.1, 1.1),
									duration: 1500.ms,
								)
								.then()
								.scale(
									begin: const Offset(1.1, 1.1),
									end: const Offset(1.0, 1.0),
									duration: 1500.ms,
								),
							
							const SizedBox(height: 40),
							
							Text(
								'MoodMate',
								style: PremiumTextStyles.display1.copyWith(color: Colors.white),
							).animate()
								.fadeIn(delay: 300.ms)
								.slide(begin: const Offset(0, 0.2)),
							
							const SizedBox(height: 12),
							
							Text(
								'Your AI Learning Companion',
								style: PremiumTextStyles.bodyMedium.copyWith(color: Colors.white.withValues(alpha: 0.9)),
							).animate()
								.fadeIn(delay: 500.ms),
							
							const SizedBox(height: 60),
							
							SizedBox(
								width: 200,
								child: LinearProgressIndicator(
									backgroundColor: Colors.white.withValues(alpha: 0.3),
									valueColor: const AlwaysStoppedAnimation(Colors.white),
								),
							).animate()
								.fadeIn(delay: 700.ms),
						],
					),
				),
			),
		);
	}
}
