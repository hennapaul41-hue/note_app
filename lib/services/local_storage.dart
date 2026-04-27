import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note_model.dart';

class LocalStorage {
  Future<void> setUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  Future<void> setPassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', password);
  }

  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  Future<String?> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('password');
  }

  Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', value);
  }

  Future<bool> getLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
  }

  Future<void> saveNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();

    String? username = prefs.getString('username') ?? 'default';

    List<String> noteList =
        notes.map((note) => jsonEncode(note.toJson())).toList();

    await prefs.setStringList('notes_$username', noteList);
  }

  Future<List<Note>> getNotes() async {
    final prefs = await SharedPreferences.getInstance();

    String? username = prefs.getString('username') ?? 'default';

    List<String> noteList = prefs.getStringList('notes_$username') ?? [];

    return noteList.map((e) => Note.fromJson(jsonDecode(e))).toList();
  }
}
