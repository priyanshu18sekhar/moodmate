import 'package:flutter/material.dart';
import '../theme/age_group.dart';

class AppState extends ChangeNotifier {
	String? childName;
	int? childAge;
	String? avatarAsset; // assets/avatars/...
	AgeGroup ageGroup = AgeGroup.junior;

	void setProfile({required String name, required int age, String? avatar}) {
		childName = name;
		childAge = age;
		avatarAsset = avatar;
		ageGroup = resolveAgeGroup(age);
		notifyListeners();
	}

	void clearProfile() {
		childName = null;
		childAge = null;
		avatarAsset = null;
		ageGroup = AgeGroup.junior;
		notifyListeners();
	}
}


