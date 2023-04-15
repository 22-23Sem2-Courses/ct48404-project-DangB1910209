import 'package:flutter/material.dart';
import 'package:my_note/models/note_model.dart';

class AddNoteDialog extends StatefulWidget {
  const AddNoteDialog({Key? key}) : super(key: key);

  @override
  _AddNoteDialogState createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends State<AddNoteDialog> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tạo ghi chú mới'),
      content: Container(
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: 'Tiêu đề',
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            print(_controller.text);
            Navigator.pop(context, 'Cancel');
          },
          child: const Text('Hủy'),
        ),
        TextButton(
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              NoteModel().addNote(_controller.text,
                  '[{"insert":"Nội dung của ${_controller.text}\\n"}]', false);
              Navigator.pop(context, 'OK');
            }
          },
          child: const Text('Thêm'),
        ),
      ],
    );
  }
}
