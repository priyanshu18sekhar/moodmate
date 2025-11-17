import 'package:flutter/material.dart';

enum MainTab { home, tutor, emotion, analytics, game }

class KidBottomNav extends StatelessWidget {
	final MainTab current;
	final void Function(MainTab) onChanged;
	const KidBottomNav({super.key, required this.current, required this.onChanged});

	int _indexOf(MainTab tab) => MainTab.values.indexOf(tab);
	MainTab _tabOf(int index) => MainTab.values[index];

	@override
	Widget build(BuildContext context) {
		final scheme = Theme.of(context).colorScheme;
		return NavigationBar(
			backgroundColor: scheme.surface,
			selectedIndex: _indexOf(current),
			onDestinationSelected: (i) => onChanged(_tabOf(i)),
			indicatorShape: const StadiumBorder(),
			destinations: const [
				NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Home'),
				NavigationDestination(icon: Icon(Icons.school_outlined), selectedIcon: Icon(Icons.school), label: 'Tutor'),
				NavigationDestination(icon: Icon(Icons.tag_faces_outlined), selectedIcon: Icon(Icons.tag_faces), label: 'Emotion'),
				NavigationDestination(icon: Icon(Icons.insights_outlined), selectedIcon: Icon(Icons.insights), label: 'Analytics'),
				NavigationDestination(icon: Icon(Icons.videogame_asset_outlined), selectedIcon: Icon(Icons.videogame_asset), label: 'Game'),
			],
		);
	}
}


