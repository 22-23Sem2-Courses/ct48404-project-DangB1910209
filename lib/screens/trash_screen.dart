import 'package:flutter/material.dart';
import 'package:my_note/components/drawer_bar.dart';
import 'package:my_note/models/note_model.dart';
import 'package:my_note/widgets/quill.dart';
import 'package:provider/provider.dart';

class TrashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final trashNotes = context
        .watch<NoteModel>()
        .notes
        .where((note) => note['isDelete'] == true)
        .toList();
    trashNotes.sort((a, b) => b['createdAt'].compareTo(a['createdAt']));
    return Scaffold(
      drawer: const DrawerBar(),
      appBar: AppBar(
        title: const Text('Thùng rác'),
        actions: [
          if (trashNotes.isNotEmpty)
            PopupMenuButton(
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  child: Text('Dọn sạch thùng rác'),
                  onTap: () {
                    NoteModel().clearTrash();
                  },
                ),
              ],
            ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
            ),
            child: Row(
              children: [
                if (trashNotes.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 18),
                    child: Text(
                      'Thùng rác',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                if (trashNotes.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(left: 2.0, top: 18.0),
                    child: Text(
                      '(${trashNotes.length})',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
              ],
            ),
          ),
          if (trashNotes.isEmpty)
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.delete_forever_rounded,
                  size: 100,
                  color: Color.fromRGBO(200, 200, 200, 1),
                ),
                SizedBox(
                  height: 14,
                ),
                SizedBox(
                  width: 300,
                  child: Text(
                    'Thùng rác của bạn đã rỗng',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                SizedBox(
                  width: 280,
                  child: Text(
                    'Khi bạn có ghi chú nằm trong thùng rác, hãy bấm vào "..." để khôi phục hoặc xóa.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            )),
          if (trashNotes.isNotEmpty)
            Expanded(
                child: ListView.builder(
              itemCount: trashNotes.length,
              itemBuilder: (context, index) {
                final note = trashNotes[index];
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(top: 2.0, bottom: 4.0),
                          child: Text(
                            '${note['title']}',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        subtitle: Text(
                          NotesBlockEmbed(note['content'])
                              .document
                              .toPlainText()
                              .replaceAll('\n', ' '),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: PopupMenuButton(
                          itemBuilder: (BuildContext context) => [
                            PopupMenuItem(
                              child: Text('Khôi phục ghi chú'),
                              onTap: () {
                                NoteModel().changeDelete(note.id, false);
                                final snackBar = SnackBar(
                                  content: const Text('Đã khôi phục ghi chú'),
                                  action: SnackBarAction(
                                    label: 'Hoàn tác',
                                    onPressed: () {
                                      NoteModel().changeDelete(note.id, true);
                                    },
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                            ),
                            PopupMenuItem(
                              child: Text('Xóa vĩnh viễn'),
                              onTap: () {
                                NoteModel().deleteNote(note.id);
                                final snackBar = SnackBar(
                                  content: const Text('Đã xóa ghi chú'),
                                  action: SnackBarAction(
                                    label: 'Đóng',
                                    onPressed: () {},
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text(
                          // DateFormat.yMd().add_jm().format(note['createdAt']),
                          'aa',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ))
        ],
      ),
    ); 
  }
}
