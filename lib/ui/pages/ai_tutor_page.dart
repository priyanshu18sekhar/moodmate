import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import '../../state/app_state.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/premium_colors.dart';
import '../../theme/premium_text_styles.dart';

enum QuestionType { mcq, shortQ, longQ }

class AiTutorPage extends StatefulWidget {
	const AiTutorPage({super.key});

	@override
	State<AiTutorPage> createState() => _AiTutorPageState();
}

class _AiTutorPageState extends State<AiTutorPage> with TickerProviderStateMixin {
	late AnimationController _pulseController;
	final List<String> _pdfs = [];
	final TextEditingController _promptCtrl = TextEditingController();
	final List<Map<String, String>> _conversation = [];
	QuestionType _qType = QuestionType.shortQ;
	bool _voiceMode = false;
	bool _isThinking = false;
	final FlutterTts _tts = FlutterTts();

	@override
	void initState() {
		super.initState();
		_pulseController = AnimationController(
			vsync: this,
			duration: const Duration(milliseconds: 1500),
		)..repeat(reverse: true);
		_initTts();
	}

	void _initTts() async {
		await _tts.setLanguage("en-US");
		await _tts.setSpeechRate(0.5);
		await _tts.setPitch(1.2);
	}

	@override
	void dispose() {
		_promptCtrl.dispose();
		_pulseController.dispose();
		_tts.stop();
		super.dispose();
	}

	Future<void> _pickPdf() async {
		final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
		if (result != null && result.files.isNotEmpty) {
			setState(() {
				_pdfs.add(result.files.first.name);
			});
			if (mounted) {
				ScaffoldMessenger.of(context).showSnackBar(
					SnackBar(
						content: Text('Document uploaded successfully', style: PremiumTextStyles.bodyMedium.copyWith(color: Colors.white)),
						backgroundColor: PremiumColors.success,
						behavior: SnackBarBehavior.floating,
						shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
					),
				);
			}
		}
	}

	Future<void> _speak(String text) async {
		await _tts.speak(text);
	}

	void _ask() async {
		final text = _promptCtrl.text.trim();
		if (text.isEmpty) return;
		
		setState(() {
			_conversation.add({'role': 'user', 'message': text});
			_isThinking = true;
		});
		_promptCtrl.clear();
		
		await Future.delayed(const Duration(milliseconds: 1500));
		
		final answer = switch (_qType) {
			QuestionType.mcq => 'Here are the options:\nA) First choice\nB) Second choice\nC) Third choice\nD) Fourth choice',
			QuestionType.shortQ => 'Here\'s a concise answer: ${text.contains('what') ? 'This is a fundamental concept' : 'Let me explain'}',
			QuestionType.longQ => 'Detailed explanation:\n\n1. Understanding the basics\n2. Applying the concept\n3. Practice examples\n\nWould you like more details?',
		};
		
		setState(() {
			_conversation.add({'role': 'ai', 'message': answer});
			_isThinking = false;
		});
		
		if (_voiceMode) _speak(answer);
	}

	@override
	Widget build(BuildContext context) {
		final name = context.watch<AppState>().childName ?? 'Student';
		
		return Scaffold(
			backgroundColor: PremiumColors.backgroundGray,
			body: SafeArea(
				child: Column(
					children: [
						_buildHeader(name),
						_buildQuestionTypeTabs(),
						Expanded(child: _buildMainContent()),
						_buildInputArea(),
					],
				),
			),
		);
	}

	Widget _buildHeader(String name) {
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
							gradient: const LinearGradient(colors: PremiumColors.purpleGradient),
							borderRadius: BorderRadius.circular(16),
							boxShadow: PremiumColors.accentShadow(PremiumColors.primaryPurple),
						),
						child: const Icon(Icons.school_rounded, color: Colors.white, size: 28),
					),
					const SizedBox(width: 16),
					Expanded(
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								Text('AI Tutor', style: PremiumTextStyles.h3.copyWith(color: PremiumColors.gray900)),
								Text('Ask anything, $name', style: PremiumTextStyles.caption),
							],
						),
					),
					Container(
						padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
						decoration: BoxDecoration(
							color: _voiceMode ? PremiumColors.primaryPurple.withValues(alpha: 0.1) : PremiumColors.gray100,
							borderRadius: BorderRadius.circular(12),
							border: Border.all(
								color: _voiceMode ? PremiumColors.primaryPurple : PremiumColors.gray300,
								width: 1.5,
							),
						),
						child: Row(
							mainAxisSize: MainAxisSize.min,
							children: [
								Icon(
									_voiceMode ? Icons.volume_up_rounded : Icons.volume_off_rounded,
									color: _voiceMode ? PremiumColors.primaryPurple : PremiumColors.gray500,
									size: 18,
								),
								const SizedBox(width: 8),
								Text(
									'Voice',
									style: PremiumTextStyles.labelSmall.copyWith(
										color: _voiceMode ? PremiumColors.primaryPurple : PremiumColors.gray500,
									),
								),
								const SizedBox(width: 6),
								SizedBox(
									width: 36,
									height: 20,
									child: Switch(
										value: _voiceMode,
										onChanged: (v) => setState(() => _voiceMode = v),
										activeTrackColor: PremiumColors.primaryPurple,
										materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
									),
								),
							],
						),
					),
				],
			),
		).animate().fadeIn().slide(begin: const Offset(0, -0.2));
	}

	Widget _buildQuestionTypeTabs() {
		final types = [
			{'type': QuestionType.mcq, 'icon': Icons.checklist_rounded, 'label': 'Multiple Choice', 'color': PremiumColors.primaryPurple},
			{'type': QuestionType.shortQ, 'icon': Icons.chat_bubble_outline_rounded, 'label': 'Quick Answer', 'color': PremiumColors.primaryBlue},
			{'type': QuestionType.longQ, 'icon': Icons.description_outlined, 'label': 'Detailed', 'color': PremiumColors.accentOrange},
		];
		
		return Container(
			padding: const EdgeInsets.all(16),
			decoration: BoxDecoration(
				color: PremiumColors.backgroundLight,
				border: Border(bottom: BorderSide(color: PremiumColors.gray200, width: 1)),
			),
			child: Row(
				children: types.map((item) {
					final type = item['type'] as QuestionType;
					final icon = item['icon'] as IconData;
					final label = item['label'] as String;
					final color = item['color'] as Color;
					final isSelected = _qType == type;
					
					return Expanded(
						child: Padding(
							padding: const EdgeInsets.symmetric(horizontal: 4),
							child: AnimatedContainer(
								duration: const Duration(milliseconds: 300),
								decoration: BoxDecoration(
									gradient: isSelected ? LinearGradient(colors: [color, color.withValues(alpha: 0.8)]) : null,
									color: isSelected ? null : PremiumColors.gray100,
									borderRadius: BorderRadius.circular(14),
									boxShadow: isSelected ? PremiumColors.accentShadow(color) : null,
								),
								child: Material(
									color: Colors.transparent,
									child: InkWell(
										borderRadius: BorderRadius.circular(14),
										onTap: () => setState(() => _qType = type),
										child: Padding(
											padding: const EdgeInsets.symmetric(vertical: 14),
											child: Column(
												mainAxisSize: MainAxisSize.min,
												children: [
													Icon(icon, color: isSelected ? Colors.white : color, size: 24),
													const SizedBox(height: 6),
													Text(
														label,
														style: PremiumTextStyles.labelSmall.copyWith(
															color: isSelected ? Colors.white : PremiumColors.gray600,
														),
														textAlign: TextAlign.center,
													),
												],
											),
										),
									),
								),
							),
						),
					);
				}).toList(),
			),
		).animate().fadeIn(delay: 200.ms);
	}

	Widget _buildMainContent() {
		return Padding(
			padding: const EdgeInsets.all(20),
			child: Row(
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: [
					Expanded(flex: 2, child: _buildChatPanel()),
					const SizedBox(width: 20),
					SizedBox(width: 280, child: _buildPdfPanel()),
				],
			),
		);
	}

	Widget _buildChatPanel() {
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
								child: const Icon(Icons.chat_rounded, color: PremiumColors.primaryBlue, size: 20),
							),
							const SizedBox(width: 12),
							Text('Conversation', style: PremiumTextStyles.h4.copyWith(color: PremiumColors.gray900)),
						],
					),
					const SizedBox(height: 20),
					Expanded(
						child: _conversation.isEmpty
							? Center(
									child: Column(
										mainAxisSize: MainAxisSize.min,
										children: [
											Container(
												padding: const EdgeInsets.all(24),
												decoration: BoxDecoration(
													color: PremiumColors.gray100,
													shape: BoxShape.circle,
												),
												child: Icon(
													Icons.psychology_outlined,
													size: 48,
													color: PremiumColors.gray400,
												),
											),
											const SizedBox(height: 20),
											Text('Start a conversation', style: PremiumTextStyles.h4.copyWith(color: PremiumColors.gray700)),
											const SizedBox(height: 8),
											Text('Upload a document and ask', style: PremiumTextStyles.caption),
										],
									),
								)
							: ListView.builder(
									itemCount: _conversation.length + (_isThinking ? 1 : 0),
									itemBuilder: (context, i) {
										if (_isThinking && i == _conversation.length) {
											return _buildThinkingBubble();
										}
										
										final msg = _conversation[i];
										final isUser = msg['role'] == 'user';
										
										return Align(
											alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
											child: Container(
												margin: const EdgeInsets.only(bottom: 12),
												padding: const EdgeInsets.all(16),
												constraints: const BoxConstraints(maxWidth: 500),
												decoration: BoxDecoration(
													color: isUser ? PremiumColors.primaryPurple.withValues(alpha: 0.1) : PremiumColors.gray100,
													borderRadius: BorderRadius.circular(16),
												),
												child: Column(
													crossAxisAlignment: CrossAxisAlignment.start,
													children: [
														Row(
															children: [
																Container(
																	padding: const EdgeInsets.all(6),
																	decoration: BoxDecoration(
																		color: isUser ? PremiumColors.primaryPurple : PremiumColors.primaryBlue,
																		shape: BoxShape.circle,
																	),
																	child: Icon(
																		isUser ? Icons.person_outline_rounded : Icons.smart_toy_outlined,
																		color: Colors.white,
																		size: 14,
																	),
																),
																const SizedBox(width: 8),
																Text(
																	isUser ? 'You' : 'AI Tutor',
																	style: PremiumTextStyles.labelMedium.copyWith(
																		color: isUser ? PremiumColors.primaryPurple : PremiumColors.primaryBlue,
																	),
																),
															],
														),
														const SizedBox(height: 10),
														Text(
															msg['message']!,
															style: PremiumTextStyles.bodyMedium.copyWith(
																color: PremiumColors.gray800,
																height: 1.5,
															),
														),
														if (!isUser)
															Padding(
																padding: const EdgeInsets.only(top: 10),
																child: IconButton(
																	icon: const Icon(Icons.volume_up_outlined, size: 16, color: PremiumColors.primaryBlue),
																	onPressed: () => _speak(msg['message']!),
																	padding: EdgeInsets.zero,
																	constraints: const BoxConstraints(),
																	tooltip: 'Read aloud',
																),
															),
													],
												),
											).animate().fadeIn(delay: Duration(milliseconds: i * 50)),
										);
									},
								),
					),
				],
			),
		).animate().fadeIn(delay: 400.ms);
	}

	Widget _buildThinkingBubble() {
		return Align(
			alignment: Alignment.centerLeft,
			child: Container(
				margin: const EdgeInsets.only(bottom: 12),
				padding: const EdgeInsets.all(16),
				decoration: BoxDecoration(
					color: PremiumColors.gray100,
					borderRadius: BorderRadius.circular(16),
				),
				child: Row(
					mainAxisSize: MainAxisSize.min,
					children: [
						SizedBox(
							width: 16,
							height: 16,
							child: CircularProgressIndicator(
								strokeWidth: 2,
								valueColor: const AlwaysStoppedAnimation(PremiumColors.primaryBlue),
							),
						),
						const SizedBox(width: 12),
						Text('Thinking...', style: PremiumTextStyles.bodySmall.copyWith(color: PremiumColors.gray600)),
					],
				),
			),
		).animate(onPlay: (controller) => controller.repeat()).fadeIn().fadeOut(delay: 500.ms, duration: 500.ms);
	}

	Widget _buildPdfPanel() {
		return Container(
			padding: const EdgeInsets.all(20),
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
									color: PremiumColors.primaryPurple.withValues(alpha: 0.1),
									borderRadius: BorderRadius.circular(10),
								),
								child: const Icon(Icons.folder_outlined, color: PremiumColors.primaryPurple, size: 20),
							),
							const SizedBox(width: 12),
							Expanded(
								child: Text('Documents', style: PremiumTextStyles.h4.copyWith(color: PremiumColors.gray900)),
							),
						],
					),
					const SizedBox(height: 16),
					Container(
						decoration: BoxDecoration(
							gradient: const LinearGradient(colors: PremiumColors.purpleGradient),
							borderRadius: BorderRadius.circular(14),
							boxShadow: PremiumColors.accentShadow(PremiumColors.primaryPurple),
						),
						child: Material(
							color: Colors.transparent,
							child: InkWell(
								borderRadius: BorderRadius.circular(14),
								onTap: _pickPdf,
								child: Padding(
									padding: const EdgeInsets.all(14),
									child: Row(
										mainAxisAlignment: MainAxisAlignment.center,
										children: [
											const Icon(Icons.upload_file_rounded, color: Colors.white, size: 20),
											const SizedBox(width: 10),
											Text('Upload PDF', style: PremiumTextStyles.buttonMedium.copyWith(color: Colors.white)),
										],
									),
								),
							),
						),
					),
					const SizedBox(height: 20),
					Expanded(
						child: _pdfs.isEmpty
							? Center(
									child: Column(
										mainAxisSize: MainAxisSize.min,
										children: [
											Icon(Icons.folder_open_outlined, size: 48, color: PremiumColors.gray300),
											const SizedBox(height: 12),
											Text('No documents', style: PremiumTextStyles.bodyMedium.copyWith(color: PremiumColors.gray500)),
											const SizedBox(height: 6),
											Text('Upload to start', style: PremiumTextStyles.caption),
										],
									),
								)
							: ListView.separated(
									itemCount: _pdfs.length,
									separatorBuilder: (_, __) => const SizedBox(height: 10),
									itemBuilder: (context, i) {
										return Container(
											padding: const EdgeInsets.all(12),
											decoration: BoxDecoration(
												color: PremiumColors.gray100,
												borderRadius: BorderRadius.circular(12),
											),
											child: Row(
												children: [
													Container(
														padding: const EdgeInsets.all(8),
														decoration: BoxDecoration(
															color: PremiumColors.primaryPurple.withValues(alpha: 0.1),
															borderRadius: BorderRadius.circular(8),
														),
														child: const Icon(Icons.picture_as_pdf_outlined, color: PremiumColors.primaryPurple, size: 18),
													),
													const SizedBox(width: 12),
													Expanded(
														child: Text(
															_pdfs[i],
															style: PremiumTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600),
															maxLines: 1,
															overflow: TextOverflow.ellipsis,
														),
													),
													IconButton(
														icon: const Icon(Icons.close_rounded, size: 18),
														color: PremiumColors.gray500,
														onPressed: () => setState(() => _pdfs.removeAt(i)),
														padding: EdgeInsets.zero,
														constraints: const BoxConstraints(),
													),
												],
											),
										).animate().fadeIn(delay: Duration(milliseconds: i * 100));
									},
								),
					),
				],
			),
		).animate().fadeIn(delay: 600.ms);
	}

	Widget _buildInputArea() {
		return Container(
			padding: const EdgeInsets.all(20),
			decoration: BoxDecoration(
				color: PremiumColors.backgroundLight,
				boxShadow: [
					BoxShadow(
						color: Colors.black.withValues(alpha: 0.04),
						blurRadius: 8,
						offset: const Offset(0, -2),
					),
				],
			),
			child: Row(
				children: [
					Expanded(
						child: Container(
							padding: const EdgeInsets.symmetric(horizontal: 20),
							decoration: BoxDecoration(
								color: PremiumColors.gray100,
								borderRadius: BorderRadius.circular(16),
							),
							child: TextField(
								controller: _promptCtrl,
								style: PremiumTextStyles.bodyMedium,
								decoration: InputDecoration(
									hintText: 'Ask your question...',
									hintStyle: PremiumTextStyles.bodyMedium.copyWith(color: PremiumColors.gray400),
									border: InputBorder.none,
									icon: const Icon(Icons.edit_outlined, color: PremiumColors.primaryPurple, size: 20),
								),
								maxLines: null,
								onSubmitted: (_) => _ask(),
							),
						),
					),
					const SizedBox(width: 12),
					Container(
						width: 52,
						height: 52,
						decoration: BoxDecoration(
							gradient: const LinearGradient(colors: PremiumColors.purpleGradient),
							shape: BoxShape.circle,
							boxShadow: PremiumColors.accentShadow(PremiumColors.primaryPurple),
						),
						child: Material(
							color: Colors.transparent,
							child: InkWell(
								borderRadius: BorderRadius.circular(26),
								onTap: _ask,
								child: const Icon(Icons.send_rounded, color: Colors.white, size: 22),
							),
						),
					),
				],
			),
		);
	}
}
