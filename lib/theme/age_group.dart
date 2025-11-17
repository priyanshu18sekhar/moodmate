enum AgeGroup { junior, middle, senior }

AgeGroup resolveAgeGroup(int age) {
	if (age <= 6) return AgeGroup.junior;
	if (age <= 11) return AgeGroup.middle;
	return AgeGroup.senior;
}


