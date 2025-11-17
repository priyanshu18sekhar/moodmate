import 'package:flutter/material.dart';
import '../../theme/age_group.dart';

class AgeBadge extends StatelessWidget {
	final AgeGroup group;
	const AgeBadge({super.key, required this.group});

	String get _label {
		switch (group) {
			case AgeGroup.junior:
				return 'Junior 3–6';
			case AgeGroup.middle:
				return 'Middle 7–11';
			case AgeGroup.senior:
				return 'Senior 12–15';
		}
	}

	@override
	Widget build(BuildContext context) {
		final scheme = Theme.of(context).colorScheme;
		return Container(
			padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
			decoration: BoxDecoration(
				color: scheme.secondary.withOpacity(.15),
				borderRadius: BorderRadius.circular(20),
				border: Border.all(color: scheme.secondary.withOpacity(.6)),
			),
			child: Text(_label, style: Theme.of(context).textTheme.titleSmall),
		);
	}
}


