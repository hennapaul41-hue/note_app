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
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[300]!, Colors.blue[700]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
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

                  const SizedBox(height: 10),

                  // ===== ADD ITEM BUTTON =====
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text("Add Tickable Item"),
                      onPressed: () {
                        items.add(NoteItem(text: ""));
                        lastAddedIndex.value = items.length - 1;
                        items.refresh();
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ===== SAVE NOTE BUTTON =====
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () async {
                        // remove empty items
                        final filteredItems =
                            items
                                .where((item) => item.text.trim().isNotEmpty)
                                .toList();

                        final note = Note(
                          title: titleController.text,
                          content: contentController.text,
                          items: filteredItems,
                        );

                        await controller.addNote(note);
                        Get.back();
                      },
                      child: const Text("Save Note"),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
