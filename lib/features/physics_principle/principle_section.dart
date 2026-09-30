enum BlockType { text, bullets, equation, note }

class Block {
  final BlockType type;
  final String? text;
  final List<String>? items;
  final String? note;

  const Block.text(this.text)
      : type = BlockType.text,
        items = null,
        note = null;

  const Block.bullets(this.items)
      : type = BlockType.bullets,
        text = null,
        note = null;

  const Block.equation(this.text, {this.note})
      : type = BlockType.equation,
        items = null;

  const Block.note(this.text)
      : type = BlockType.note,
        items = null,
        note = null;
}

class PrincipleSection {
  final String icon;
  final String title;
  final List<Block> blocks;

  const PrincipleSection({
    required this.icon,
    required this.title,
    required this.blocks,
  });
}