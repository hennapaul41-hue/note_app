import '../models/note_model.dart';
import '../services/local_storage.dart';

class NoteController {
  final LocalStorage _storage = LocalStorage();
  List<Note> notes = [];

  Future<void> loadNotes() async {
    notes = await _storage.getNotes();
  }

  Future<void> addNote(Note note) async {
    notes.add(note);
    await _storage.saveNotes(notes);
  }

  Future<void> updateNote(int index, Note note) async {
    notes[index] = note;
    await _storage.saveNotes(notes);
  }

  Future<void> deleteNote(int index) async {
    notes.removeAt(index);
    await _storage.saveNotes(notes);
  }
}
