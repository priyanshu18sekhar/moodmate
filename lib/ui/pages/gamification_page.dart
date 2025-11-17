import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import '../../theme/premium_colors.dart';
import '../../theme/premium_text_styles.dart';

class GamificationPage extends StatefulWidget {
	const GamificationPage({super.key});

	@override
	State<GamificationPage> createState() => _GamificationPageState();
}

class _GamificationPageState extends State<GamificationPage> {
	late ConfettiController _confettiController;
	
	final int _coins = 1250;
	final int _gems = 45;
	final int _level = 7;
	final double _levelProgress = 0.65;

	@override
	void initState() {
		super.initState();
		_confettiController = ConfettiController(duration: const Duration(seconds: 2));
	}

	@override
	void dispose() {
		_confettiController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: PremiumColors.backgroundGray,
			body: Stack(
				children: [
					SafeArea(
						child: CustomScrollView(
							slivers: [
								_buildHeader(),
								SliverPadding(
									padding: const EdgeInsets.all(20),
									sliver: SliverList(
										delegate: SliverChildListDelegate([
											_buildUserStats(),
											const SizedBox(height: 24),
											_buildGamesSection(),
											const SizedBox(height: 24),
											_buildChallengesSection(),
											const SizedBox(height: 24),
											_buildLeaderboard(),
											const SizedBox(height: 20),
										]),
									),
								),
							],
						),
					),
					Align(
						alignment: Alignment.topCenter,
						child: ConfettiWidget(
							confettiController: _confettiController,
							blastDirectionality: BlastDirectionality.explosive,
							particleDrag: 0.05,
							emissionFrequency: 0.05,
							numberOfParticles: 25,
							gravity: 0.1,
							shouldLoop: false,
							colors: const [
								PremiumColors.primaryPurple,
								PremiumColors.primaryBlue,
								PremiumColors.accentOrange,
								PremiumColors.accentGreen,
								PremiumColors.primaryPink,
							],
						),
					),
				],
			),
		);
	}

	Widget _buildHeader() {
		return SliverToBoxAdapter(
			child: Container(
				padding: const EdgeInsets.all(20),
				decoration: BoxDecoration(
					color: PremiumColors.backgroundLight,
					boxShadow: PremiumColors.cardShadow,
				),
				child: Row(
					children: [
						Container(
							padding: const EdgeInsets.all(12),
							decoration: BoxDecoration(
								gradient: const LinearGradient(colors: PremiumColors.orangeGradient),
								borderRadius: BorderRadius.circular(16),
								boxShadow: PremiumColors.accentShadow(PremiumColors.accentOrange),
							),
							child: const Icon(Icons.videogame_asset_rounded, color: Colors.white, size: 28),
						),
						const SizedBox(width: 16),
						Expanded(
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									Text('Game Zone', style: PremiumTextStyles.h3.copyWith(color: PremiumColors.gray900)),
									Text('Learn while you play', style: PremiumTextStyles.caption),
								],
							),
						),
						Row(
							children: [
								Container(
									padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
									decoration: BoxDecoration(
										gradient: const LinearGradient(colors: [PremiumColors.accentOrange, PremiumColors.accentYellow]),
										borderRadius: BorderRadius.circular(12),
										boxShadow: PremiumColors.accentShadow(PremiumColors.accentOrange),
									),
									child: Row(
										mainAxisSize: MainAxisSize.min,
										children: [
											const Icon(Icons.monetization_on_rounded, color: Colors.white, size: 16),
											const SizedBox(width: 6),
											Text('$_coins', style: PremiumTextStyles.labelLarge.copyWith(color: Colors.white)),
										],
									),
								),
								const SizedBox(width: 8),
								Container(
									padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
									decoration: BoxDecoration(
										gradient: const LinearGradient(colors: PremiumColors.blueGradient),
										borderRadius: BorderRadius.circular(12),
										boxShadow: PremiumColors.accentShadow(PremiumColors.primaryBlue),
									),
									child: Row(
										mainAxisSize: MainAxisSize.min,
										children: [
											const Icon(Icons.diamond_rounded, color: Colors.white, size: 16),
											const SizedBox(width: 6),
											Text('$_gems', style: PremiumTextStyles.labelLarge.copyWith(color: Colors.white)),
										],
									),
								),
							],
						),
					],
				),
			).animate().fadeIn().slide(begin: const Offset(0, -0.2)),
		);
	}

	Widget _buildUserStats() {
		return Container(
			padding: const EdgeInsets.all(24),
			decoration: BoxDecoration(
				gradient: const LinearGradient(colors: PremiumColors.purpleGradient),
				borderRadius: BorderRadius.circular(24),
				boxShadow: PremiumColors.accentShadow(PremiumColors.primaryPurple),
			),
			child: Row(
				children: [
					Container(
						width: 80,
						height: 80,
						decoration: BoxDecoration(
							color: Colors.white.withValues(alpha: 0.2),
							shape: BoxShape.circle,
							border: Border.all(color: Colors.white, width: 3),
						),
						child: const Center(
							child: Icon(Icons.person_rounded, color: Colors.white, size: 40),
						),
					),
					const SizedBox(width: 20),
					Expanded(
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								Row(
									children: [
										Text('Level $_level', style: PremiumTextStyles.h2.copyWith(color: Colors.white)),
										const SizedBox(width: 12),
										Container(
											padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
											decoration: BoxDecoration(
												color: PremiumColors.accentOrange,
												borderRadius: BorderRadius.circular(8),
											),
											child: Text('Pro Player', style: PremiumTextStyles.labelSmall.copyWith(color: Colors.white)),
										),
									],
								),
								const SizedBox(height: 12),
								Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Text(
											'${(_levelProgress * 100).toInt()}% to Level ${_level + 1}',
											style: PremiumTextStyles.caption.copyWith(color: Colors.white.withValues(alpha: 0.9)),
										),
										const SizedBox(height: 8),
										ClipRRect(
											borderRadius: BorderRadius.circular(6),
											child: LinearProgressIndicator(
												value: _levelProgress,
												minHeight: 8,
												backgroundColor: Colors.white.withValues(alpha: 0.3),
												valueColor: const AlwaysStoppedAnimation(Colors.white),
											),
										),
									],
								),
							],
						),
					),
				],
			),
		).animate().fadeIn(delay: 200.ms).scale(begin: const Offset(0.95, 0.95));
	}

	Widget _buildGamesSection() {
		final games = [
			{'icon': Icons.calculate_rounded, 'name': 'Math Master', 'subtitle': 'Solve puzzles', 'gradient': PremiumColors.blueGradient},
			{'icon': Icons.abc_rounded, 'name': 'Word Wizard', 'subtitle': 'Build vocabulary', 'gradient': PremiumColors.tealGradient},
			{'icon': Icons.science_rounded, 'name': 'Science Quest', 'subtitle': 'Explore concepts', 'gradient': PremiumColors.purpleGradient},
			{'icon': Icons.palette_rounded, 'name': 'Creative Canvas', 'subtitle': 'Draw & imagine', 'gradient': PremiumColors.orangeGradient},
			{'icon': Icons.public_rounded, 'name': 'Geography Hero', 'subtitle': 'Explore world', 'gradient': PremiumColors.oceanGradient},
			{'icon': Icons.music_note_rounded, 'name': 'Music Maestro', 'subtitle': 'Learn rhythms', 'gradient': PremiumColors.pinkGradient},
		];
		
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				Row(
					children: [
						Container(
							padding: const EdgeInsets.all(8),
							decoration: BoxDecoration(
								color: PremiumColors.accentOrange.withValues(alpha: 0.1),
								borderRadius: BorderRadius.circular(10),
							),
							child: const Icon(Icons.extension_rounded, color: PremiumColors.accentOrange, size: 20),
						),
						const SizedBox(width: 12),
						Text('Available Games', style: PremiumTextStyles.h4.copyWith(color: PremiumColors.gray900)),
					],
				),
				const SizedBox(height: 16),
				GridView.builder(
					shrinkWrap: true,
					physics: const NeverScrollableScrollPhysics(),
					gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
						crossAxisCount: 2,
						crossAxisSpacing: 16,
						mainAxisSpacing: 16,
						childAspectRatio: 0.95,
					),
					itemCount: games.length,
					itemBuilder: (context, index) {
						final game = games[index];
						final gradient = game['gradient'] as List<Color>;
						
						return Container(
							decoration: BoxDecoration(
								color: PremiumColors.backgroundLight,
								borderRadius: BorderRadius.circular(24),
								boxShadow: PremiumColors.cardShadow,
							),
							child: Material(
								color: Colors.transparent,
								child: InkWell(
									borderRadius: BorderRadius.circular(24),
									onTap: () => _playGame(game['name'] as String),
									child: Padding(
										padding: const EdgeInsets.all(20),
										child: Column(
											mainAxisAlignment: MainAxisAlignment.center,
											children: [
												Container(
													padding: const EdgeInsets.all(18),
													decoration: BoxDecoration(
														gradient: LinearGradient(colors: gradient),
														borderRadius: BorderRadius.circular(20),
														boxShadow: PremiumColors.accentShadow(gradient[0]),
													),
													child: Icon(game['icon'] as IconData, color: Colors.white, size: 32),
												),
												const SizedBox(height: 16),
												Text(
													game['name'] as String,
													style: PremiumTextStyles.h4.copyWith(color: PremiumColors.gray900, fontSize: 16),
													textAlign: TextAlign.center,
												),
												const SizedBox(height: 4),
												Text(
													game['subtitle'] as String,
													style: PremiumTextStyles.caption,
													textAlign: TextAlign.center,
												),
											],
										),
									),
								),
							),
						).animate().fadeIn(delay: Duration(milliseconds: 400 + index * 100)).scale(begin: const Offset(0.9, 0.9));
					},
				),
			],
		);
	}

	Widget _buildChallengesSection() {
		final challenges = [
			{'title': 'Complete 5 Math Games', 'reward': '50', 'progress': 0.6, 'icon': Icons.monetization_on_rounded},
			{'title': 'Study for 30 minutes', 'reward': '100', 'progress': 0.8, 'icon': Icons.monetization_on_rounded},
			{'title': 'Get 3 Perfect Scores', 'reward': '5', 'progress': 0.3, 'icon': Icons.diamond_rounded},
		];
		
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				Row(
					children: [
						Container(
							padding: const EdgeInsets.all(8),
							decoration: BoxDecoration(
								color: PremiumColors.primaryPink.withValues(alpha: 0.1),
								borderRadius: BorderRadius.circular(10),
							),
							child: const Icon(Icons.flag_rounded, color: PremiumColors.primaryPink, size: 20),
						),
						const SizedBox(width: 12),
						Text('Daily Challenges', style: PremiumTextStyles.h4.copyWith(color: PremiumColors.gray900)),
					],
				),
				const SizedBox(height: 16),
				...challenges.asMap().entries.map((entry) {
					final index = entry.key;
					final challenge = entry.value;
					final progress = challenge['progress'] as double;
					
					return Container(
						margin: EdgeInsets.only(bottom: index < challenges.length - 1 ? 12 : 0),
						padding: const EdgeInsets.all(20),
						decoration: BoxDecoration(
							color: PremiumColors.backgroundLight,
							borderRadius: BorderRadius.circular(20),
							boxShadow: PremiumColors.cardShadow,
						),
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								Row(
									children: [
										Expanded(
											child: Text(
												challenge['title'] as String,
												style: PremiumTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600, color: PremiumColors.gray800),
											),
										),
										Container(
											padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
											decoration: BoxDecoration(
												gradient: LinearGradient(colors: [PremiumColors.accentOrange, PremiumColors.accentYellow]),
												borderRadius: BorderRadius.circular(10),
											),
											child: Row(
												mainAxisSize: MainAxisSize.min,
												children: [
													Icon(challenge['icon'] as IconData, color: Colors.white, size: 14),
													const SizedBox(width: 4),
													Text(challenge['reward'] as String, style: PremiumTextStyles.labelMedium.copyWith(color: Colors.white)),
												],
											),
										),
									],
								),
								const SizedBox(height: 12),
								Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Text('${(progress * 100).toInt()}% Complete', style: PremiumTextStyles.caption),
										const SizedBox(height: 6),
										ClipRRect(
											borderRadius: BorderRadius.circular(6),
											child: LinearProgressIndicator(
												value: progress,
												minHeight: 8,
												backgroundColor: PremiumColors.gray200,
												valueColor: const AlwaysStoppedAnimation(PremiumColors.accentOrange),
											),
										),
									],
								),
							],
						),
					).animate().fadeIn(delay: Duration(milliseconds: 1000 + index * 100));
				}),
			],
		);
	}

	Widget _buildLeaderboard() {
		final leaders = [
			{'name': 'You', 'score': '1,250', 'rank': 1, 'icon': Icons.person_rounded},
			{'name': 'Alex', 'score': '1,180', 'rank': 2, 'icon': Icons.person_outline_rounded},
			{'name': 'Sam', 'score': '1,050', 'rank': 3, 'icon': Icons.person_outline_rounded},
			{'name': 'Jordan', 'score': '980', 'rank': 4, 'icon': Icons.person_outline_rounded},
		];
		
		return Container(
			padding: const EdgeInsets.all(24),
			decoration: BoxDecoration(
				color: PremiumColors.backgroundLight,
				borderRadius: BorderRadius.circular(24),
				boxShadow: PremiumColors.cardShadow,
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Row(
						children: [
							Container(
								padding: const EdgeInsets.all(8),
								decoration: BoxDecoration(
									color: PremiumColors.primaryBlue.withValues(alpha: 0.1),
									borderRadius: BorderRadius.circular(10),
								),
								child: const Icon(Icons.leaderboard_rounded, color: PremiumColors.primaryBlue, size: 20),
							),
							const SizedBox(width: 12),
							Text('Leaderboard', style: PremiumTextStyles.h4.copyWith(color: PremiumColors.gray900)),
						],
					),
					const SizedBox(height: 16),
					...leaders.asMap().entries.map((entry) {
						final index = entry.key;
						final leader = entry.value;
						final isUser = leader['name'] == 'You';
						final rank = leader['rank'] as int;
						final rankColor = rank == 1 ? PremiumColors.accentOrange : (rank == 2 ? PremiumColors.gray400 : PremiumColors.accentYellow);
						
						return Container(
							margin: EdgeInsets.only(bottom: index < leaders.length - 1 ? 10 : 0),
							padding: const EdgeInsets.all(16),
							decoration: BoxDecoration(
								color: isUser ? PremiumColors.primaryBlue.withValues(alpha: 0.08) : PremiumColors.gray100,
								borderRadius: BorderRadius.circular(14),
								border: Border.all(color: isUser ? PremiumColors.primaryBlue.withValues(alpha: 0.3) : Colors.transparent, width: 1.5),
							),
							child: Row(
								children: [
									Container(
										width: 28,
										height: 28,
										decoration: BoxDecoration(color: rankColor, shape: BoxShape.circle),
										child: Center(
											child: Text('$rank', style: PremiumTextStyles.labelMedium.copyWith(color: Colors.white)),
										),
									),
									const SizedBox(width: 12),
									Container(
										padding: const EdgeInsets.all(8),
										decoration: BoxDecoration(
											color: isUser ? PremiumColors.primaryBlue.withValues(alpha: 0.1) : PremiumColors.gray200,
											shape: BoxShape.circle,
										),
										child: Icon(leader['icon'] as IconData, size: 20, color: isUser ? PremiumColors.primaryBlue : PremiumColors.gray600),
									),
									const SizedBox(width: 12),
									Expanded(
										child: Text(
											leader['name'] as String,
											style: PremiumTextStyles.bodyMedium.copyWith(
												fontWeight: FontWeight.w600,
												color: isUser ? PremiumColors.primaryBlue : PremiumColors.gray800,
											),
										),
									),
									Row(
										mainAxisSize: MainAxisSize.min,
										children: [
											Text(
												leader['score'] as String,
												style: PremiumTextStyles.h4.copyWith(color: PremiumColors.gray900, fontSize: 16),
											),
											const SizedBox(width: 4),
											const Icon(Icons.monetization_on_rounded, color: PremiumColors.accentOrange, size: 16),
										],
									),
								],
							),
						).animate().fadeIn(delay: Duration(milliseconds: 1400 + index * 100));
					}),
				],
			),
		).animate().fadeIn(delay: 1300.ms).scale(begin: const Offset(0.95, 0.95));
	}

	void _playGame(String gameName) {
		_confettiController.play();
		ScaffoldMessenger.of(context).showSnackBar(
			SnackBar(
				content: Text('$gameName - Coming Soon!', style: PremiumTextStyles.bodyMedium.copyWith(color: Colors.white)),
				backgroundColor: PremiumColors.primaryPurple,
				behavior: SnackBarBehavior.floating,
				shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
				duration: const Duration(seconds: 2),
			),
		);
	}
}
