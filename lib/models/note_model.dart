class Note {
  final String title;
  final String content;
  final List<NoteItem> items;

  Note({required this.title, required this.content, required this.items});

  // ✅ copyWith for immutability
  Note copyWith({String? title, String? content, List<NoteItem>? items}) {
    return Note(
      title: title ?? this.title,
      content: content ?? this.content,
      items: items ?? this.items,
    );
  }

  // ✅ Convert to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'items': items.map((item) => item.toMap()).toList(),
    };
  }

  // ✅ Create from Map
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      items:
          (map['items'] as List<dynamic>)
              .map((item) => NoteItem.fromMap(item))
              .toList(),
    );
  }
}

class NoteItem {
  final String text;
  final bool isTicked;

  NoteItem({required this.text, this.isTicked = false});

  // ✅ copyWith for immutability
  NoteItem copyWith({String? text, bool? isTicked}) {
    return NoteItem(
      text: text ?? this.text,
      isTicked: isTicked ?? this.isTicked,
    );
  }

  // ✅ Convert to Map for storage
  Map<String, dynamic> toMap() {
    return {'text': text, 'isTicked': isTicked};
  }

  // ✅ Create from Map
  factory NoteItem.fromMap(Map<String, dynamic> map) {
    return NoteItem(
      text: map['text'] ?? '',
      isTicked: map['isTicked'] ?? false,
    );
  }
}
