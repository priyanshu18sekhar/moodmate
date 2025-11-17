import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../state/app_state.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/premium_colors.dart';
import '../../theme/premium_text_styles.dart';

class AppDrawer extends StatelessWidget {
	const AppDrawer({super.key});

	@override
	Widget build(BuildContext context) {
		final app = context.watch<AppState>();
		final name = app.childName ?? 'Friend';
		final avatar = app.avatarAsset ?? '👤';
		final ageGroup = app.ageGroup.name;
		
		return Drawer(
			backgroundColor: PremiumColors.backgroundLight,
			child: SafeArea(
				child: Column(
					children: [
						// Profile Header
						Container(
							padding: const EdgeInsets.all(24),
							decoration: BoxDecoration(
								gradient: PremiumColors.getAgeGradient(ageGroup),
							),
							child: Column(
								children: [
									Container(
										width: 80,
										height: 80,
										decoration: BoxDecoration(
											color: Colors.white,
											shape: BoxShape.circle,
											border: Border.all(color: Colors.white, width: 3),
											boxShadow: PremiumColors.elevatedShadow,
										),
										child: Center(
											child: Text(
												avatar,
												style: const TextStyle(fontSize: 40),
											),
										),
									),
									const SizedBox(height: 16),
									Text(
										name,
										style: PremiumTextStyles.h3.copyWith(color: Colors.white),
									),
									const SizedBox(height: 4),
									Text(
										ageGroup.toUpperCase(),
										style: PremiumTextStyles.labelSmall.copyWith(
											color: Colors.white.withValues(alpha: 0.9),
											letterSpacing: 1.5,
										),
									),
								],
							),
						).animate().fadeIn().scale(begin: const Offset(0.95, 0.95)),
						
						const SizedBox(height: 8),
						
						// Menu Items
						Expanded(
							child: ListView(
								padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
								children: [
									_buildMenuItem(
										context,
										icon: Icons.home_rounded,
										title: 'Home',
										onTap: () {
											Navigator.pop(context);
											context.go('/home');
										},
									),
									_buildMenuItem(
										context,
										icon: Icons.help_outline_rounded,
										title: 'Help & Support',
										onTap: () {
											Navigator.pop(context);
											context.go('/help');
										},
									),
									_buildMenuItem(
										context,
										icon: Icons.info_outline_rounded,
										title: 'About MoodMate',
										onTap: () {
											Navigator.pop(context);
											context.go('/about');
										},
									),
									_buildMenuItem(
										context,
										icon: Icons.settings_outlined,
										title: 'Settings',
										onTap: () {
											Navigator.pop(context);
											context.go('/settings');
										},
									),
									
									const Divider(height: 32),
									
									_buildMenuItem(
										context,
										icon: Icons.logout_rounded,
										title: 'Logout',
										isDestructive: true,
										onTap: () {
											_showLogoutDialog(context);
										},
									),
								],
							),
						),
						
						// App Version
						Padding(
							padding: const EdgeInsets.all(20),
							child: Column(
								children: [
									Row(
										mainAxisAlignment: MainAxisAlignment.center,
										children: [
											Icon(Icons.favorite_rounded, size: 16, color: PremiumColors.primaryPink),
											const SizedBox(width: 6),
											Text(
												'Made for kids',
												style: PremiumTextStyles.caption,
											),
										],
									),
									const SizedBox(height: 8),
									Text(
										'MoodMate v1.0.0',
										style: PremiumTextStyles.caption.copyWith(
											color: PremiumColors.gray400,
										),
									),
								],
							),
						),
					],
				),
			),
		);
	}

	Widget _buildMenuItem(
		BuildContext context, {
		required IconData icon,
		required String title,
		required VoidCallback onTap,
		bool isDestructive = false,
	}) {
		return Padding(
			padding: const EdgeInsets.only(bottom: 8),
			child: Material(
				color: Colors.transparent,
				child: InkWell(
					borderRadius: BorderRadius.circular(14),
					onTap: onTap,
					child: Container(
						padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
						decoration: BoxDecoration(
							color: PremiumColors.gray100,
							borderRadius: BorderRadius.circular(14),
						),
						child: Row(
							children: [
								Container(
									padding: const EdgeInsets.all(8),
									decoration: BoxDecoration(
										color: isDestructive 
											? PremiumColors.error.withValues(alpha: 0.1)
											: PremiumColors.primaryPurple.withValues(alpha: 0.1),
										borderRadius: BorderRadius.circular(10),
									),
									child: Icon(
										icon,
										color: isDestructive ? PremiumColors.error : PremiumColors.primaryPurple,
										size: 20,
									),
								),
								const SizedBox(width: 14),
								Expanded(
									child: Text(
										title,
										style: PremiumTextStyles.bodyMedium.copyWith(
											fontWeight: FontWeight.w600,
											color: isDestructive ? PremiumColors.error : PremiumColors.gray800,
										),
									),
								),
								Icon(
									Icons.chevron_right_rounded,
									color: PremiumColors.gray400,
									size: 20,
								),
							],
						),
					),
				),
			),
		);
	}

	void _showLogoutDialog(BuildContext context) {
		showDialog(
			context: context,
			builder: (BuildContext dialogContext) {
				return AlertDialog(
					backgroundColor: PremiumColors.backgroundLight,
					shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
					title: Row(
						children: [
							Container(
								padding: const EdgeInsets.all(10),
								decoration: BoxDecoration(
									color: PremiumColors.error.withValues(alpha: 0.1),
									borderRadius: BorderRadius.circular(12),
								),
								child: const Icon(Icons.logout_rounded, color: PremiumColors.error, size: 24),
							),
							const SizedBox(width: 12),
							Text('Logout', style: PremiumTextStyles.h4.copyWith(color: PremiumColors.gray900)),
						],
					),
					content: Text(
						'Are you sure you want to logout?',
						style: PremiumTextStyles.bodyMedium.copyWith(color: PremiumColors.gray600),
					),
					actions: [
						TextButton(
							onPressed: () => Navigator.of(dialogContext).pop(),
							child: Text('Cancel', style: PremiumTextStyles.buttonMedium.copyWith(color: PremiumColors.gray600)),
						),
						ElevatedButton(
							style: ElevatedButton.styleFrom(
								backgroundColor: PremiumColors.error,
								foregroundColor: Colors.white,
								elevation: 0,
								shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
								padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
							),
							onPressed: () {
								Navigator.of(dialogContext).pop();
								Navigator.of(context).pop();
								context.read<AppState>().clearProfile();
								context.go('/splash');
							},
							child: Text('Logout', style: PremiumTextStyles.buttonMedium),
						),
					],
				);
			},
		);
	}
}
