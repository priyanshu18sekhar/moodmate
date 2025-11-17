import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import '../../state/app_state.dart';
import '../../theme/premium_colors.dart';
import '../../theme/premium_text_styles.dart';

enum AgeGroup { junior, middle, senior }

class RegistrationPage extends StatefulWidget {
	const RegistrationPage({super.key});

	@override
	State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
	final PageController _pageController = PageController();
	final TextEditingController _nameController = TextEditingController();
	late ConfettiController _confettiController;
	
	int _currentPage = 0;
	AgeGroup? _selectedAge;
	String? _selectedAvatar;

	final List<String> _avatars = ['👦', '👧', '🧒', '👶', '🦸', '🦹', '🧙', '🧚', '🐱', '🐶', '🐼', '🐨'];

	@override
	void initState() {
		super.initState();
		_confettiController = ConfettiController(duration: const Duration(seconds: 3));
	}

	@override
	void dispose() {
		_pageController.dispose();
		_nameController.dispose();
		_confettiController.dispose();
		super.dispose();
	}

	void _nextPage() {
		if (_currentPage < 2) {
			_pageController.nextPage(
				duration: const Duration(milliseconds: 400),
				curve: Curves.easeInOut,
			);
		}
	}

	void _previousPage() {
		if (_currentPage > 0) {
			_pageController.previousPage(
				duration: const Duration(milliseconds: 400),
				curve: Curves.easeInOut,
			);
		}
	}

	void _finish() async {
		if (_nameController.text.trim().isEmpty || _selectedAge == null || _selectedAvatar == null) {
			ScaffoldMessenger.of(context).showSnackBar(
				SnackBar(
					content: Text('Please complete all steps', style: PremiumTextStyles.bodyMedium.copyWith(color: Colors.white)),
					backgroundColor: PremiumColors.error,
					behavior: SnackBarBehavior.floating,
					shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
				),
			);
			return;
		}

		_confettiController.play();
		
		final appState = context.read<AppState>();
		final ageValue = _selectedAge == AgeGroup.junior ? 7 : (_selectedAge == AgeGroup.middle ? 11 : 14);
		appState.setProfile(
			name: _nameController.text.trim(),
			age: ageValue,
			avatar: _selectedAvatar!,
		);

		await Future.delayed(const Duration(milliseconds: 1500));
		if (mounted) context.go('/home');
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: PremiumColors.backgroundGray,
			body: Stack(
				children: [
					SafeArea(
						child: Column(
							children: [
								_buildHeader(),
								Expanded(
									child: PageView(
										controller: _pageController,
										physics: const NeverScrollableScrollPhysics(),
										onPageChanged: (index) => setState(() => _currentPage = index),
										children: [
											_buildNameStep(),
											_buildAgeStep(),
											_buildAvatarStep(),
										],
									),
								),
								_buildNavigationButtons(),
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
							numberOfParticles: 30,
							gravity: 0.1,
							shouldLoop: false,
							colors: const [
								PremiumColors.primaryPurple,
								PremiumColors.primaryBlue,
								PremiumColors.primaryPink,
								PremiumColors.accentOrange,
								PremiumColors.accentGreen,
							],
						),
					),
				],
			),
		);
	}

	Widget _buildHeader() {
		return Container(
			padding: const EdgeInsets.all(20),
			decoration: BoxDecoration(
				color: PremiumColors.backgroundLight,
				boxShadow: PremiumColors.cardShadow,
			),
			child: Column(
				children: [
					Row(
						children: [
							Container(
								padding: const EdgeInsets.all(10),
								decoration: BoxDecoration(
									gradient: const LinearGradient(colors: PremiumColors.purpleGradient),
									borderRadius: BorderRadius.circular(12),
									boxShadow: PremiumColors.accentShadow(PremiumColors.primaryPurple),
								),
								child: const Icon(Icons.person_add_rounded, color: Colors.white, size: 24),
							),
							const SizedBox(width: 12),
							Expanded(
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Text('Setup Profile', style: PremiumTextStyles.h4.copyWith(color: PremiumColors.gray900)),
										Text('Step ${_currentPage + 1} of 3', style: PremiumTextStyles.caption),
									],
								),
							),
						],
					),
					const SizedBox(height: 16),
					ClipRRect(
						borderRadius: BorderRadius.circular(8),
						child: LinearProgressIndicator(
							value: (_currentPage + 1) / 3,
							minHeight: 6,
							backgroundColor: PremiumColors.gray200,
							valueColor: const AlwaysStoppedAnimation(PremiumColors.primaryPurple),
						),
					),
				],
			),
		).animate().fadeIn().slide(begin: const Offset(0, -0.2));
	}

	Widget _buildNameStep() {
		return Padding(
			padding: const EdgeInsets.all(24),
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					Container(
						padding: const EdgeInsets.all(24),
						decoration: BoxDecoration(
							gradient: const LinearGradient(colors: PremiumColors.purpleGradient),
							shape: BoxShape.circle,
							boxShadow: PremiumColors.accentShadow(PremiumColors.primaryPurple),
						),
						child: const Icon(Icons.person_outline_rounded, size: 48, color: Colors.white),
					).animate().scale(begin: const Offset(0.5, 0.5), curve: Curves.elasticOut),
					const SizedBox(height: 32),
					Text('What\'s your name?', style: PremiumTextStyles.h2.copyWith(color: PremiumColors.gray900)),
					const SizedBox(height: 12),
					Text('We\'d love to know you better', style: PremiumTextStyles.bodyMedium.copyWith(color: PremiumColors.gray600)),
					const SizedBox(height: 40),
					Container(
						decoration: BoxDecoration(
							color: PremiumColors.backgroundLight,
							borderRadius: BorderRadius.circular(16),
							border: Border.all(color: PremiumColors.gray300),
							boxShadow: PremiumColors.cardShadow,
						),
						child: TextField(
							controller: _nameController,
							style: PremiumTextStyles.bodyLarge,
							decoration: InputDecoration(
								hintText: 'Enter your name',
								hintStyle: PremiumTextStyles.bodyLarge.copyWith(color: PremiumColors.gray400),
								prefixIcon: const Icon(Icons.edit_outlined, color: PremiumColors.primaryPurple),
								border: InputBorder.none,
								contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
							),
						),
					).animate().fadeIn(delay: 300.ms).slide(begin: const Offset(0, 0.2)),
				],
			),
		);
	}

	Widget _buildAgeStep() {
		final ageGroups = [
			{'age': AgeGroup.junior, 'label': 'Junior', 'subtitle': '5-8 years', 'icon': Icons.child_care_rounded, 'gradient': PremiumColors.pinkGradient},
			{'age': AgeGroup.middle, 'label': 'Middle', 'subtitle': '9-12 years', 'icon': Icons.school_rounded, 'gradient': PremiumColors.blueGradient},
			{'age': AgeGroup.senior, 'label': 'Senior', 'subtitle': '13+ years', 'icon': Icons.psychology_rounded, 'gradient': PremiumColors.purpleGradient},
		];

		return Padding(
			padding: const EdgeInsets.all(24),
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					Container(
						padding: const EdgeInsets.all(24),
						decoration: BoxDecoration(
							gradient: const LinearGradient(colors: PremiumColors.blueGradient),
							shape: BoxShape.circle,
							boxShadow: PremiumColors.accentShadow(PremiumColors.primaryBlue),
						),
						child: const Icon(Icons.cake_rounded, size: 48, color: Colors.white),
					).animate().scale(begin: const Offset(0.5, 0.5), curve: Curves.elasticOut),
					const SizedBox(height: 32),
					Text('Select your age group', style: PremiumTextStyles.h2.copyWith(color: PremiumColors.gray900)),
					const SizedBox(height: 12),
					Text('This helps us personalize your experience', style: PremiumTextStyles.bodyMedium.copyWith(color: PremiumColors.gray600)),
					const SizedBox(height: 40),
					...ageGroups.asMap().entries.map((entry) {
						final index = entry.key;
						final group = entry.value;
						final age = group['age'] as AgeGroup;
						final isSelected = _selectedAge == age;
						
						return Padding(
							padding: const EdgeInsets.only(bottom: 16),
							child: AnimatedContainer(
								duration: const Duration(milliseconds: 300),
								decoration: BoxDecoration(
									color: PremiumColors.backgroundLight,
									borderRadius: BorderRadius.circular(20),
									border: Border.all(
										color: isSelected ? PremiumColors.primaryBlue : PremiumColors.gray300,
										width: isSelected ? 2 : 1,
									),
									boxShadow: isSelected ? PremiumColors.accentShadow(PremiumColors.primaryBlue) : PremiumColors.cardShadow,
								),
								child: Material(
									color: Colors.transparent,
									child: InkWell(
										borderRadius: BorderRadius.circular(20),
										onTap: () => setState(() => _selectedAge = age),
										child: Padding(
											padding: const EdgeInsets.all(20),
											child: Row(
												children: [
													Container(
														padding: const EdgeInsets.all(14),
														decoration: BoxDecoration(
															gradient: LinearGradient(colors: group['gradient'] as List<Color>),
															borderRadius: BorderRadius.circular(14),
														),
														child: Icon(group['icon'] as IconData, color: Colors.white, size: 28),
													),
													const SizedBox(width: 16),
													Expanded(
														child: Column(
															crossAxisAlignment: CrossAxisAlignment.start,
															children: [
																Text(
																	group['label'] as String,
																	style: PremiumTextStyles.h4.copyWith(color: PremiumColors.gray900),
																),
																Text(
																	group['subtitle'] as String,
																	style: PremiumTextStyles.bodySmall.copyWith(color: PremiumColors.gray600),
																),
															],
														),
													),
													if (isSelected)
														const Icon(Icons.check_circle_rounded, color: PremiumColors.primaryBlue, size: 28),
												],
											),
										),
									),
								),
							).animate().fadeIn(delay: Duration(milliseconds: 300 + index * 100)).slide(begin: const Offset(0.2, 0)),
						);
					}),
				],
			),
		);
	}

	Widget _buildAvatarStep() {
		return Padding(
			padding: const EdgeInsets.all(24),
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					Container(
						padding: const EdgeInsets.all(24),
						decoration: BoxDecoration(
							gradient: const LinearGradient(colors: PremiumColors.pinkGradient),
							shape: BoxShape.circle,
							boxShadow: PremiumColors.accentShadow(PremiumColors.primaryPink),
						),
						child: const Icon(Icons.face_rounded, size: 48, color: Colors.white),
					).animate().scale(begin: const Offset(0.5, 0.5), curve: Curves.elasticOut),
					const SizedBox(height: 32),
					Text('Choose your avatar', style: PremiumTextStyles.h2.copyWith(color: PremiumColors.gray900)),
					const SizedBox(height: 12),
					Text('Pick one that represents you', style: PremiumTextStyles.bodyMedium.copyWith(color: PremiumColors.gray600)),
					const SizedBox(height: 40),
					GridView.builder(
						shrinkWrap: true,
						physics: const NeverScrollableScrollPhysics(),
						gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
							crossAxisCount: 4,
							crossAxisSpacing: 16,
							mainAxisSpacing: 16,
						),
						itemCount: _avatars.length,
						itemBuilder: (context, index) {
							final avatar = _avatars[index];
							final isSelected = _selectedAvatar == avatar;
							
							return AnimatedContainer(
								duration: const Duration(milliseconds: 300),
								decoration: BoxDecoration(
									color: PremiumColors.backgroundLight,
									borderRadius: BorderRadius.circular(16),
									border: Border.all(
										color: isSelected ? PremiumColors.primaryPink : PremiumColors.gray300,
										width: isSelected ? 2 : 1,
									),
									boxShadow: isSelected ? PremiumColors.accentShadow(PremiumColors.primaryPink) : PremiumColors.cardShadow,
								),
								child: Material(
									color: Colors.transparent,
									child: InkWell(
										borderRadius: BorderRadius.circular(16),
										onTap: () => setState(() => _selectedAvatar = avatar),
										child: Center(
											child: Text(avatar, style: const TextStyle(fontSize: 36)),
										),
									),
								),
							).animate().fadeIn(delay: Duration(milliseconds: 300 + index * 50)).scale(begin: const Offset(0.8, 0.8));
						},
					),
				],
			),
		);
	}

	Widget _buildNavigationButtons() {
		return Container(
			padding: const EdgeInsets.all(20),
			decoration: BoxDecoration(
				color: PremiumColors.backgroundLight,
				boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, -2))],
			),
			child: Row(
				children: [
					if (_currentPage > 0)
						Expanded(
							child: SizedBox(
								height: 52,
								child: OutlinedButton(
									style: OutlinedButton.styleFrom(
										foregroundColor: PremiumColors.gray700,
										side: const BorderSide(color: PremiumColors.gray300, width: 1.5),
										shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
									),
									onPressed: _previousPage,
									child: Text('Back', style: PremiumTextStyles.buttonMedium),
								),
							),
						),
					if (_currentPage > 0) const SizedBox(width: 12),
					Expanded(
						flex: 2,
						child: SizedBox(
							height: 52,
							child: Container(
								decoration: BoxDecoration(
									gradient: const LinearGradient(colors: PremiumColors.purpleGradient),
									borderRadius: BorderRadius.circular(14),
									boxShadow: PremiumColors.accentShadow(PremiumColors.primaryPurple),
								),
								child: Material(
									color: Colors.transparent,
									child: InkWell(
										borderRadius: BorderRadius.circular(14),
										onTap: _currentPage < 2 ? _nextPage : _finish,
										child: Center(
											child: Text(
												_currentPage < 2 ? 'Continue' : 'Finish',
												style: PremiumTextStyles.buttonLarge.copyWith(color: Colors.white),
											),
										),
									),
								),
							),
						),
					),
				],
			),
		);
	}
}
