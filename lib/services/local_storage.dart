import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note_model.dart';

class LocalStorage {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // ================= LOGIN =================
  Future<void> setLogin(bool value) async {
    final prefs = await _prefs;
    await prefs.setBool('isLoggedIn', value);
  }

  Future<bool> getLogin() async {
    final prefs = await _prefs;
    return prefs.getBool('isLoggedIn') ?? false;
  }

  // ================= USER =================
  Future<void> setUsername(String username) async {
    final prefs = await _prefs;
    await prefs.setString('username', username);
  }

  Future<String?> getUsername() async {
    final prefs = await _prefs;
    return prefs.getString('username');
  }

  Future<void> setPassword(String password) async {
    final prefs = await _prefs;
    await prefs.setString('password', password);
  }

  Future<String?> getPassword() async {
    final prefs = await _prefs;
    return prefs.getString('password');
  }

  // ================= NOTES =================
  Future<void> saveNotes(List<Note> notes) async {
    final prefs = await _prefs;
    final data = notes.map((e) => e.toJson()).toList();
    await prefs.setString('notes', jsonEncode(data));
  }

  Future<List<Note>> getNotes() async {
    final prefs = await _prefs;
    final data = prefs.getString('notes');

    if (data == null) return [];

    final decoded = jsonDecode(data) as List;
    return decoded.map((e) => Note.fromJson(e)).toList();
  }

  // ================= LOGOUT =================
  Future<void> clearSession() async {
    final prefs = await _prefs;
    await prefs.setBool('isLoggedIn', false);
  }
}
