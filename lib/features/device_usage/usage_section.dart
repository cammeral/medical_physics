class UsageStep {
  final String icon;
  final String text;

  const UsageStep({required this.icon, required this.text});
}

class UsageStage {
  final String icon;
  final String title;
  final String duration;
  final List<UsageStep> steps;
  final List<String>? checklist;
  final String? commonMistake;
  final String? mistakeFix;
  final List<String>? expertTips;

  const UsageStage({
    required this.icon,
    required this.title,
    required this.duration,
    required this.steps,
    this.checklist,
    this.commonMistake,
    this.mistakeFix,
    this.expertTips,
  });
}

class UsageContent {
  final String intro;
  final List<UsageStage> stages;

  const UsageContent({required this.intro, required this.stages});
}