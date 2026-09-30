class ComponentItem {
  final String icon;
  final String name;
  final String description;
  final String? imageUrl;

  const ComponentItem({
    required this.icon,
    required this.name,
    required this.description,
    this.imageUrl,
  });
}

class ComponentSection {
  final String icon;
  final String title;
  final String? imageUrl;
  final String? intro;
  final List<ComponentItem> items;
  final List<String>? notes;

  const ComponentSection({
    required this.icon,
    required this.title,
    this.imageUrl,
    this.intro,
    required this.items,
    this.notes,
  });
}