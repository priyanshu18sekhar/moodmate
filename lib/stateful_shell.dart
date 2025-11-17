import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'ui/widgets/kid_bottom_nav.dart';

class StatefulShell extends StatefulWidget {
	final Widget child;
	const StatefulShell({super.key, required this.child});

	@override
	State<StatefulWidget> createState() => _StatefulShellState();
}

class _StatefulShellState extends State<StatefulShell> {
	MainTab _currentFromLocation(BuildContext context) {
		final loc = GoRouterState.of(context).uri.path;
		if (loc.startsWith('/tutor')) return MainTab.tutor;
		if (loc.startsWith('/emotion')) return MainTab.emotion;
		if (loc.startsWith('/analytics')) return MainTab.analytics;
		if (loc.startsWith('/game')) return MainTab.game;
		return MainTab.home;
	}

	void _switchTab(MainTab tab) {
		switch (tab) {
			case MainTab.home:
				context.go('/home');
				break;
			case MainTab.tutor:
				context.go('/tutor');
				break;
			case MainTab.emotion:
				context.go('/emotion');
				break;
			case MainTab.analytics:
				context.go('/analytics');
				break;
			case MainTab.game:
				context.go('/game');
				break;
		}
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: widget.child,
			bottomNavigationBar: KidBottomNav(
				current: _currentFromLocation(context),
				onChanged: _switchTab,
			),
		);
	}
}


