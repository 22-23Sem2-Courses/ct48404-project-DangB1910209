import 'package:flutter/material.dart';
import 'package:my_note/models/note_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NoteDetailScreen extends StatefulWidget {
  final NoteModel note;

  const NoteDetailScreen({required this.note});

  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  bool _important = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
    _important = widget.note.important ?? false;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết ghi chú'),
        actions: [
          IconButton(
            icon: Icon(
              _important ? Icons.star : Icons.star_border,
              color: _important ? Colors.yellow : null,
            ),
            onPressed: () {
              setState(() {
                _important = !_important;
              });
              // widget.note.reference.update({'important': _important});
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Nhập tiêu đề',
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
              style:
                  const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  hintText: 'Nhập nội dung',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
                style: const TextStyle(
                  fontSize: 16.0,
                ),
                expands: true,
                maxLines: null,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Lưu các thay đổi vào widget.note và đóng màn hình
          widget.note.title = _titleController.text;
          widget.note.content = _contentController.text;
          widget.note.important = _important;
          await NoteModel().updateNote(
            widget.note.id as String,
            widget.note.title as String,
            widget.note.content as String,
            widget.note.important as bool,
          );
          const snackBar = SnackBar(
            content: Text('Lưu ghi chú thành công'),
          );
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
