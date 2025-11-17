import 'package:flutter/material.dart';

enum EmotionLabel { happy, sad, neutral, surprised, angry }

class EmotionState extends ChangeNotifier {
	EmotionLabel current = EmotionLabel.neutral;
	bool isDetecting = false;

	void start() {
		isDetecting = true;
		notifyListeners();
	}

	void stop() {
		isDetecting = false;
		notifyListeners();
	}

	void setEmotion(EmotionLabel label) {
		current = label;
		notifyListeners();
	}
}


