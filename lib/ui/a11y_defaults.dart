import 'package:flutter/material.dart';

class A11yDefaults extends InheritedWidget {
	final double minTapTarget;
	const A11yDefaults({
		super.key,
		required super.child,
		this.minTapTarget = 56,
	});

	static A11yDefaults of(BuildContext context) {
		final A11yDefaults? result = context.dependOnInheritedWidgetOfExactType<A11yDefaults>();
		return result ?? const A11yDefaults(child: SizedBox());
	}

	@override
	bool updateShouldNotify(covariant A11yDefaults oldWidget) => minTapTarget != oldWidget.minTapTarget;
}


