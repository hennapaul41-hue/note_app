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

    await prefs.setString('username', username);
    await prefs.setString('email', email);
    await prefs.setString('password', password);

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

  // ✅ FIX FOR YOUR MAIN ERROR
  Future<bool> getLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('loggedIn') ?? false;
  }

  // OPTIONAL LOGOUT
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', false);
  }

  // ================= NOTES =================

  Future<void> saveNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> noteList =
        notes.map((note) => jsonEncode(note.toJson())).toList();

    await prefs.setStringList('notes', noteList);
  }

  Future<List<Note>> getNotes() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String>? noteList = prefs.getStringList('notes');

    if (noteList == null) return [];

    return noteList.map((note) => Note.fromJson(jsonDecode(note))).toList();
  }
}
