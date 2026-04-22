import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';
import '../controllers/home_fuc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = HomeController();
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  // 🔄 Load notes
  void load() async {
    final data = await controller.loadNotes();
    setState(() {
      notes = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Notes"),
        actions: [
          // 🚪 Logout
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => controller.logout(context),
          ),
        ],
      ),

      // 📄 Notes List
      body: notes.isEmpty
          ? const Center(
              child: Text(
                "No notes yet",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      note.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      note.content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // ✏️ + 🗑 Actions
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // ✏️ Edit
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => controller.editNote(
                            context,
                            index,
                            note,
                            load,
                          ),
                        ),

                        // 🗑 Delete
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => controller.deleteNote(index, load),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

      // ➕ Add Note Button
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.addNote(context, load),
        child: const Icon(Icons.add),
      ),
    );
  }
}
