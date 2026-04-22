import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note_model.dart';

class NoteController {
  final String key = "notes";

  // ➕ Add
  Future<void> addNote(Note note) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> notes = prefs.getStringList(key) ?? [];

    notes.add(jsonEncode(note.toJson()));

    await prefs.setStringList(key, notes);
  }

  // 📄 Get
  Future<List<Note>> getNotes() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> notes = prefs.getStringList(key) ?? [];

    return notes.map((e) => Note.fromJson(jsonDecode(e))).toList();
  }

  // 🗑 Delete
  Future<void> deleteNote(int index) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> notes = prefs.getStringList(key) ?? [];

    notes.removeAt(index);

    await prefs.setStringList(key, notes);
  }

  // ✏️ Update
  Future<void> updateNote(int index, Note note) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> notes = prefs.getStringList(key) ?? [];

    notes[index] = jsonEncode(note.toJson());

    await prefs.setStringList(key, notes);
  }
}
