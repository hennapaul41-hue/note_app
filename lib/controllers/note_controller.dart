import 'package:get/get.dart';
import '../models/note_model.dart';
import '../services/local_storage.dart';
import 'package:flutter/material.dart';

class NoteController extends GetxController {
  var notes = <Note>[].obs;
  final LocalStorage _storage = LocalStorage();

  @override
  void onInit() {
    super.onInit();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final storedNotes = await _storage.getNotes();
    notes.assignAll(storedNotes);
  }

  // ✅ ADD NOTE
  Future<void> addNote(Note note) async {
    final hasTitle = note.title.trim().isNotEmpty;
    final hasItems = note.items.isNotEmpty;

    if (!hasTitle && !hasItems) {
      Get.snackbar(
        "Empty Note",
        "Please add a title or items before saving.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    notes.add(note);

    await _storage.saveNotes(List<Note>.from(notes)); // safer copy

    notes.refresh();
  }

  // ✅ UPDATE NOTE
  Future<void> updateNote(int index, Note updatedNote) async {
    final hasTitle = updatedNote.title.trim().isNotEmpty;
    final hasItems = updatedNote.items.isNotEmpty;

    if (!hasTitle && !hasItems) {
      Get.snackbar(
        "Empty Note",
        "Cannot update with empty content.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    if (index >= 0 && index < notes.length) {
      notes[index] = updatedNote.copyWith(
        items:
            updatedNote.items.where((i) => i.text.trim().isNotEmpty).toList(),
      );

      await _storage.saveNotes(List<Note>.from(notes));

      notes.refresh();
    }
  }

  // ✅ DELETE NOTE
  Future<void> deleteNote(int index) async {
    if (index >= 0 && index < notes.length) {
      notes.removeAt(index);

      await _storage.saveNotes(List<Note>.from(notes));

      notes.refresh();
    }
  }

  // ✅ TOGGLE ITEM
  Future<void> toggleItemTick(int noteIndex, int itemIndex) async {
    if (noteIndex >= 0 && noteIndex < notes.length) {
      final note = notes[noteIndex];

      if (itemIndex >= 0 && itemIndex < note.items.length) {
        final updatedItems = [...note.items];
        updatedItems[itemIndex] = updatedItems[itemIndex].copyWith(
          isTicked: !updatedItems[itemIndex].isTicked,
        );

        notes[noteIndex] = note.copyWith(items: updatedItems);

        await _storage.saveNotes(List<Note>.from(notes));

        notes.refresh();
      }
    }
  }
}
