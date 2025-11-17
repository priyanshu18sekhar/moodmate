import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../theme/premium_colors.dart';
import '../../theme/premium_text_styles.dart';

class ArAvatarWidget extends StatefulWidget {
	final String userName;
	
	const ArAvatarWidget({super.key, required this.userName});

	@override
	State<ArAvatarWidget> createState() => _ArAvatarWidgetState();
}

class _ArAvatarWidgetState extends State<ArAvatarWidget> with TickerProviderStateMixin {
	late AnimationController _floatController;
	late AnimationController _pulseController;
	final FlutterTts _tts = FlutterTts();
	bool _isSpeaking = false;
	int _messageIndex = 0;
	
	final List<Map<String, dynamic>> _greetingMessages = [
		{'text': "Hi! I'm Buddy, your AI learning assistant", 'icon': Icons.waving_hand_rounded},
		{'text': "What would you like to learn today?", 'icon': Icons.lightbulb_outline_rounded},
		{'text': "Tap me to hear something inspiring", 'icon': Icons.volume_up_rounded},
		{'text': "Let's explore and learn together", 'icon': Icons.explore_rounded},
		{'text': "You're doing amazing work", 'icon': Icons.star_rounded},
	];

	@override
	void initState() {
		super.initState();
		_floatController = AnimationController(
			vsync: this,
			duration: const Duration(milliseconds: 2500),
		)..repeat(reverse: true);
		
		_pulseController = AnimationController(
			vsync: this,
			duration: const Duration(milliseconds: 1500),
		)..repeat(reverse: true);
		
		_initTts();
	}

	void _initTts() async {
		await _tts.setLanguage("en-US");
		await _tts.setSpeechRate(0.5);
		await _tts.setPitch(1.1);
	}

	@override
	void dispose() {
		_floatController.dispose();
		_pulseController.dispose();
		_tts.stop();
		super.dispose();
	}

	void _speak() async {
		if (_isSpeaking) return;
		
		setState(() => _isSpeaking = true);
		final message = _greetingMessages[_messageIndex];
		await _tts.speak(message['text'] as String);
		
		await Future.delayed(const Duration(milliseconds: 500));
		setState(() {
			_isSpeaking = false;
			_messageIndex = (_messageIndex + 1) % _greetingMessages.length;
		});
	}

	@override
	Widget build(BuildContext context) {
		final currentMessage = _greetingMessages[_messageIndex];
		
		return GestureDetector(
			onTap: _speak,
			child: Column(
				children: [
					// Floating AI Avatar
					AnimatedBuilder(
						animation: _floatController,
						builder: (context, child) {
							return Transform.translate(
								offset: Offset(0, _floatController.value * 10 - 5),
								child: child,
							);
						},
						child: AnimatedBuilder(
							animation: _pulseController,
							builder: (context, child) {
								return Container(
									width: 100,
									height: 100,
									decoration: BoxDecoration(
										shape: BoxShape.circle,
										gradient: const LinearGradient(
											colors: PremiumColors.purpleGradient,
											begin: Alignment.topLeft,
											end: Alignment.bottomRight,
										),
										boxShadow: [
											BoxShadow(
												color: PremiumColors.primaryPurple.withValues(alpha: 0.3 + _pulseController.value * 0.2),
												blurRadius: 30 + _pulseController.value * 10,
												spreadRadius: 5 + _pulseController.value * 3,
											),
										],
									),
									child: Stack(
										alignment: Alignment.center,
										children: [
											// Background glow
											Container(
												width: 80,
												height: 80,
												decoration: BoxDecoration(
													shape: BoxShape.circle,
													color: Colors.white.withValues(alpha: 0.2),
												),
											),
											// Main icon
											Icon(
												_isSpeaking ? Icons.record_voice_over_rounded : Icons.smart_toy_rounded,
												size: 48,
												color: Colors.white,
											),
										],
									),
								);
							},
						),
					),
					
					const SizedBox(height: 16),
					
					// Message Container
					Container(
						padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
						decoration: BoxDecoration(
							color: Colors.white.withValues(alpha: 0.95),
							borderRadius: BorderRadius.circular(16),
							border: Border.all(
								color: PremiumColors.primaryPurple.withValues(alpha: 0.3),
								width: 1,
							),
						),
						child: Row(
							mainAxisSize: MainAxisSize.min,
							children: [
								Icon(
									currentMessage['icon'] as IconData,
									size: 18,
									color: PremiumColors.primaryPurple,
								),
								const SizedBox(width: 10),
								Flexible(
									child: Text(
										currentMessage['text'] as String,
										style: PremiumTextStyles.bodySmall.copyWith(
											color: PremiumColors.gray800,
											fontWeight: FontWeight.w500,
										),
										textAlign: TextAlign.center,
										maxLines: 2,
										overflow: TextOverflow.ellipsis,
									),
								),
							],
						),
					).animate(key: ValueKey(_messageIndex))
						.fadeIn(duration: 400.ms)
						.scale(begin: const Offset(0.9, 0.9)),
				],
			),
		);
	}
}
