import 'package:flutter/material.dart';

class KidButton extends StatelessWidget {
	final String label;
	final IconData icon;
	final VoidCallback onPressed;
	final Color? color;

	const KidButton({
		super.key,
		required this.label,
		required this.icon,
		required this.onPressed,
		this.color,
	});

	@override
	Widget build(BuildContext context) {
		final scheme = Theme.of(context).colorScheme;
		final btnColor = color ?? scheme.primary;
		return SizedBox(
			height: 56,
			child: ElevatedButton.icon(
				style: ElevatedButton.styleFrom(
					backgroundColor: btnColor,
					foregroundColor: scheme.onPrimary,
					shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
					elevation: 3,
					padding: const EdgeInsets.symmetric(horizontal: 20),
				),
				icon: Icon(icon, size: 24),
				onPressed: onPressed,
				label: Text(label, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: scheme.onPrimary)),
			),
		);
	}
}


