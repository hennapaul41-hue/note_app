import 'package:flutter/material.dart';
import '../controllers/note_controller.dart';
import '../models/note_model.dart';
import '../routes/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NoteController controller = NoteController();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await controller.loadNotes();
    setState(() {});
  }

  void openNoteDialog({Note? note, int? index}) {
    final titleController = TextEditingController(text: note?.title ?? '');
    final contentController = TextEditingController(text: note?.content ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(note == null ? "Add Note" : "Edit Note"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: "Title")),
              TextField(
                  controller: contentController,
                  decoration: const InputDecoration(labelText: "Content")),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel")),
            ElevatedButton(
              onPressed: () async {
                final newNote = Note(
                  title: titleController.text,
                  content: contentController.text,
                );

                if (note == null) {
                  await controller.addNote(newNote);
                } else {
                  await controller.updateNote(index!, newNote);
                }

                setState(() {});
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteNote(int index) async {
    await controller.deleteNote(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final notes = controller.notes;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.settings);
            },
          ),
        ],
      ),
      body: notes.isEmpty
          ? const Center(child: Text("No notes yet"))
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return Card(
                  child: ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.content),
                    onTap: () => openNoteDialog(note: note, index: index),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () =>
                              openNoteDialog(note: note, index: index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => deleteNote(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openNoteDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
