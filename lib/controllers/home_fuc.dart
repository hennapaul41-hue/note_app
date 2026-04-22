import 'package:flutter/material.dart';
import '../models/note_model.dart';
import '../services/local_storage.dart';
import 'note_controller.dart';

class HomeController {
  final NoteController noteController = NoteController();
  final storage = LocalStorage();

  // 📄 Load notes
  Future<List<Note>> loadNotes() async {
    return await noteController.getNotes();
  }

  // ➕ Add Note
  void addNote(BuildContext context, Function refresh) {
    TextEditingController title = TextEditingController();
    TextEditingController content = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Note"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: title,
              decoration: const InputDecoration(hintText: "Title"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: content,
              decoration: const InputDecoration(hintText: "Content"),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (title.text.isNotEmpty && content.text.isNotEmpty) {
                await noteController.addNote(
                  Note(title: title.text, content: content.text),
                );
                Navigator.pop(context);
                refresh();
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  // ✏️ Edit Note
  void editNote(BuildContext context, int index, Note note, Function refresh) {
    TextEditingController title = TextEditingController(text: note.title);
    TextEditingController content = TextEditingController(text: note.content);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Note"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: title),
            const SizedBox(height: 10),
            TextField(controller: content, maxLines: 3),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await noteController.updateNote(
                index,
                Note(title: title.text, content: content.text),
              );
              Navigator.pop(context);
              refresh();
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  // 🗑 Delete Note
  Future<void> deleteNote(int index, Function refresh) async {
    await noteController.deleteNote(index);
    refresh();
  }

  // 🚪 Logout
  Future<void> logout(BuildContext context) async {
    await storage.setLogin(false);

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/welcome',
      (route) => false,
    );
  }
}
