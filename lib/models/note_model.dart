class Note {
  final String title;
  final String content;
  final List<NoteItem> items;

  Note({required this.title, required this.content, required this.items});

  // ✅ COPY
  Note copyWith({String? title, String? content, List<NoteItem>? items}) {
    return Note(
      title: title ?? this.title,
      content: content ?? this.content,
      items: items ?? this.items,
    );
  }

  // ✅ TO JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'items': items.map((e) => e.toJson()).toList(),
    };
  }

  // ✅ FROM JSON (FIX FOR YOUR ERROR)
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      items:
          (json['items'] as List<dynamic>? ?? [])
              .map((e) => NoteItem.fromJson(e))
              .toList(),
    );
  }
}

// ================= ITEM =================

class NoteItem {
  final String text;
  final bool isTicked;

  NoteItem({required this.text, this.isTicked = false});

  // COPY
  NoteItem copyWith({String? text, bool? isTicked}) {
    return NoteItem(
      text: text ?? this.text,
      isTicked: isTicked ?? this.isTicked,
    );
  }

  // TO JSON
  Map<String, dynamic> toJson() {
    return {'text': text, 'isTicked': isTicked};
  }

  // FROM JSON
  factory NoteItem.fromJson(Map<String, dynamic> json) {
    return NoteItem(
      text: json['text'] ?? '',
      isTicked: json['isTicked'] ?? false,
    );
  }
}
