import 'package:get/get.dart';
import '../models/note_model.dart';
import '../services/local_storage.dart';

class NoteController extends GetxController {
  final LocalStorage _storage = LocalStorage();

  var notes = <Note>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotes();
  }

  Future<void> loadNotes() async {
    notes.value = await _storage.getNotes();
  }

  Future<void> addNote(Note note) async {
    notes.add(note);
    await _storage.saveNotes(notes.toList());
  }

  Future<void> updateNote(int index, Note note) async {
    notes[index] = note;
    notes.refresh();
    await _storage.saveNotes(notes.toList());
  }

  Future<void> deleteNote(int index) async {
    notes.removeAt(index);
    await _storage.saveNotes(notes.toList());
  }
}
