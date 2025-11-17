import 'package:flutter/material.dart';

class PdfTile extends StatelessWidget {
	final String title;
	final String? subtitle;
	final VoidCallback? onOpen;
	final VoidCallback? onDelete;

	const PdfTile({super.key, required this.title, this.subtitle, this.onOpen, this.onDelete});

	@override
	Widget build(BuildContext context) {
		return ListTile(
			leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
			title: Text(title),
			subtitle: subtitle != null ? Text(subtitle!) : null,
			onTap: onOpen,
			trailing: IconButton(
				icon: const Icon(Icons.more_vert),
				onPressed: onDelete,
			),
			shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
		);
	}
}


