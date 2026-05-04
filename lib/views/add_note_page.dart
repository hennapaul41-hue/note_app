import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/note_controller.dart';
import '../models/note_model.dart';

class AddNotePage extends StatelessWidget {
  AddNotePage({super.key});
  final NoteController controller = Get.find();

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final items = <NoteItem>[].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        elevation: 2,
        title: const Text(
          "Add Note",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[300]!, Colors.blue[700]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Title + content card
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 8),
                  ],
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: "Note Title",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: contentController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: "Contents ",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // ✅ Tickable items list
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, blurRadius: 4),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Checkbox
                            Checkbox(
                              value: items[index].isTicked,
                              onChanged: (val) {
                                items[index] = items[index].copyWith(
                                  isTicked: val ?? false,
                                );
                                items.refresh();
                              },
                            ),
                            // Editable text
                            Expanded(
                              child: TextFormField(
                                key: ValueKey(index),
                                initialValue: items[index].text,
                                onChanged: (val) {
                                  items[index] = items[index].copyWith(
                                    text: val,
                                  );
                                },
                                decoration: const InputDecoration(
                                  hintText: "Enter item",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            // Delete button
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                items.removeAt(index);
                                items.refresh();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),

              // Buttons
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text("Add Tickable Item"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo[500],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          items.add(NoteItem(text: "", isTicked: false));
                          items.refresh();
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[600],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          final newNote = Note(
                            title: titleController.text,
                            content: contentController.text,
                            items: items.toList(),
                          );
                          await controller.addNote(newNote);
                          Get.back();
                        },
                        child: const Text(
                          "Save Note",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
