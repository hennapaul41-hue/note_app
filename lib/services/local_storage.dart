import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/note_model.dart';
import '../models/settings_model.dart';

class LocalStorage {
  // Save all user data (called after registration/login)
  Future<void> setUserData(SettingsModel settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', settings.username);
    await prefs.setString('email', settings.email);
    await prefs.setString('password', settings.password);
    await prefs.setBool('isLoggedIn', true);
  }

  // Get current user data
  Future<SettingsModel?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final email = prefs.getString('email');
    final password = prefs.getString('password');

    if (username != null && email != null && password != null) {
      return SettingsModel(
        username: username,
        email: email,
        password: password,
      );
    }
    return null;
  }

  // Clear session (user + notes)
  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('email');
    await prefs.remove('password');
    await prefs.setBool('isLoggedIn', false);

    final key = await _notesKey();
    await prefs.remove(key);
  }

  // Login state
  Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', value);
  }

  Future<bool> getLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  // Notes (unique per user)
  Future<String> _notesKey() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username') ?? '';
    final password = prefs.getString('password') ?? '';
    return 'notes_${username}_$password';
  }

  Future<void> saveNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final key = await _notesKey();
    final noteList = notes.map((note) => jsonEncode(note.toMap())).toList();
    await prefs.setStringList(key, noteList);
  }

  Future<List<Note>> getNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final key = await _notesKey();
    final noteList = prefs.getStringList(key) ?? [];
    return noteList.map((e) => Note.fromMap(jsonDecode(e))).toList();
  }

  Future<void> clearNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final key = await _notesKey();
    await prefs.remove(key);
  }
}
