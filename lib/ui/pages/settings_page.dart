import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/app_state.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsPage extends StatefulWidget {
	const SettingsPage({super.key});

	@override
	State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
	bool _soundEnabled = true;
	bool _notificationsEnabled = true;
	bool _animationsEnabled = true;
	double _textSize = 1.0;

	@override
	Widget build(BuildContext context) {
		final scheme = Theme.of(context).colorScheme;
		final app = context.watch<AppState>();

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
							// Custom App Bar
							SliverAppBar(
								expandedHeight: 200,
								floating: false,
								pinned: true,
								backgroundColor: Colors.transparent,
								leading: IconButton(
									icon: Icon(Icons.arrow_back_rounded, color: scheme.primary),
									onPressed: () => context.pop(),
								),
								flexibleSpace: FlexibleSpaceBar(
									title: Text(
										'Settings ⚙️',
										style: GoogleFonts.fredoka(
											fontSize: 28,
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
												'assets/icons/settings_gear.svg',
												width: 100,
												height: 100,
											).animate(onPlay: (controller) => controller.repeat())
												.rotate(duration: 10.seconds, begin: 0, end: 1),
										),
									),
								),
							),
							
							// Content
							SliverPadding(
								padding: const EdgeInsets.all(20),
								sliver: SliverList(
									delegate: SliverChildListDelegate([
										// Profile Section
										_buildSectionTitle('Profile', Icons.person_rounded, scheme),
										const SizedBox(height: 12),
										_buildProfileCard(app, scheme),
										
										const SizedBox(height: 32),
										
										// App Settings
										_buildSectionTitle('App Settings', Icons.tune_rounded, scheme),
										const SizedBox(height: 12),
										_buildSettingCard(
											icon: Icons.volume_up_rounded,
											title: 'Sound Effects',
											subtitle: 'Play sound effects in the app',
											value: _soundEnabled,
											onChanged: (val) => setState(() => _soundEnabled = val),
											scheme: scheme,
											delay: 0,
										),
										
										const SizedBox(height: 12),
										
										_buildSettingCard(
											icon: Icons.notifications_rounded,
											title: 'Notifications',
											subtitle: 'Receive learning reminders',
											value: _notificationsEnabled,
											onChanged: (val) => setState(() => _notificationsEnabled = val),
											scheme: scheme,
											delay: 100,
										),
										
										const SizedBox(height: 12),
										
										_buildSettingCard(
											icon: Icons.animation_rounded,
											title: 'Animations',
											subtitle: 'Enable fun animations',
											value: _animationsEnabled,
											onChanged: (val) => setState(() => _animationsEnabled = val),
											scheme: scheme,
											delay: 200,
										),
										
										const SizedBox(height: 12),
										
										_buildSliderCard(
											icon: Icons.text_fields_rounded,
											title: 'Text Size',
											subtitle: 'Adjust text size for comfort',
											value: _textSize,
											onChanged: (val) => setState(() => _textSize = val),
											scheme: scheme,
										),
										
										const SizedBox(height: 32),
										
										// About & Help
										_buildSectionTitle('Support', Icons.help_rounded, scheme),
										const SizedBox(height: 12),
										_buildActionCard(
											icon: Icons.help_center_rounded,
											title: 'Help Center',
											subtitle: 'Get help and tutorials',
											onTap: () => context.push('/help'),
											scheme: scheme,
											color: Colors.blue,
											delay: 0,
										),
										
										const SizedBox(height: 12),
										
										_buildActionCard(
											icon: Icons.info_rounded,
											title: 'About MoodMate',
											subtitle: 'Learn more about us',
											onTap: () => context.push('/about'),
											scheme: scheme,
											color: Colors.purple,
											delay: 100,
										),
										
										const SizedBox(height: 12),
										
										_buildActionCard(
											icon: Icons.code_rounded,
											title: 'About Developer',
											subtitle: 'Meet the creator',
											onTap: () => _showDeveloperDialog(context, scheme),
											scheme: scheme,
											color: Colors.green,
											delay: 200,
										),
										
										const SizedBox(height: 32),
										
										// Logout
										_buildSectionTitle('Account', Icons.account_circle_rounded, scheme),
										const SizedBox(height: 12),
										_buildLogoutCard(context, app, scheme),
										
										const SizedBox(height: 40),
										
										// Version info
										Center(
											child: Text(
												'MoodMate v1.0.0',
												style: GoogleFonts.comfortaa(
													fontSize: 12,
													color: Colors.grey,
												),
											),
										).animate()
											.fadeIn(delay: 1200.ms),
										
										const SizedBox(height: 20),
									]),
								),
							),
						],
					),
				),
			),
		);
	}

	Widget _buildSectionTitle(String title, IconData icon, ColorScheme scheme) {
		return Row(
			children: [
				Icon(icon, color: scheme.primary, size: 24),
				const SizedBox(width: 8),
				Text(
					title,
					style: GoogleFonts.fredoka(
						fontSize: 22,
						fontWeight: FontWeight.bold,
						color: scheme.onBackground,
					),
				),
			],
		).animate()
			.fadeIn()
			.slide(begin: const Offset(-0.2, 0));
	}

	Widget _buildProfileCard(AppState app, ColorScheme scheme) {
		return Container(
			padding: const EdgeInsets.all(20),
			decoration: BoxDecoration(
				color: Colors.white,
				borderRadius: BorderRadius.circular(20),
				boxShadow: [
					BoxShadow(
						color: scheme.primary.withOpacity(0.2),
						blurRadius: 15,
						offset: const Offset(0, 5),
					),
				],
			),
			child: Row(
				children: [
					Container(
						width: 70,
						height: 70,
						decoration: BoxDecoration(
							color: scheme.primary.withOpacity(0.2),
							shape: BoxShape.circle,
							border: Border.all(color: scheme.primary, width: 3),
						),
						child: Center(
							child: Text(
								app.avatarAsset ?? '😊',
								style: const TextStyle(fontSize: 36),
							),
						),
					),
					const SizedBox(width: 16),
					Expanded(
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								Text(
									app.childName ?? 'User',
									style: GoogleFonts.fredoka(
										fontSize: 24,
										fontWeight: FontWeight.bold,
										color: scheme.onBackground,
									),
								),
								const SizedBox(height: 4),
								Text(
									app.childAge != null ? '${app.childAge} years old' : 'Age not set',
									style: GoogleFonts.comfortaa(
										fontSize: 14,
										color: Colors.black54,
									),
								),
							],
						),
					),
					IconButton(
						onPressed: () {
							context.go('/register');
						},
						icon: Icon(Icons.edit_rounded, color: scheme.primary),
						style: IconButton.styleFrom(
							backgroundColor: scheme.primary.withOpacity(0.1),
						),
					),
				],
			),
		).animate()
			.fadeIn(delay: 200.ms)
			.scale(begin: const Offset(0.9, 0.9));
	}

	Widget _buildSettingCard({
		required IconData icon,
		required String title,
		required String subtitle,
		required bool value,
		required ValueChanged<bool> onChanged,
		required ColorScheme scheme,
		required int delay,
	}) {
		return Container(
			padding: const EdgeInsets.all(16),
			decoration: BoxDecoration(
				color: Colors.white,
				borderRadius: BorderRadius.circular(16),
				boxShadow: [
					BoxShadow(
						color: Colors.grey.withOpacity(0.1),
						blurRadius: 10,
						offset: const Offset(0, 3),
					),
				],
			),
			child: Row(
				children: [
					Container(
						width: 50,
						height: 50,
						decoration: BoxDecoration(
							color: scheme.primary.withOpacity(0.1),
							borderRadius: BorderRadius.circular(12),
						),
						child: Icon(icon, color: scheme.primary, size: 28),
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
									),
								),
								Text(
									subtitle,
									style: GoogleFonts.comfortaa(
										fontSize: 12,
										color: Colors.black54,
									),
								),
							],
						),
					),
					Switch(
						value: value,
						onChanged: onChanged,
						activeColor: scheme.primary,
					),
				],
			),
		).animate()
			.fadeIn(delay: Duration(milliseconds: 400 + delay))
			.slide(begin: const Offset(0.2, 0));
	}

	Widget _buildSliderCard({
		required IconData icon,
		required String title,
		required String subtitle,
		required double value,
		required ValueChanged<double> onChanged,
		required ColorScheme scheme,
	}) {
		return Container(
			padding: const EdgeInsets.all(16),
			decoration: BoxDecoration(
				color: Colors.white,
				borderRadius: BorderRadius.circular(16),
				boxShadow: [
					BoxShadow(
						color: Colors.grey.withOpacity(0.1),
						blurRadius: 10,
						offset: const Offset(0, 3),
					),
				],
			),
			child: Column(
				children: [
					Row(
						children: [
							Container(
								width: 50,
								height: 50,
								decoration: BoxDecoration(
									color: scheme.primary.withOpacity(0.1),
									borderRadius: BorderRadius.circular(12),
								),
								child: Icon(icon, color: scheme.primary, size: 28),
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
											),
										),
										Text(
											subtitle,
											style: GoogleFonts.comfortaa(
												fontSize: 12,
												color: Colors.black54,
											),
										),
									],
								),
							),
						],
					),
					const SizedBox(height: 12),
					SliderTheme(
						data: SliderThemeData(
							activeTrackColor: scheme.primary,
							thumbColor: scheme.primary,
							overlayColor: scheme.primary.withOpacity(0.2),
						),
						child: Slider(
							value: value,
							min: 0.8,
							max: 1.4,
							divisions: 6,
							label: '${(value * 100).toInt()}%',
							onChanged: onChanged,
						),
					),
				],
			),
		).animate()
			.fadeIn(delay: 700.ms)
			.slide(begin: const Offset(0.2, 0));
	}

	Widget _buildActionCard({
		required IconData icon,
		required String title,
		required String subtitle,
		required VoidCallback onTap,
		required ColorScheme scheme,
		required Color color,
		required int delay,
	}) {
		return Container(
			decoration: BoxDecoration(
				color: Colors.white,
				borderRadius: BorderRadius.circular(16),
				boxShadow: [
					BoxShadow(
						color: color.withOpacity(0.2),
						blurRadius: 10,
						offset: const Offset(0, 3),
					),
				],
			),
			child: Material(
				color: Colors.transparent,
				child: InkWell(
					borderRadius: BorderRadius.circular(16),
					onTap: onTap,
					child: Padding(
						padding: const EdgeInsets.all(16),
						child: Row(
							children: [
								Container(
									width: 50,
									height: 50,
									decoration: BoxDecoration(
										color: color.withOpacity(0.1),
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
												),
											),
											Text(
												subtitle,
												style: GoogleFonts.comfortaa(
													fontSize: 12,
													color: Colors.black54,
												),
											),
										],
									),
								),
								Icon(Icons.arrow_forward_ios_rounded, color: color, size: 18),
							],
						),
					),
				),
			),
		).animate()
			.fadeIn(delay: Duration(milliseconds: 800 + delay))
			.slide(begin: const Offset(0.2, 0));
	}

	Widget _buildLogoutCard(BuildContext context, AppState app, ColorScheme scheme) {
		return Container(
			decoration: BoxDecoration(
				color: Colors.white,
				borderRadius: BorderRadius.circular(16),
				boxShadow: [
					BoxShadow(
						color: Colors.red.withOpacity(0.2),
						blurRadius: 10,
						offset: const Offset(0, 3),
					),
				],
			),
			child: Material(
				color: Colors.transparent,
				child: InkWell(
					borderRadius: BorderRadius.circular(16),
					onTap: () => _showLogoutDialog(context, app, scheme),
					child: Padding(
						padding: const EdgeInsets.all(16),
						child: Row(
							children: [
								SvgPicture.asset(
									'assets/icons/logout_door.svg',
									width: 50,
									height: 50,
								),
								const SizedBox(width: 16),
								Expanded(
									child: Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										children: [
											Text(
												'Logout',
												style: GoogleFonts.fredoka(
													fontSize: 16,
													fontWeight: FontWeight.bold,
													color: Colors.red,
												),
											),
											Text(
												'Sign out of your account',
												style: GoogleFonts.comfortaa(
													fontSize: 12,
													color: Colors.black54,
												),
											),
										],
									),
								),
								Icon(Icons.exit_to_app_rounded, color: Colors.red, size: 24),
							],
						),
					),
				),
			),
		).animate()
			.fadeIn(delay: 1100.ms)
			.slide(begin: const Offset(0.2, 0));
	}

	void _showLogoutDialog(BuildContext context, AppState app, ColorScheme scheme) {
		showDialog(
			context: context,
			builder: (context) => AlertDialog(
				shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
				title: Text(
					'Logout?',
					style: GoogleFonts.fredoka(
						fontSize: 24,
						fontWeight: FontWeight.bold,
						color: scheme.primary,
					),
				),
				content: Text(
					'Are you sure you want to logout? You can always come back!',
					style: GoogleFonts.comfortaa(fontSize: 14),
				),
				actions: [
					TextButton(
						onPressed: () => Navigator.pop(context),
						child: Text('Cancel', style: GoogleFonts.comfortaa()),
					),
					ElevatedButton(
						onPressed: () {
							Navigator.pop(context);
							app.setProfile(name: '', age: 0, avatar: '');
							context.go('/login');
						},
						style: ElevatedButton.styleFrom(
							backgroundColor: Colors.red,
							shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
						),
						child: Text(
							'Logout',
							style: GoogleFonts.fredoka(color: Colors.white),
						),
					),
				],
			),
		);
	}

	void _showDeveloperDialog(BuildContext context, ColorScheme scheme) {
		showDialog(
			context: context,
			builder: (context) => AlertDialog(
				shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
				title: Text(
					'About Developer 👨‍💻',
					style: GoogleFonts.fredoka(
						fontSize: 24,
						fontWeight: FontWeight.bold,
						color: scheme.primary,
					),
				),
				content: Column(
					mainAxisSize: MainAxisSize.min,
					children: [
						Container(
							width: 80,
							height: 80,
							decoration: BoxDecoration(
								color: scheme.primary.withOpacity(0.2),
								shape: BoxShape.circle,
							),
							child: Icon(Icons.code_rounded, size: 40, color: scheme.primary),
						),
						const SizedBox(height: 16),
						Text(
							'MoodMate',
							style: GoogleFonts.fredoka(
								fontSize: 20,
								fontWeight: FontWeight.bold,
							),
						),
						const SizedBox(height: 8),
						Text(
							'Developed with ❤️ for kids everywhere',
							style: GoogleFonts.comfortaa(fontSize: 14),
							textAlign: TextAlign.center,
						),
						const SizedBox(height: 16),
						Text(
							'A fun, educational app that helps children learn and understand their emotions through AI-powered interactions.',
							style: GoogleFonts.comfortaa(
								fontSize: 12,
								color: Colors.black54,
							),
							textAlign: TextAlign.center,
						),
					],
				),
				actions: [
					ElevatedButton(
						onPressed: () => Navigator.pop(context),
						style: ElevatedButton.styleFrom(
							backgroundColor: scheme.primary,
							shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
						),
						child: Text(
							'Got it!',
							style: GoogleFonts.fredoka(color: Colors.white),
						),
					),
				],
			),
		);
	}
}

