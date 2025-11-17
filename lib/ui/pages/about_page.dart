import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AboutPage extends StatelessWidget {
	const AboutPage({super.key});

	@override
	Widget build(BuildContext context) {
		final scheme = Theme.of(context).colorScheme;
		
		return Scaffold(
			body: Container(
				decoration: BoxDecoration(
					gradient: LinearGradient(
						begin: Alignment.topCenter,
						end: Alignment.bottomCenter,
						colors: [
							scheme.primary.withOpacity(0.2),
							scheme.secondary.withOpacity(0.2),
							scheme.background,
						],
					),
				),
				child: SafeArea(
					child: CustomScrollView(
						slivers: [
							// App Bar
							SliverAppBar(
								expandedHeight: 200,
								floating: false,
								pinned: true,
								backgroundColor: Colors.transparent,
								leading: IconButton(
									icon: Container(
										padding: const EdgeInsets.all(8),
										decoration: BoxDecoration(
											color: Colors.white,
											borderRadius: BorderRadius.circular(12),
											boxShadow: [
												BoxShadow(
													color: scheme.primary.withOpacity(0.3),
													blurRadius: 8,
													offset: const Offset(0, 2),
												),
											],
										),
										child: Icon(Icons.arrow_back_rounded, color: scheme.primary),
									),
									onPressed: () => context.pop(),
								),
								flexibleSpace: FlexibleSpaceBar(
									title: Text(
										'About MoodMate',
										style: GoogleFonts.fredoka(
											fontSize: 22,
											fontWeight: FontWeight.bold,
											color: scheme.primary,
										),
									),
									background: Container(
										decoration: BoxDecoration(
											gradient: LinearGradient(
												begin: Alignment.topLeft,
												end: Alignment.bottomRight,
												colors: [
													scheme.primary.withOpacity(0.4),
													scheme.secondary.withOpacity(0.4),
												],
											),
										),
										child: Center(
											child: Column(
												mainAxisSize: MainAxisSize.min,
												children: [
													const SizedBox(height: 40),
													SvgPicture.asset(
														'assets/illustrations/robot_avatar.svg',
														width: 100,
														height: 100,
													).animate(onPlay: (controller) => controller.repeat())
														.scale(
															begin: const Offset(1.0, 1.0),
															end: const Offset(1.05, 1.05),
															duration: 2000.ms,
														)
														.then()
														.scale(
															begin: const Offset(1.05, 1.05),
															end: const Offset(1.0, 1.0),
															duration: 2000.ms,
														),
												],
											),
										),
									),
								),
							),
							
							// Content
							SliverPadding(
								padding: const EdgeInsets.all(20),
								sliver: SliverList(
									delegate: SliverChildListDelegate([
										// Logo and title
										Center(
											child: Column(
												children: [
													Text(
														'MoodMate',
														style: GoogleFonts.fredoka(
															fontSize: 48,
															fontWeight: FontWeight.bold,
															foreground: Paint()
																..shader = LinearGradient(
																	colors: [scheme.primary, scheme.secondary],
																).createShader(const Rect.fromLTWH(0, 0, 300, 70)),
														),
													),
													const SizedBox(height: 8),
													Container(
														padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
														decoration: BoxDecoration(
															color: scheme.primary.withOpacity(0.2),
															borderRadius: BorderRadius.circular(20),
														),
														child: Text(
															'Version 1.0.0',
															style: GoogleFonts.comfortaa(
																fontSize: 14,
																fontWeight: FontWeight.w600,
																color: scheme.primary,
															),
														),
													),
												],
											),
										).animate()
											.fadeIn()
											.scale(begin: const Offset(0.8, 0.8), curve: Curves.elasticOut),
										
										const SizedBox(height: 32),
										
										// Mission statement
										Container(
											padding: const EdgeInsets.all(24),
											decoration: BoxDecoration(
												color: Colors.white,
												borderRadius: BorderRadius.circular(24),
												boxShadow: [
													BoxShadow(
														color: scheme.primary.withOpacity(0.2),
														blurRadius: 20,
														offset: const Offset(0, 10),
													),
												],
											),
											child: Column(
												children: [
													Text(
														'Our Mission 🎯',
														style: GoogleFonts.fredoka(
															fontSize: 24,
															fontWeight: FontWeight.bold,
															color: scheme.primary,
														),
													),
													const SizedBox(height: 16),
													Text(
														'MoodMate is a kid-friendly AI companion that makes learning fun and helps children understand their emotions better!',
														style: GoogleFonts.comfortaa(
															fontSize: 16,
															color: Colors.black87,
															height: 1.5,
														),
														textAlign: TextAlign.center,
													),
												],
											),
										).animate()
											.fadeIn(delay: 200.ms)
											.scale(begin: const Offset(0.9, 0.9)),
										
										const SizedBox(height: 24),
										
										// Features
										Text(
											'What We Offer 🌟',
											style: GoogleFonts.fredoka(
												fontSize: 24,
												fontWeight: FontWeight.bold,
												color: scheme.onBackground,
											),
										).animate()
											.fadeIn(delay: 400.ms)
											.slide(begin: const Offset(-0.2, 0)),
										
										const SizedBox(height: 16),
										
										_buildFeatureCard(
											icon: Icons.psychology_rounded,
											title: 'AI-Powered Learning',
											description: 'Smart tutoring that adapts to your pace',
											color: Colors.blue,
											delay: 500,
										),
										
										const SizedBox(height: 12),
										
										_buildFeatureCard(
											icon: Icons.favorite_rounded,
											title: 'Emotion Awareness',
											description: 'Understand and express your feelings',
											color: Colors.pink,
											delay: 600,
										),
										
										const SizedBox(height: 12),
										
										_buildFeatureCard(
											icon: Icons.sports_esports_rounded,
											title: 'Fun & Games',
											description: 'Learn through play and earn rewards',
											color: Colors.orange,
											delay: 700,
										),
										
										const SizedBox(height: 12),
										
										_buildFeatureCard(
											icon: Icons.shield_rounded,
											title: 'Safe & Private',
											description: 'All data stays on your device',
											color: Colors.green,
											delay: 800,
										),
										
										const SizedBox(height: 32),
										
										// Privacy section
										Container(
											padding: const EdgeInsets.all(24),
											decoration: BoxDecoration(
												gradient: LinearGradient(
													colors: [Colors.green.shade400, Colors.teal.shade400],
												),
												borderRadius: BorderRadius.circular(24),
												boxShadow: [
													BoxShadow(
														color: Colors.green.withOpacity(0.3),
														blurRadius: 20,
														offset: const Offset(0, 10),
													),
												],
											),
											child: Column(
												children: [
													Icon(Icons.verified_user_rounded, color: Colors.white, size: 56),
													const SizedBox(height: 16),
													Text(
														'Privacy First! 🔐',
														style: GoogleFonts.fredoka(
															fontSize: 24,
															fontWeight: FontWeight.bold,
															color: Colors.white,
														),
														textAlign: TextAlign.center,
													),
													const SizedBox(height: 12),
													Text(
														'Your privacy is super important to us! All emotion detection and learning data stays safely on your device. We never send your camera data or personal information to any servers.',
														style: GoogleFonts.comfortaa(
															fontSize: 15,
															color: Colors.white.withOpacity(0.95),
															height: 1.5,
														),
														textAlign: TextAlign.center,
													),
												],
											),
										).animate()
											.fadeIn(delay: 900.ms)
											.scale(begin: const Offset(0.9, 0.9)),
										
										const SizedBox(height: 32),
										
										// Made with love
										Center(
											child: Container(
												padding: const EdgeInsets.all(20),
												decoration: BoxDecoration(
													color: Colors.white,
													borderRadius: BorderRadius.circular(20),
													boxShadow: [
														BoxShadow(
															color: Colors.grey.withOpacity(0.2),
															blurRadius: 15,
															offset: const Offset(0, 5),
														),
													],
												),
												child: Column(
													children: [
														Row(
															mainAxisSize: MainAxisSize.min,
															children: [
																Text(
																	'Made with',
																	style: GoogleFonts.comfortaa(
																		fontSize: 16,
																		color: Colors.black54,
																	),
																),
																const SizedBox(width: 8),
																const Text('❤️', style: TextStyle(fontSize: 20))
																	.animate(onPlay: (controller) => controller.repeat())
																	.scale(
																		begin: const Offset(1.0, 1.0),
																		end: const Offset(1.3, 1.3),
																		duration: 600.ms,
																	)
																	.then()
																	.scale(
																		begin: const Offset(1.3, 1.3),
																		end: const Offset(1.0, 1.0),
																		duration: 600.ms,
																	),
																const SizedBox(width: 8),
																Text(
																	'for kids',
																	style: GoogleFonts.comfortaa(
																		fontSize: 16,
																		color: Colors.black54,
																	),
																),
															],
														),
														const SizedBox(height: 12),
														Row(
															mainAxisSize: MainAxisSize.min,
															children: [
																Icon(Icons.flutter_dash, color: scheme.primary, size: 20),
																const SizedBox(width: 8),
																Text(
																	'Built with Flutter',
																	style: GoogleFonts.comfortaa(
																		fontSize: 14,
																		color: scheme.primary,
																		fontWeight: FontWeight.w600,
																	),
																),
															],
														),
													],
												),
											),
										).animate()
											.fadeIn(delay: 1100.ms),
										
										const SizedBox(height: 40),
									]),
								),
							),
						],
					),
				),
			),
		);
	}

	Widget _buildFeatureCard({
		required IconData icon,
		required String title,
		required String description,
		required Color color,
		required int delay,
	}) {
		return Container(
			padding: const EdgeInsets.all(16),
			decoration: BoxDecoration(
				color: Colors.white,
				borderRadius: BorderRadius.circular(16),
				boxShadow: [
					BoxShadow(
						color: color.withOpacity(0.2),
						blurRadius: 10,
						offset: const Offset(0, 4),
					),
				],
			),
			child: Row(
				children: [
					Container(
						width: 50,
						height: 50,
						decoration: BoxDecoration(
							color: color.withOpacity(0.15),
							borderRadius: BorderRadius.circular(12),
						),
						child: Icon(icon, color: color, size: 28),
					),
					const SizedBox(width: 16),
					Expanded(
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								Text(
									title,
									style: GoogleFonts.fredoka(
										fontSize: 16,
										fontWeight: FontWeight.bold,
										color: Colors.black87,
									),
								),
								const SizedBox(height: 4),
								Text(
									description,
									style: GoogleFonts.comfortaa(
										fontSize: 13,
										color: Colors.black54,
									),
								),
							],
						),
					),
				],
			),
		).animate()
			.fadeIn(delay: Duration(milliseconds: delay))
			.slide(begin: const Offset(-0.2, 0), curve: Curves.easeOut);
	}
}


