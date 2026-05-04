import 'package:flutter/material.dart';
import '../models/note_model.dart';

class NoteItemWidget extends StatelessWidget {
  final NoteItem item;
  final Function(bool?) onChanged;
  final Function(String) onTextChanged;
  final VoidCallback onDelete;
  final bool autoFocus;

  const NoteItemWidget({
    super.key,
    required this.item,
    required this.onChanged,
    required this.onTextChanged,
    required this.onDelete,
    this.autoFocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          Checkbox(value: item.isTicked, onChanged: onChanged),
          Expanded(
            child: TextFormField(
              autofocus: autoFocus, // ✅ KEY FIX
              initialValue: item.text,
              onChanged: onTextChanged,
              decoration: const InputDecoration(
                hintText: "Enter item",
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
