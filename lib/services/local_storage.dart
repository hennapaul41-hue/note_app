import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note_model.dart';

class LocalStorage {
  // ================= USER =================

  Future<void> saveUser({
    required String username,
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('username', username.trim());
    await prefs.setString('email', email.trim());
    await prefs.setString('password', password.trim());

    // ✅ mark as logged in
    await prefs.setBool('loggedIn', true);
  }

  Future<Map<String, String>> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      'username': prefs.getString('username') ?? '',
      'email': prefs.getString('email') ?? '',
      'password': prefs.getString('password') ?? '',
    };
  }

  Future<bool> getLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('loggedIn') ?? false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    // ✅ clear login state
    await prefs.setBool('loggedIn', false);

    // ✅ clear user data
    await prefs.remove('username');
    await prefs.remove('email');
    await prefs.remove('password');

    // ✅ clear notes for that user
    final key = await _notesKey();
    await prefs.remove(key);
  }

  // ================= NOTES =================

  // 🔑 Generate a unique key per user
  Future<String> _notesKey() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username') ?? '';
    final email = prefs.getString('email') ?? '';
    return 'notes_${username}_$email';
  }

  Future<void> saveNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final key = await _notesKey();

    List<String> noteList =
        notes.map((note) => jsonEncode(note.toJson())).toList();

    await prefs.setStringList(key, noteList);
  }

  Future<List<Note>> getNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final key = await _notesKey();

    final List<String>? noteList = prefs.getStringList(key);

    if (noteList == null) return [];

    return noteList.map((note) => Note.fromJson(jsonDecode(note))).toList();
  }

  Future<void> clearNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final key = await _notesKey();
    await prefs.remove(key);
  }
}
