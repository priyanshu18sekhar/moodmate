import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../state/app_state.dart';
import '../../theme/premium_colors.dart';
import '../../theme/premium_text_styles.dart';

class AnalyticsPage extends StatefulWidget {
	const AnalyticsPage({super.key});

	@override
	State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
	int _selectedPeriod = 0; // 0=Week, 1=Month, 2=Year

	@override
	Widget build(BuildContext context) {
		final name = context.watch<AppState>().childName ?? 'Student';
		
		return Scaffold(
			backgroundColor: PremiumColors.backgroundGray,
			body: SafeArea(
				child: CustomScrollView(
					slivers: [
						_buildHeader(name),
						SliverPadding(
							padding: const EdgeInsets.all(20),
							sliver: SliverToBoxAdapter(
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										_buildQuickStats(),
										const SizedBox(height: 24),
										_buildPeriodSelector(),
										const SizedBox(height: 24),
										_buildTimeChart(),
										const SizedBox(height: 24),
										_buildEmotionChart(),
										const SizedBox(height: 24),
										_buildAchievements(),
										const SizedBox(height: 20),
									],
								),
							),
						),
					],
				),
			),
		);
	}

	Widget _buildHeader(String name) {
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
								gradient: const LinearGradient(colors: PremiumColors.tealGradient),
								borderRadius: BorderRadius.circular(16),
								boxShadow: PremiumColors.accentShadow(PremiumColors.primaryTeal),
							),
							child: const Icon(Icons.bar_chart_rounded, color: Colors.white, size: 28),
						),
						const SizedBox(width: 16),
						Expanded(
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									Text('Analytics', style: PremiumTextStyles.h3.copyWith(color: PremiumColors.gray900)),
									Text('$name\'s progress', style: PremiumTextStyles.caption),
								],
							),
						),
					],
				),
			).animate().fadeIn().slide(begin: const Offset(0, -0.2)),
		);
	}

	Widget _buildQuickStats() {
		final stats = [
			{'icon': Icons.schedule_rounded, 'value': '2h 45m', 'label': 'Study Time', 'color': PremiumColors.primaryBlue},
			{'icon': Icons.emoji_events_outlined, 'value': '12', 'label': 'Achievements', 'color': PremiumColors.accentOrange},
			{'icon': Icons.trending_up_rounded, 'value': '85%', 'label': 'Progress', 'color': PremiumColors.accentGreen},
		];
		
		return Row(
			children: stats.asMap().entries.map((entry) {
				final index = entry.key;
				final stat = entry.value;
				return Expanded(
					child: Padding(
						padding: EdgeInsets.only(left: index > 0 ? 12 : 0),
						child: Container(
							padding: const EdgeInsets.all(20),
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
										child: Icon(stat['icon'] as IconData, color: stat['color'] as Color, size: 24),
									),
									const SizedBox(height: 12),
									Text(stat['value'] as String, style: PremiumTextStyles.h2.copyWith(color: PremiumColors.gray900)),
									const SizedBox(height: 4),
									Text(stat['label'] as String, style: PremiumTextStyles.caption, textAlign: TextAlign.center),
								],
							),
						),
					).animate().fadeIn(delay: Duration(milliseconds: 200 + index * 100)).scale(begin: const Offset(0.9, 0.9)),
				);
			}).toList(),
		);
	}

	Widget _buildPeriodSelector() {
		final periods = ['Week', 'Month', 'Year'];
		
		return Container(
			padding: const EdgeInsets.all(6),
			decoration: BoxDecoration(
				color: PremiumColors.gray100,
				borderRadius: BorderRadius.circular(14),
			),
			child: Row(
				children: List.generate(periods.length, (index) {
					final isSelected = _selectedPeriod == index;
					return Expanded(
						child: AnimatedContainer(
							duration: const Duration(milliseconds: 300),
							decoration: BoxDecoration(
								color: isSelected ? PremiumColors.backgroundLight : Colors.transparent,
								borderRadius: BorderRadius.circular(11),
								boxShadow: isSelected ? PremiumColors.cardShadow : null,
							),
							child: Material(
								color: Colors.transparent,
								child: InkWell(
									borderRadius: BorderRadius.circular(11),
									onTap: () => setState(() => _selectedPeriod = index),
									child: Padding(
										padding: const EdgeInsets.symmetric(vertical: 12),
										child: Text(
											periods[index],
											style: PremiumTextStyles.labelMedium.copyWith(
												color: isSelected ? PremiumColors.primaryPurple : PremiumColors.gray600,
											),
											textAlign: TextAlign.center,
										),
									),
								),
							),
						),
					);
				}),
			),
		).animate().fadeIn(delay: 500.ms);
	}

	Widget _buildTimeChart() {
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
								child: const Icon(Icons.show_chart_rounded, color: PremiumColors.primaryBlue, size: 20),
							),
							const SizedBox(width: 12),
							Text('Study Time Trend', style: PremiumTextStyles.h4.copyWith(color: PremiumColors.gray900)),
						],
					),
					const SizedBox(height: 24),
					SizedBox(
						height: 200,
						child: LineChart(
							LineChartData(
								gridData: FlGridData(
									show: true,
									drawVerticalLine: false,
									horizontalInterval: 5,
									getDrawingHorizontalLine: (value) => FlLine(color: PremiumColors.gray200, strokeWidth: 1),
								),
								titlesData: FlTitlesData(
									leftTitles: AxisTitles(
										sideTitles: SideTitles(
											showTitles: true,
											interval: 5,
											getTitlesWidget: (value, meta) => Text('${value.toInt()}m', style: PremiumTextStyles.caption),
											reservedSize: 35,
										),
									),
									bottomTitles: AxisTitles(
										sideTitles: SideTitles(
											showTitles: true,
											getTitlesWidget: (value, meta) {
												final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
												if (value.toInt() >= 0 && value.toInt() < days.length) {
													return Padding(
														padding: const EdgeInsets.only(top: 8),
														child: Text(days[value.toInt()], style: PremiumTextStyles.caption),
													);
												}
												return const SizedBox();
											},
										),
									),
									rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
									topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
								),
								borderData: FlBorderData(show: false),
								lineBarsData: [
									LineChartBarData(
										spots: const [FlSpot(0, 8), FlSpot(1, 12), FlSpot(2, 18), FlSpot(3, 15), FlSpot(4, 22), FlSpot(5, 20), FlSpot(6, 25)],
										isCurved: true,
										gradient: const LinearGradient(colors: PremiumColors.blueGradient),
										barWidth: 4,
										isStrokeCapRound: true,
										dotData: FlDotData(
											show: true,
											getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
												radius: 6,
												color: PremiumColors.backgroundLight,
												strokeWidth: 3,
												strokeColor: PremiumColors.primaryBlue,
											),
										),
										belowBarData: BarAreaData(
											show: true,
											gradient: LinearGradient(
												colors: [
													PremiumColors.primaryBlue.withValues(alpha: 0.2),
													PremiumColors.primaryBlue.withValues(alpha: 0.0),
												],
												begin: Alignment.topCenter,
												end: Alignment.bottomCenter,
											),
										),
									),
								],
							),
						),
					),
				],
			),
		).animate().fadeIn(delay: 700.ms).scale(begin: const Offset(0.95, 0.95));
	}

	Widget _buildEmotionChart() {
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
									color: PremiumColors.primaryPink.withValues(alpha: 0.1),
									borderRadius: BorderRadius.circular(10),
								),
								child: const Icon(Icons.sentiment_satisfied_alt_rounded, color: PremiumColors.primaryPink, size: 20),
							),
							const SizedBox(width: 12),
							Text('Emotion Distribution', style: PremiumTextStyles.h4.copyWith(color: PremiumColors.gray900)),
						],
					),
					const SizedBox(height: 24),
					SizedBox(
						height: 180,
						child: BarChart(
							BarChartData(
								alignment: BarChartAlignment.spaceAround,
								maxY: 100,
								titlesData: FlTitlesData(
									leftTitles: AxisTitles(
										sideTitles: SideTitles(
											showTitles: true,
											interval: 25,
											getTitlesWidget: (value, meta) => Text('${value.toInt()}%', style: PremiumTextStyles.caption),
											reservedSize: 35,
										),
									),
									bottomTitles: AxisTitles(
										sideTitles: SideTitles(
											showTitles: true,
											getTitlesWidget: (value, meta) {
												final labels = ['Happy', 'Calm', 'Sad', 'Surprised', 'Upset'];
												if (value.toInt() >= 0 && value.toInt() < labels.length) {
													return Padding(
														padding: const EdgeInsets.only(top: 8),
														child: Text(labels[value.toInt()], style: PremiumTextStyles.labelSmall),
													);
												}
												return const SizedBox();
											},
										),
									),
									rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
									topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
								),
								gridData: FlGridData(
									show: true,
									drawVerticalLine: false,
									horizontalInterval: 25,
									getDrawingHorizontalLine: (value) => FlLine(color: PremiumColors.gray200, strokeWidth: 1),
								),
								borderData: FlBorderData(show: false),
								barGroups: [
									BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 75, gradient: const LinearGradient(colors: [PremiumColors.accentYellow, PremiumColors.accentOrange]), width: 32, borderRadius: BorderRadius.circular(8))]),
									BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 40, gradient: const LinearGradient(colors: [PremiumColors.accentGreen, PremiumColors.primaryTeal]), width: 32, borderRadius: BorderRadius.circular(8))]),
									BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 20, gradient: const LinearGradient(colors: [PremiumColors.primaryBlue, PremiumColors.accentCyan]), width: 32, borderRadius: BorderRadius.circular(8))]),
									BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 55, gradient: const LinearGradient(colors: [PremiumColors.primaryPurple, Color(0xFF9B7EF7)]), width: 32, borderRadius: BorderRadius.circular(8))]),
									BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 10, gradient: const LinearGradient(colors: [Colors.red, PremiumColors.primaryPink]), width: 32, borderRadius: BorderRadius.circular(8))]),
								],
							),
						),
					),
				],
			),
		).animate().fadeIn(delay: 900.ms).scale(begin: const Offset(0.95, 0.95));
	}

	Widget _buildAchievements() {
		final badges = [
			{'icon': Icons.emoji_events_rounded, 'name': 'First Steps', 'color': PremiumColors.accentOrange},
			{'icon': Icons.star_rounded, 'name': 'Star Learner', 'color': PremiumColors.accentYellow},
			{'icon': Icons.local_fire_department_rounded, 'name': '7 Day Streak', 'color': PremiumColors.error},
			{'icon': Icons.menu_book_rounded, 'name': 'Bookworm', 'color': PremiumColors.primaryBlue},
			{'icon': Icons.flag_rounded, 'name': 'Goal Getter', 'color': PremiumColors.accentGreen},
			{'icon': Icons.diamond_rounded, 'name': 'Diamond Mind', 'color': PremiumColors.accentCyan},
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
							child: const Icon(Icons.workspace_premium_rounded, color: PremiumColors.accentOrange, size: 20),
						),
						const SizedBox(width: 12),
						Text('Achievements', style: PremiumTextStyles.h4.copyWith(color: PremiumColors.gray900)),
					],
				),
				const SizedBox(height: 16),
				GridView.builder(
					shrinkWrap: true,
					physics: const NeverScrollableScrollPhysics(),
					gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
						crossAxisCount: 3,
						crossAxisSpacing: 12,
						mainAxisSpacing: 12,
						childAspectRatio: 1.0,
					),
					itemCount: badges.length,
					itemBuilder: (context, index) {
						final badge = badges[index];
						return Container(
							padding: const EdgeInsets.all(16),
							decoration: BoxDecoration(
								color: PremiumColors.backgroundLight,
								borderRadius: BorderRadius.circular(20),
								boxShadow: PremiumColors.cardShadow,
							),
							child: Column(
								mainAxisAlignment: MainAxisAlignment.center,
								children: [
									Container(
										padding: const EdgeInsets.all(12),
										decoration: BoxDecoration(
											color: (badge['color'] as Color).withValues(alpha: 0.1),
											shape: BoxShape.circle,
										),
										child: Icon(badge['icon'] as IconData, color: badge['color'] as Color, size: 24),
									),
									const SizedBox(height: 10),
									Text(
										badge['name'] as String,
										style: PremiumTextStyles.labelSmall.copyWith(color: PremiumColors.gray700),
										textAlign: TextAlign.center,
										maxLines: 2,
										overflow: TextOverflow.ellipsis,
									),
								],
							),
						).animate().fadeIn(delay: Duration(milliseconds: 1100 + index * 100)).scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOut);
					},
				),
			],
		);
	}
}
