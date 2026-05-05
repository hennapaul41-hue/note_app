import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/note_controller.dart';
import '../models/note_model.dart';
import '../widgets/note_item_widget.dart';

class AddNotePage extends StatelessWidget {
  AddNotePage({super.key});

  final NoteController controller = Get.find();

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  final items = <NoteItem>[].obs;
  final lastAddedIndex = (-1).obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: const Text("Add Note", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'add') {
                // ✅ Add new tickable item
                items.add(NoteItem(text: ""));
                lastAddedIndex.value = items.length - 1;
                items.refresh();
              } else if (value == 'save') {
                final filteredItems =
                    items.where((item) => item.text.trim().isNotEmpty).toList();

                final note = Note(
                  title: titleController.text,
                  content: contentController.text,
                  items: filteredItems,
                );

                await controller.addNote(note);
                Get.back(); // return to HomePage
              }
            },
            itemBuilder:
                (context) => [
                  const PopupMenuItem(
                    value: 'add',
                    child: Text("Add Tickable Item"),
                  ),
                  const PopupMenuItem(value: 'save', child: Text("Save Note")),
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
                // ===== TITLE + CONTENT =====
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

                // ===== TICKABLE ITEMS =====
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
