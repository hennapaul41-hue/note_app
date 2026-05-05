import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/note_controller.dart';
import '../models/note_model.dart';
import '../widgets/note_item_widget.dart';

class EditNotePage extends StatelessWidget {
  EditNotePage({super.key});

  final NoteController controller = Get.find();
  final lastAddedIndex = (-1).obs;

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final int? noteIndex = args['noteIndex'];

    if (noteIndex == null ||
        noteIndex < 0 ||
        noteIndex >= controller.notes.length) {
      return const Scaffold(body: Center(child: Text("Invalid note index")));
    }

    final note = controller.notes[noteIndex];

    final titleController = TextEditingController(text: note.title);
    final contentController = TextEditingController(text: note.content);
    final items = note.items.obs;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: const Text("Edit Note", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'add') {
                // ✅ Add new tickable item
                items.add(NoteItem(text: ""));
                lastAddedIndex.value = items.length - 1;
                items.refresh();
              } else if (value == 'update') {
                final filteredItems =
                    items.where((item) => item.text.trim().isNotEmpty).toList();

                final updated = note.copyWith(
                  title: titleController.text,
                  content: contentController.text,
                  items: filteredItems,
                );

                await controller.updateNote(noteIndex, updated);
                Get.back(); // return to HomePage
              }
            },
            itemBuilder:
                (context) => [
                  const PopupMenuItem(
                    value: 'add',
                    child: Text("Add Tickable Item"),
                  ),
                  const PopupMenuItem(
                    value: 'update',
                    child: Text("Update Note"),
                  ),
                ],
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[300]!, Colors.blue[700]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // TITLE + CONTENT
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          labelText: "Note Title",
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: contentController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: "Contents",
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ITEMS
                Obx(() {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (_, index) {
                      return NoteItemWidget(
                        item: items[index],
                        // ✅ Autofocus only the last added item
                        autoFocus: index == lastAddedIndex.value,
                        onChanged: (val) {
                          items[index] = items[index].copyWith(
                            isTicked: val ?? false,
                          );
                          items.refresh();
                        },
                        onTextChanged: (val) {
                          items[index] = items[index].copyWith(text: val);
                        },
                        onDelete: () {
                          items.removeAt(index);
                          items.refresh();
                        },
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
