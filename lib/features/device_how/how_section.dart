class HowVideo {
  final String title;
  final String assetPath;
  final String? description;

  const HowVideo({
    required this.title,
    required this.assetPath,
    this.description,
  });
}

class HowStep {
  final String icon;
  final String title;
  final String description;

  const HowStep({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class HowSection {
  final String icon;
  final String title;
  final String? intro;
  final List<HowStep> steps;
  final List<String>? notes;
  final HowVideo? video;

  const HowSection({
    required this.icon,
    required this.title,
    this.intro,
    required this.steps,
    this.notes,
    this.video,
  });
}