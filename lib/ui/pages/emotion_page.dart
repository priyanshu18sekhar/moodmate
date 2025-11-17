import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/emotion_state.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/premium_colors.dart';
import '../../theme/premium_text_styles.dart';

class EmotionPage extends StatefulWidget {
	const EmotionPage({super.key});

	@override
	State<EmotionPage> createState() => _EmotionPageState();
}

class _EmotionPageState extends State<EmotionPage> with TickerProviderStateMixin {
	CameraController? _controller;
	List<CameraDescription>? _cameras;
	Timer? _mockTimer;
	late AnimationController _emojiController;

	@override
	void initState() {
		super.initState();
		_emojiController = AnimationController(
			vsync: this,
			duration: const Duration(milliseconds: 500),
		);
		_initCamera();
	}

	Future<void> _initCamera() async {
		try {
			_cameras = await availableCameras();
			if (_cameras == null || _cameras!.isEmpty) return;
			_controller = CameraController(_cameras!.first, ResolutionPreset.medium, enableAudio: false);
			await _controller!.initialize();
			if (mounted) setState(() {});
		} catch (e) {
			// Camera not available
		}
	}

	@override
	void dispose() {
		_mockTimer?.cancel();
		_controller?.dispose();
		_emojiController.dispose();
		super.dispose();
	}

	void _startDetection() {
		final state = context.read<EmotionState>();
		state.start();
		_mockTimer?.cancel();
		_mockTimer = Timer.periodic(const Duration(seconds: 3), (_) {
			final labels = EmotionLabel.values;
			final next = labels[(labels.indexOf(state.current) + 1) % labels.length];
			state.setEmotion(next);
			_emojiController.forward(from: 0);
		});
	}

	void _stopDetection() {
		context.read<EmotionState>().stop();
		_mockTimer?.cancel();
	}

	IconData _icon(EmotionLabel e) {
		switch (e) {
			case EmotionLabel.happy:
				return Icons.sentiment_very_satisfied_rounded;
			case EmotionLabel.sad:
				return Icons.sentiment_very_dissatisfied_rounded;
			case EmotionLabel.neutral:
				return Icons.sentiment_neutral_rounded;
			case EmotionLabel.surprised:
				return Icons.sentiment_satisfied_rounded;
			case EmotionLabel.angry:
				return Icons.sentiment_dissatisfied_rounded;
		}
	}

	String _message(EmotionLabel e) {
		switch (e) {
			case EmotionLabel.happy:
				return 'Feeling happy and positive';
			case EmotionLabel.sad:
				return 'It\'s okay to feel this way';
			case EmotionLabel.neutral:
				return 'Calm and balanced';
			case EmotionLabel.surprised:
				return 'Something unexpected';
			case EmotionLabel.angry:
				return 'Take a moment to breathe';
		}
	}

	Color _color(EmotionLabel e) {
		switch (e) {
			case EmotionLabel.happy:
				return PremiumColors.accentYellow;
			case EmotionLabel.sad:
				return PremiumColors.primaryBlue;
			case EmotionLabel.neutral:
				return PremiumColors.gray500;
			case EmotionLabel.surprised:
				return PremiumColors.primaryPurple;
			case EmotionLabel.angry:
				return PremiumColors.error;
		}
	}

	@override
	Widget build(BuildContext context) {
		final emotion = context.watch<EmotionState>();
		final currentColor = _color(emotion.current);
		
		return Scaffold(
			backgroundColor: PremiumColors.backgroundGray,
			body: SafeArea(
				child: Column(
					children: [
						_buildHeader(currentColor),
						Expanded(child: _buildMainContent(emotion)),
						_buildControlBar(emotion),
					],
				),
			),
		);
	}

	Widget _buildHeader(Color currentColor) {
		return Container(
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
							gradient: LinearGradient(colors: [currentColor, currentColor.withValues(alpha: 0.7)]),
							borderRadius: BorderRadius.circular(16),
							boxShadow: PremiumColors.accentShadow(currentColor),
						),
						child: const Icon(Icons.sentiment_satisfied_alt_rounded, color: Colors.white, size: 28),
					),
					const SizedBox(width: 16),
					Expanded(
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								Text('Emotion Camera', style: PremiumTextStyles.h3.copyWith(color: PremiumColors.gray900)),
								Text('Understand your feelings', style: PremiumTextStyles.caption),
							],
						),
					),
					Container(
						padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
						decoration: BoxDecoration(
							color: PremiumColors.success.withValues(alpha: 0.1),
							borderRadius: BorderRadius.circular(12),
							border: Border.all(color: PremiumColors.success, width: 1.5),
						),
						child: Row(
							mainAxisSize: MainAxisSize.min,
							children: [
								const Icon(Icons.security_rounded, color: PremiumColors.success, size: 16),
								const SizedBox(width: 6),
								Text('Private', style: PremiumTextStyles.labelSmall.copyWith(color: PremiumColors.success)),
							],
						),
					),
				],
			),
		).animate().fadeIn().slide(begin: const Offset(0, -0.2));
	}

	Widget _buildMainContent(EmotionState emotion) {
		return Padding(
			padding: const EdgeInsets.all(20),
			child: Column(
				children: [
					Expanded(flex: 3, child: _buildCameraSection()),
					const SizedBox(height: 20),
					_buildEmotionDisplay(emotion),
				],
			),
		);
	}

	Widget _buildCameraSection() {
		return Container(
			decoration: BoxDecoration(
				color: Colors.black,
				borderRadius: BorderRadius.circular(24),
				boxShadow: PremiumColors.elevatedShadow,
			),
			child: ClipRRect(
				borderRadius: BorderRadius.circular(24),
				child: Stack(
					children: [
						if (_controller?.value.isInitialized == true)
							SizedBox.expand(
								child: FittedBox(
									fit: BoxFit.cover,
									child: SizedBox(
										width: _controller!.value.previewSize!.height,
										height: _controller!.value.previewSize!.width,
										child: CameraPreview(_controller!),
									),
								),
							)
						else
							Center(
								child: Column(
									mainAxisSize: MainAxisSize.min,
									children: [
										Icon(Icons.camera_alt_outlined, size: 64, color: Colors.white.withValues(alpha: 0.5)),
										const SizedBox(height: 16),
										Text('Initializing camera...', style: PremiumTextStyles.bodyMedium.copyWith(color: Colors.white.withValues(alpha: 0.8))),
									],
								),
							),
						Positioned.fill(child: CustomPaint(painter: FaceMeshPainter())),
					],
				),
			),
		).animate().fadeIn(delay: 200.ms).scale(begin: const Offset(0.95, 0.95));
	}

	Widget _buildEmotionDisplay(EmotionState emotion) {
		return Container(
			padding: const EdgeInsets.all(24),
			decoration: BoxDecoration(
				color: PremiumColors.backgroundLight,
				borderRadius: BorderRadius.circular(24),
				boxShadow: PremiumColors.cardShadow,
			),
			child: Row(
				children: [
					AnimatedBuilder(
						animation: _emojiController,
						builder: (context, child) {
							return Transform.scale(
								scale: 1.0 + (_emojiController.value * 0.15),
								child: Container(
									width: 90,
									height: 90,
									decoration: BoxDecoration(
										color: _color(emotion.current).withValues(alpha: 0.1),
										shape: BoxShape.circle,
										boxShadow: [
											BoxShadow(
												color: _color(emotion.current).withValues(alpha: 0.2),
												blurRadius: 20,
												spreadRadius: 2,
											),
										],
									),
									child: Center(
										child: Icon(_icon(emotion.current), size: 48, color: _color(emotion.current)),
									),
								),
							);
						},
					),
					const SizedBox(width: 24),
					Expanded(
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								Text(
									emotion.current.name.toUpperCase(),
									style: PremiumTextStyles.h3.copyWith(color: _color(emotion.current)),
								),
								const SizedBox(height: 6),
								Text(_message(emotion.current), style: PremiumTextStyles.bodyMedium.copyWith(color: PremiumColors.gray600)),
							],
						),
					),
					Column(
						mainAxisSize: MainAxisSize.min,
						children: EmotionLabel.values.map((label) {
							final isActive = label == emotion.current;
							return Padding(
								padding: const EdgeInsets.symmetric(vertical: 3),
								child: Container(
									width: 36,
									height: 36,
									decoration: BoxDecoration(
										color: isActive ? _color(label).withValues(alpha: 0.15) : PremiumColors.gray100,
										shape: BoxShape.circle,
										border: Border.all(
											color: isActive ? _color(label) : PremiumColors.gray300,
											width: 1.5,
										),
									),
									child: Center(
										child: Icon(
											_icon(label),
											size: 18,
											color: isActive ? _color(label) : PremiumColors.gray400,
										),
									),
								).animate(target: isActive ? 1 : 0).scale(begin: const Offset(1.0, 1.0), end: const Offset(1.15, 1.15)),
							);
						}).toList(),
					),
				],
			),
		).animate().fadeIn(delay: 400.ms);
	}

	Widget _buildControlBar(EmotionState emotion) {
		final isDetecting = emotion.isDetecting;
		
		return Container(
			padding: const EdgeInsets.all(20),
			decoration: BoxDecoration(
				color: PremiumColors.backgroundLight,
				boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, -2))],
			),
			child: Row(
				children: [
					Expanded(
						child: Container(
							padding: const EdgeInsets.all(16),
							decoration: BoxDecoration(
								gradient: LinearGradient(colors: [PremiumColors.info.withValues(alpha: 0.1), PremiumColors.primaryPurple.withValues(alpha: 0.1)]),
								borderRadius: BorderRadius.circular(16),
								border: Border.all(color: PremiumColors.info.withValues(alpha: 0.3)),
							),
							child: Row(
								children: [
									const Icon(Icons.privacy_tip_outlined, color: PremiumColors.info, size: 24),
									const SizedBox(width: 12),
									Expanded(
										child: Text(
											'All detection runs on device. Fully private.',
											style: PremiumTextStyles.bodySmall.copyWith(color: PremiumColors.gray700, fontWeight: FontWeight.w600),
										),
									),
								],
							),
						),
					),
					const SizedBox(width: 16),
					if (!isDetecting)
						Container(
							height: 56,
							decoration: BoxDecoration(
								gradient: const LinearGradient(colors: [PremiumColors.accentGreen, PremiumColors.primaryTeal]),
								borderRadius: BorderRadius.circular(16),
								boxShadow: PremiumColors.accentShadow(PremiumColors.accentGreen),
							),
							child: Material(
								color: Colors.transparent,
								child: InkWell(
									borderRadius: BorderRadius.circular(16),
									onTap: _startDetection,
									child: Padding(
										padding: const EdgeInsets.symmetric(horizontal: 28),
										child: Row(
											mainAxisSize: MainAxisSize.min,
											children: [
												const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 28),
												const SizedBox(width: 10),
												Text('Start Detection', style: PremiumTextStyles.buttonLarge.copyWith(color: Colors.white)),
											],
										),
									),
								),
							),
						)
					else
						Container(
							height: 56,
							decoration: BoxDecoration(
								color: PremiumColors.error,
								borderRadius: BorderRadius.circular(16),
								boxShadow: PremiumColors.accentShadow(PremiumColors.error),
							),
							child: Material(
								color: Colors.transparent,
								child: InkWell(
									borderRadius: BorderRadius.circular(16),
									onTap: _stopDetection,
									child: Padding(
										padding: const EdgeInsets.symmetric(horizontal: 28),
										child: Row(
											mainAxisSize: MainAxisSize.min,
											children: [
												const Icon(Icons.stop_rounded, color: Colors.white, size: 28),
												const SizedBox(width: 10),
												Text('Stop', style: PremiumTextStyles.buttonLarge.copyWith(color: Colors.white)),
											],
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

class FaceMeshPainter extends CustomPainter {
	@override
	void paint(Canvas canvas, Size size) {
		final paint = Paint()
			..color = PremiumColors.accentGreen.withValues(alpha: 0.3)
			..strokeWidth = 2
			..style = PaintingStyle.stroke;
		
		final center = Offset(size.width / 2, size.height / 2);
		final radius = size.width * 0.3;
		canvas.drawCircle(center, radius, paint);
		
		final cornerPaint = Paint()
			..color = PremiumColors.accentGreen
			..strokeWidth = 3
			..style = PaintingStyle.stroke;
		
		const cornerSize = 30.0;
		canvas.drawLine(const Offset(20, 20), const Offset(20 + cornerSize, 20), cornerPaint);
		canvas.drawLine(const Offset(20, 20), const Offset(20, 20 + cornerSize), cornerPaint);
		canvas.drawLine(Offset(size.width - 20, 20), Offset(size.width - 20 - cornerSize, 20), cornerPaint);
		canvas.drawLine(Offset(size.width - 20, 20), Offset(size.width - 20, 20 + cornerSize), cornerPaint);
		canvas.drawLine(Offset(20, size.height - 20), Offset(20 + cornerSize, size.height - 20), cornerPaint);
		canvas.drawLine(Offset(20, size.height - 20), Offset(20, size.height - 20 - cornerSize), cornerPaint);
		canvas.drawLine(Offset(size.width - 20, size.height - 20), Offset(size.width - 20 - cornerSize, size.height - 20), cornerPaint);
		canvas.drawLine(Offset(size.width - 20, size.height - 20), Offset(size.width - 20, size.height - 20 - cornerSize), cornerPaint);
	}

	@override
	bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
