import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:my_note/models/note_model.dart';
import 'package:my_note/widgets/add_note_dialog.dart';
import 'package:my_note/widgets/quill.dart';
import '../components/drawer_bar.dart';
import 'package:provider/provider.dart';
import 'package:my_note/screens/note_detail_screen.dart';

class NotePage extends StatefulWidget {
  @override
  NotePage({Key? key}) : super(key: key);
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final notes = context
        .watch<NoteModel>()
        .notes
        .where((note) => note['isDelete'] == false)
        .toList();
    notes.sort((a, b) => b['createdAt'].compareTo(a['createdAt']));

    return Scaffold(
      drawer: const DrawerBar(),
      appBar: AppBar(title: const Text('Ghi chú')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => const AddNoteDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
          margin: const EdgeInsets.all(0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 0),
                child: Row(
                  children: [
                    if (notes.isNotEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top: 18),
                        child: Text(
                          'Ghi chú',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                    if (notes.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(left: 2.0, top: 18),
                        child: Text(
                          '(${notes.length})',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                  ],
                ),
              ),
              if (notes.isEmpty)
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.event_note_rounded,
                      size: 100,
                      color: Color.fromRGBO(200, 200, 200, 1),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      width: 160,
                      child: Text(
                        'Tất cả bắt đầu với các ghi chú',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) =>
                              const AddNoteDialog(),
                        );
                      },
                      child: Text(
                        'Tạo ghi chú đầu tiên của bạn',
                        style: TextStyle(
                            decoration: TextDecoration.underline, fontSize: 16),
                      ),
                    )
                  ],
                )),
              if (notes.isNotEmpty)
                Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: notes.length,
                        itemBuilder: (BuildContext context, int index) {
                          final createdAt = DateTime.fromMillisecondsSinceEpoch(
                              notes[index]['createdAt'].millisecondsSinceEpoch);
                          final createdAtFormatted =
                              DateFormat('dd/MM/yyyy').format(createdAt);

                          return Card(
                            child: Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NoteDetailScreen(
                                          note: NoteModel.fromDoc(notes[index]),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        title: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 2.0,
                                            bottom: 4.0,
                                          ),
                                          child: Text(
                                            '${notes[index]['title']}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        subtitle: Text(
                                          NotesBlockEmbed(
                                                  notes[index]['content'])
                                              .document
                                              .toPlainText()
                                              .replaceAll('\n', ' '),
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        child: Text(
                                          createdAtFormatted,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: PopupMenuButton(
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry>[
                                      PopupMenuItem(
                                        value: 1,
                                        child:
                                            const Text('Chuyển vào thùng rác'),
                                        onTap: () {
                                          NoteModel().changeDelete(
                                              notes[index].id, true);
                                          final snackBar = SnackBar(
                                            content: const Text(
                                                'Đã chuyển ghi chú vào thùng rác'),
                                            action: SnackBarAction(
                                              label: 'Khôi phục',
                                              onPressed: () {
                                                NoteModel().changeDelete(
                                                    notes[index].id, false);
                                              },
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        },
                                      ),
                                      const PopupMenuItem(
                                        value: 2,
                                        child: Text('Truy cập vào ghi chú'),
                                      ),
                                    ],
                                    onSelected: (result) {
                                      // ...
                                    },
                                    icon: const Icon(Icons.more_vert),
                                  ),
                                ),
                              ],
                            ),
                          );
                        })),
            ],
          )),
    );
  }

  static Route<Object?> _dialogBuilder(
      BuildContext context, Object? arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tạo ghi chú mới'),
          content: const Text(
              'Bạn có muốn tạo một ghi chú mới với tiêu đề là "Tiêu đề" và nội dung là "Nội dung" hay không.'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Không'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Tạo'),
              onPressed: () {
                NoteModel().addNote("Tiêu đề", "Nội dung", false);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
