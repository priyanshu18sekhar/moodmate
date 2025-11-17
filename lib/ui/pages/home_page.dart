import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/app_state.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/ar_avatar_widget.dart';
import '../widgets/app_drawer.dart';
import '../../theme/premium_colors.dart';
import '../../theme/premium_text_styles.dart';

class HomePage extends StatelessWidget {
	const HomePage({super.key});

	@override
	Widget build(BuildContext context) {
		final app = context.watch<AppState>();
		final name = app.childName ?? 'Friend';
		final scheme = Theme.of(context).colorScheme;
		
		return Scaffold(
			backgroundColor: PremiumColors.backgroundGray,
			drawer: const AppDrawer(),
			body: SafeArea(
				child: CustomScrollView(
					slivers: [
						// Premium App Bar
						_buildPremiumAppBar(context, name, scheme),
						
						// Content
						SliverPadding(
							padding: const EdgeInsets.all(20),
							sliver: SliverList(
								delegate: SliverChildListDelegate([
									// AI Buddy Section
									_buildAIBuddyCard(context, name),
									
									const SizedBox(height: 24),
									
									// Quick Stats
									_buildQuickStats(),
									
									const SizedBox(height: 24),
									
									// Feature Grid
									_buildFeatureGrid(context, scheme),
									
									const SizedBox(height: 24),
									
									// Daily Goals
									_buildDailyGoals(),
									
									const SizedBox(height: 20),
								]),
							),
						),
					],
				),
			),
		);
	}

	Widget _buildPremiumAppBar(BuildContext context, String name, ColorScheme scheme) {
		return SliverAppBar(
			expandedHeight: 100,
			floating: true,
			backgroundColor: PremiumColors.backgroundLight,
			elevation: 0,
			leading: Builder(
				builder: (context) {
					return IconButton(
						icon: Container(
							padding: const EdgeInsets.all(10),
							decoration: BoxDecoration(
								color: PremiumColors.backgroundLight,
								borderRadius: BorderRadius.circular(14),
								boxShadow: PremiumColors.cardShadow,
							),
							child: const Icon(Icons.menu_rounded, color: PremiumColors.primaryPurple, size: 22),
						),
						onPressed: () => Scaffold.of(context).openDrawer(),
					);
				},
			),
			title: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				mainAxisSize: MainAxisSize.min,
				children: [
					Text(
						'Welcome back',
						style: PremiumTextStyles.caption,
					),
					Text(
						name,
						style: PremiumTextStyles.h3.copyWith(color: PremiumColors.gray900),
					),
				],
			),
			actions: [
				IconButton(
					icon: Container(
						padding: const EdgeInsets.all(10),
						decoration: BoxDecoration(
							color: PremiumColors.backgroundLight,
							borderRadius: BorderRadius.circular(14),
							boxShadow: PremiumColors.cardShadow,
						),
						child: const Icon(Icons.notifications_outlined, color: PremiumColors.primaryPurple, size: 22),
					),
					onPressed: () {},
				),
				const SizedBox(width: 12),
			],
		);
	}

	Widget _buildAIBuddyCard(BuildContext context, String name) {
		return Container(
			padding: const EdgeInsets.all(24),
			decoration: BoxDecoration(
				gradient: const LinearGradient(
					colors: PremiumColors.purpleGradient,
					begin: Alignment.topLeft,
					end: Alignment.bottomRight,
				),
				borderRadius: BorderRadius.circular(24),
				boxShadow: PremiumColors.accentShadow(PremiumColors.primaryPurple),
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Row(
						children: [
							Container(
								padding: const EdgeInsets.all(12),
								decoration: BoxDecoration(
									color: Colors.white.withValues(alpha: 0.2),
									borderRadius: BorderRadius.circular(16),
								),
								child: const Icon(Icons.psychology_rounded, color: Colors.white, size: 28),
							),
							const SizedBox(width: 16),
							Expanded(
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Text(
											'Your AI Buddy',
											style: PremiumTextStyles.h3.copyWith(color: Colors.white),
										),
										const SizedBox(height: 4),
										Text(
											'Ready to help you learn',
											style: PremiumTextStyles.bodyMedium.copyWith(
												color: Colors.white.withValues(alpha: 0.9),
											),
										),
									],
								),
							),
						],
					),
					const SizedBox(height: 20),
					ArAvatarWidget(userName: name),
				],
			),
		).animate()
			.fadeIn(delay: 200.ms)
			.scale(begin: const Offset(0.95, 0.95));
	}

	Widget _buildQuickStats() {
		final stats = [
			{'icon': Icons.local_fire_department_rounded, 'value': '7', 'label': 'Day Streak', 'color': PremiumColors.accentOrange},
			{'icon': Icons.star_rounded, 'value': '128', 'label': 'Stars', 'color': PremiumColors.accentYellow},
			{'icon': Icons.emoji_events_rounded, 'value': '12', 'label': 'Badges', 'color': PremiumColors.primaryPink},
		];
		
		return Row(
			children: stats.asMap().entries.map((entry) {
				final index = entry.key;
				final stat = entry.value;
				return Expanded(
					child: Padding(
						padding: EdgeInsets.only(left: index > 0 ? 12 : 0),
						child: Container(
							padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
							decoration: BoxDecoration(
								color: PremiumColors.backgroundLight,
								borderRadius: BorderRadius.circular(20),
								boxShadow: PremiumColors.cardShadow,
							),
							child: Column(
								children: [
									Container(
										padding: const EdgeInsets.all(12),
										decoration: BoxDecoration(
											color: (stat['color'] as Color).withValues(alpha: 0.1),
											borderRadius: BorderRadius.circular(14),
										),
										child: Icon(
											stat['icon'] as IconData,
											color: stat['color'] as Color,
											size: 24,
										),
									),
									const SizedBox(height: 12),
									Text(
										stat['value'] as String,
										style: PremiumTextStyles.h2.copyWith(color: PremiumColors.gray900),
									),
									const SizedBox(height: 4),
									Text(
										stat['label'] as String,
										style: PremiumTextStyles.caption,
										textAlign: TextAlign.center,
									),
								],
							),
						),
					),
				).animate()
					.fadeIn(delay: Duration(milliseconds: 400 + index * 100))
					.scale(begin: const Offset(0.9, 0.9));
			}).toList(),
		);
	}

	Widget _buildFeatureGrid(BuildContext context, ColorScheme scheme) {
		final features = [
			{
				'icon': Icons.school_rounded,
				'title': 'AI Tutor',
				'subtitle': 'Get instant help',
				'gradient': PremiumColors.blueGradient,
				'route': '/tutor',
			},
			{
				'icon': Icons.bar_chart_rounded,
				'title': 'Analytics',
				'subtitle': 'Track progress',
				'gradient': PremiumColors.tealGradient,
				'route': '/analytics',
			},
			{
				'icon': Icons.sentiment_satisfied_alt_rounded,
				'title': 'Emotions',
				'subtitle': 'Understand feelings',
				'gradient': PremiumColors.pinkGradient,
				'route': '/emotion',
			},
			{
				'icon': Icons.videogame_asset_rounded,
				'title': 'Games',
				'subtitle': 'Learn & play',
				'gradient': PremiumColors.orangeGradient,
				'route': '/game',
			},
		];
		
		return GridView.builder(
			shrinkWrap: true,
			physics: const NeverScrollableScrollPhysics(),
			gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
				crossAxisCount: 2,
				crossAxisSpacing: 16,
				mainAxisSpacing: 16,
				childAspectRatio: 1.1,
			),
			itemCount: features.length,
			itemBuilder: (context, index) {
				final feature = features[index];
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
							onTap: () => context.go(feature['route'] as String),
							child: Padding(
								padding: const EdgeInsets.all(20),
								child: Column(
									mainAxisAlignment: MainAxisAlignment.center,
									children: [
										Container(
											padding: const EdgeInsets.all(18),
											decoration: BoxDecoration(
												gradient: LinearGradient(
													colors: feature['gradient'] as List<Color>,
													begin: Alignment.topLeft,
													end: Alignment.bottomRight,
												),
												borderRadius: BorderRadius.circular(20),
												boxShadow: [
													BoxShadow(
														color: (feature['gradient'] as List<Color>)[0].withValues(alpha: 0.3),
														blurRadius: 16,
														offset: const Offset(0, 6),
													),
												],
											),
											child: Icon(
												feature['icon'] as IconData,
												color: Colors.white,
												size: 32,
											),
										),
										const SizedBox(height: 16),
										Text(
											feature['title'] as String,
											style: PremiumTextStyles.h4.copyWith(color: PremiumColors.gray900),
											textAlign: TextAlign.center,
										),
										const SizedBox(height: 4),
										Text(
											feature['subtitle'] as String,
											style: PremiumTextStyles.caption,
											textAlign: TextAlign.center,
										),
									],
								),
							),
						),
					),
				).animate()
					.fadeIn(delay: Duration(milliseconds: 600 + index * 100))
					.scale(begin: const Offset(0.9, 0.9), curve: Curves.easeOut);
			},
		);
	}

	Widget _buildDailyGoals() {
		final goals = [
			{'title': 'Complete 3 lessons', 'progress': 0.67, 'current': 2, 'total': 3},
			{'title': 'Practice for 20 minutes', 'progress': 0.85, 'current': 17, 'total': 20},
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
								padding: const EdgeInsets.all(10),
								decoration: BoxDecoration(
									color: PremiumColors.accentGreen.withValues(alpha: 0.1),
									borderRadius: BorderRadius.circular(12),
								),
								child: const Icon(Icons.flag_rounded, color: PremiumColors.accentGreen, size: 20),
							),
							const SizedBox(width: 12),
							Text(
								'Today\'s Goals',
								style: PremiumTextStyles.h3.copyWith(color: PremiumColors.gray900),
							),
						],
					),
					const SizedBox(height: 20),
					...goals.asMap().entries.map((entry) {
						final index = entry.key;
						final goal = entry.value;
						return Padding(
							padding: EdgeInsets.only(bottom: index < goals.length - 1 ? 16 : 0),
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									Row(
										mainAxisAlignment: MainAxisAlignment.spaceBetween,
										children: [
											Text(
												goal['title'] as String,
												style: PremiumTextStyles.bodyMedium.copyWith(
													fontWeight: FontWeight.w600,
													color: PremiumColors.gray800,
												),
											),
											Text(
												'${goal['current']}/${goal['total']}',
												style: PremiumTextStyles.labelMedium.copyWith(
													color: PremiumColors.gray500,
												),
											),
										],
									),
									const SizedBox(height: 10),
									ClipRRect(
										borderRadius: BorderRadius.circular(8),
										child: LinearProgressIndicator(
											value: goal['progress'] as double,
											minHeight: 8,
											backgroundColor: PremiumColors.gray200,
											valueColor: const AlwaysStoppedAnimation(PremiumColors.accentGreen),
										),
									),
								],
							),
						);
					}),
				],
			),
		).animate()
			.fadeIn(delay: 1000.ms)
			.scale(begin: const Offset(0.95, 0.95));
	}
}
