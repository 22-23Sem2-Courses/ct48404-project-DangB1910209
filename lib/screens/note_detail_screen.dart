import 'dart:convert';

import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter/material.dart';
import 'package:my_note/models/note_model.dart';

class NoteDetailScreen extends StatefulWidget {
  final NoteModel note;

  const NoteDetailScreen({required this.note});

  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  QuillController _controller = QuillController.basic();
  bool _important = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
    _important = widget.note.important ?? false;

    var myJSON = jsonDecode(widget.note.content as String);
    _controller = QuillController(
        document: Document.fromJson(myJSON),
        selection: TextSelection.collapsed(offset: 0));
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
            onPressed: () async {
              setState(() {
                _important = !_important;
              });
              widget.note.important = !_important;
              await NoteModel().changImportant(
                widget.note.id as String,
                _important,
              );

              final snackBar = SnackBar(
                content: Text(_important
                    ? 'Đã đặt ghi chú thành quan trọng'
                    : 'Đã xóa quan trọng khỏi ghi chú'),
                // thiết lập màu nền cho Snackbar
                action: SnackBarAction(
                  label: 'Đóng',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              );
              // hiển thị Snackbar
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
            QuillToolbar.basic(
              controller: _controller,
              multiRowsDisplay: false,
            ),
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
            // Expanded(
            //   child: TextField(
            //     controller: _contentController,
            //     decoration: const InputDecoration(
            //       hintText: 'Nhập nội dung',
            //       border: InputBorder.none,
            //       enabledBorder: InputBorder.none,
            //     ),
            //     style: const TextStyle(
            //       fontSize: 16.0,
            //     ),
            //     expands: true,
            //     maxLines: null,
            //   ),
            // ),
            Expanded(
              child: QuillEditor.basic(
                controller: _controller,
                readOnly: false, // true for view only mode
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Lưu các thay đổi vào widget.note và đóng màn hình
          // widget.note.title = _titleController.text;
          // widget.note.content = _contentController.text;
          var json = jsonEncode(_controller.document.toDelta().toJson());
          await NoteModel().updateNote(
            widget.note.id as String,
            widget.note.title as String,
            json,
          );
          final snackBar = SnackBar(
            content: Text('Lưu ghi chú thành công'),
            // thiết lập màu nền cho Snackbar
            action: SnackBarAction(
              label: 'Đóng',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
          // hiển thị Snackbar
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
