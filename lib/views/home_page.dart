import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/note_controller.dart';
import '../routes/app_routes.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final NoteController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: const Text(
          "My Notes",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () => Get.toNamed(AppRoutes.settings),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[300]!, Colors.blue[700]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Obx(() {
          if (controller.notes.isEmpty) {
            return const Center(
              child: Text(
                "No notes yet",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: controller.notes.length,
            itemBuilder: (context, noteIndex) {
              final note = controller.notes[noteIndex];

              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 8),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Note title
                      Text(
                        note.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Show content if available
                      if (note.content.isNotEmpty)
                        Text(
                          note.content,
                          style: const TextStyle(fontSize: 16),
                        ),

                      // Show items with strikethrough if ticked
                      if (note.items.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              note.items.map((item) {
                                return Text(
                                  "- ${item.text}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    decoration:
                                        item.isTicked
                                            ? TextDecoration.lineThrough
                                            : null,
                                  ),
                                );
                              }).toList(),
                        ),
                      ],

                      // Action buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              // ✅ Pass only the index
                              Get.toNamed(
                                AppRoutes.editNote,
                                arguments: {'noteIndex': noteIndex},
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => controller.deleteNote(noteIndex),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => Get.toNamed(AppRoutes.addNote),
        child: Icon(Icons.add, color: Colors.blue[700]),
      ),
    );
  }
}
