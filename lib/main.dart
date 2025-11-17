import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_router.dart';
import 'state/app_state.dart';
import 'state/emotion_state.dart';
import 'theme/age_group.dart';
import 'theme/theme.dart';

void main() {
	runApp(const MoodMateApp());
}

class MoodMateApp extends StatelessWidget {
	const MoodMateApp({super.key});

	@override
	Widget build(BuildContext context) {
		return MultiProvider(
			providers: [
				ChangeNotifierProvider(create: (_) => AppState()),
				ChangeNotifierProvider(create: (_) => EmotionState()),
			],
			child: Consumer<AppState>(
				builder: (context, app, _) {
					final group = app.childAge != null ? resolveAgeGroup(app.childAge!) : AgeGroup.junior;
					final router = createRouter(hasProfile: app.childName != null);
					return MaterialApp.router(
						title: 'MoodMate',
						routerConfig: router,
						theme: buildTheme(group),
					);
				},
			),
		);
	}
}
