import 'package:flutter/material.dart';

class KidAppBar extends StatelessWidget implements PreferredSizeWidget {
	final String title;
	final List<Widget>? actions;
	const KidAppBar({super.key, required this.title, this.actions});

	@override
	Size get preferredSize => const Size.fromHeight(64);

	@override
	Widget build(BuildContext context) {
		final scheme = Theme.of(context).colorScheme;
		return AppBar(
			title: Text(title),
			actions: actions,
			flexibleSpace: Container(
				decoration: BoxDecoration(
					gradient: LinearGradient(
						colors: [scheme.primary, scheme.secondary],
						begin: Alignment.topLeft,
						end: Alignment.bottomRight,
					),
				),
			),
			backgroundColor: Colors.transparent,
		);
	}
}


