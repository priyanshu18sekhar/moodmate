import 'package:go_router/go_router.dart';
import 'stateful_shell.dart';
import 'ui/pages/splash_page.dart';
import 'ui/pages/login_page.dart';
import 'ui/pages/registration_page.dart';
import 'ui/pages/home_page.dart';
import 'ui/pages/ai_tutor_page.dart';
import 'ui/pages/emotion_page.dart';
import 'ui/pages/analytics_page.dart';
import 'ui/pages/gamification_page.dart';
import 'ui/pages/help_page.dart';
import 'ui/pages/about_page.dart';
import 'ui/pages/settings_page.dart';

GoRouter createRouter({required bool hasProfile}) {
	return GoRouter(
		initialLocation: hasProfile ? '/home' : '/splash',
		routes: [
			GoRoute(
				path: '/splash',
				name: 'splash',
				builder: (context, state) => const SplashPage(),
			),
			GoRoute(
				path: '/login',
				name: 'login',
				builder: (context, state) => const LoginPage(),
			),
			GoRoute(
				path: '/register',
				name: 'register',
				builder: (context, state) => const RegistrationPage(),
			),
			// Main shell with bottom navigation
			ShellRoute(
				builder: (context, state, child) => StatefulShell(child: child),
				routes: [
					GoRoute(path: '/home', name: 'home', builder: (c, s) => const HomePage()),
					GoRoute(path: '/tutor', name: 'tutor', builder: (c, s) => const AiTutorPage()),
					GoRoute(path: '/emotion', name: 'emotion', builder: (c, s) => const EmotionPage()),
					GoRoute(path: '/analytics', name: 'analytics', builder: (c, s) => const AnalyticsPage()),
					GoRoute(path: '/game', name: 'game', builder: (c, s) => const GamificationPage()),
				],
			),
			GoRoute(path: '/help', name: 'help', builder: (c, s) => const HelpPage()),
			GoRoute(path: '/about', name: 'about', builder: (c, s) => const AboutPage()),
			GoRoute(path: '/settings', name: 'settings', builder: (c, s) => const SettingsPage()),
		],
	);
}


