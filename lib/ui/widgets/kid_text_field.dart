import 'package:flutter/material.dart';

class KidTextField extends StatelessWidget {
	final TextEditingController controller;
	final String label;
	final TextInputType keyboardType;
	final String? hint;
	final Widget? prefixIcon;

	const KidTextField({
		super.key,
		required this.controller,
		required this.label,
		this.keyboardType = TextInputType.text,
		this.hint,
		this.prefixIcon,
	});

	@override
	Widget build(BuildContext context) {
		return TextField(
			controller: controller,
			keyboardType: keyboardType,
			textInputAction: TextInputAction.next,
			style: Theme.of(context).textTheme.titleMedium,
			decoration: InputDecoration(
				labelText: label,
				hintText: hint,
				prefixIcon: prefixIcon,
			),
		);
	}
}


