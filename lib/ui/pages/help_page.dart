import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class HelpPage extends StatelessWidget {
	const HelpPage({super.key});

	@override
	Widget build(BuildContext context) {
		final scheme = Theme.of(context).colorScheme;
		
		return Scaffold(
			body: Container(
				decoration: BoxDecoration(
					gradient: LinearGradient(
						begin: Alignment.topLeft,
						end: Alignment.bottomRight,
						colors: [
							scheme.primary.withOpacity(0.1),
							scheme.secondary.withOpacity(0.1),
							scheme.background,
						],
					),
				),
				child: SafeArea(
					child: CustomScrollView(
						slivers: [
							// App Bar
							SliverAppBar(
								expandedHeight: 180,
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
										'Help Center 💡',
										style: GoogleFonts.fredoka(
											fontSize: 24,
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
													scheme.primary.withOpacity(0.3),
													scheme.secondary.withOpacity(0.3),
												],
											),
										),
										child: Center(
											child: SvgPicture.asset(
												'assets/icons/help_circle.svg',
												width: 100,
												height: 100,
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
										),
									),
								),
							),
							
							// Content
							SliverPadding(
								padding: const EdgeInsets.all(20),
								sliver: SliverList(
									delegate: SliverChildListDelegate([
										Text(
											'Need Help? We\'re here! 🤗',
											style: GoogleFonts.fredoka(
												fontSize: 28,
												fontWeight: FontWeight.bold,
												color: scheme.onBackground,
											),
										).animate()
											.fadeIn()
											.slide(begin: const Offset(-0.2, 0)),
										
										const SizedBox(height: 24),
										
										_buildHelpCard(
											icon: Icons.home_rounded,
											title: 'Getting Started',
											description: 'Tap the home icon to go back to the main screen. You\'ll find Buddy there to help you!',
											color: scheme.primary,
											delay: 200,
										),
										
										const SizedBox(height: 16),
										
										_buildHelpCard(
											icon: Icons.school_rounded,
											title: 'AI Tutor',
											description: 'Ask Buddy anything! Upload files, ask questions, and learn new things. It\'s like having a smart friend!',
											color: Colors.blue,
											delay: 300,
										),
										
										const SizedBox(height: 16),
										
										_buildHelpCard(
											icon: Icons.emoji_emotions_rounded,
											title: 'Emotion Camera',
											description: 'Use the camera to detect your mood. It helps Buddy understand how you\'re feeling!',
											color: Colors.pink,
											delay: 400,
										),
										
										const SizedBox(height: 16),
										
										_buildHelpCard(
											icon: Icons.insights_rounded,
											title: 'Analytics',
											description: 'See how much you\'ve learned! Track your progress and celebrate your achievements!',
											color: Colors.purple,
											delay: 500,
										),
										
										const SizedBox(height: 16),
										
										_buildHelpCard(
											icon: Icons.videogame_asset_rounded,
											title: 'Game Zone',
											description: 'Play fun educational games and earn rewards! Learning can be super fun!',
											color: Colors.orange,
											delay: 600,
										),
										
										const SizedBox(height: 32),
										
										Container(
											padding: const EdgeInsets.all(24),
											decoration: BoxDecoration(
												gradient: LinearGradient(
													colors: [scheme.primary, scheme.secondary],
												),
												borderRadius: BorderRadius.circular(24),
												boxShadow: [
													BoxShadow(
														color: scheme.primary.withOpacity(0.4),
														blurRadius: 20,
														offset: const Offset(0, 10),
													),
												],
											),
											child: Column(
												children: [
													Icon(Icons.privacy_tip_rounded, color: Colors.white, size: 48),
													const SizedBox(height: 16),
													Text(
														'Your Privacy Matters! 🔒',
														style: GoogleFonts.fredoka(
															fontSize: 20,
															fontWeight: FontWeight.bold,
															color: Colors.white,
														),
														textAlign: TextAlign.center,
													),
													const SizedBox(height: 8),
													Text(
														'All your data stays safe on your device. We don\'t send your camera or personal information anywhere!',
														style: GoogleFonts.comfortaa(
															fontSize: 14,
															color: Colors.white.withOpacity(0.95),
														),
														textAlign: TextAlign.center,
													),
												],
											),
										).animate()
											.fadeIn(delay: 700.ms)
											.scale(begin: const Offset(0.9, 0.9)),
										
										const SizedBox(height: 32),
										
										Center(
											child: Column(
												children: [
													Text(
														'Still need help?',
														style: GoogleFonts.comfortaa(
															fontSize: 16,
															color: scheme.onBackground.withOpacity(0.7),
														),
													),
													const SizedBox(height: 12),
													ElevatedButton.icon(
														onPressed: () {
															// Could add email or support link
															ScaffoldMessenger.of(context).showSnackBar(
																SnackBar(
																	content: Text(
																		'Support coming soon!',
																		style: GoogleFonts.comfortaa(),
																	),
																	backgroundColor: scheme.primary,
																	behavior: SnackBarBehavior.floating,
																	shape: RoundedRectangleBorder(
																		borderRadius: BorderRadius.circular(10),
																	),
																),
															);
														},
														icon: const Icon(Icons.mail_rounded),
														label: Text(
															'Contact Support',
															style: GoogleFonts.fredoka(),
														),
														style: ElevatedButton.styleFrom(
															backgroundColor: scheme.primary,
															foregroundColor: Colors.white,
															padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
															shape: RoundedRectangleBorder(
																borderRadius: BorderRadius.circular(20),
															),
														),
													),
												],
											),
										).animate()
											.fadeIn(delay: 900.ms),
										
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

	Widget _buildHelpCard({
		required IconData icon,
		required String title,
		required String description,
		required Color color,
		required int delay,
	}) {
		return Container(
			padding: const EdgeInsets.all(20),
			decoration: BoxDecoration(
				color: Colors.white,
				borderRadius: BorderRadius.circular(20),
				boxShadow: [
					BoxShadow(
						color: color.withOpacity(0.2),
						blurRadius: 15,
						offset: const Offset(0, 5),
					),
				],
			),
			child: Row(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Container(
						width: 60,
						height: 60,
						decoration: BoxDecoration(
							color: color.withOpacity(0.15),
							borderRadius: BorderRadius.circular(16),
						),
						child: Icon(icon, color: color, size: 32),
					),
					const SizedBox(width: 16),
					Expanded(
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								Text(
									title,
									style: GoogleFonts.fredoka(
										fontSize: 18,
										fontWeight: FontWeight.bold,
										color: color,
									),
								),
								const SizedBox(height: 8),
								Text(
									description,
									style: GoogleFonts.comfortaa(
										fontSize: 14,
										color: Colors.black87,
										height: 1.4,
									),
								),
							],
						),
					),
				],
			),
		).animate()
			.fadeIn(delay: Duration(milliseconds: delay))
			.slide(begin: const Offset(-0.3, 0), curve: Curves.easeOut);
	}
}


