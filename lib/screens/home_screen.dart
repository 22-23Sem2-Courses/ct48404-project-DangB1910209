import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_note/widgets/add_note_dialog.dart';
import 'package:my_note/widgets/list_note.dart';
import 'package:my_note/widgets/quill.dart';
import 'package:my_note/widgets/title_note.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:my_note/components/drawer_bar.dart';
import 'package:my_note/screens/note_detail_screen.dart';
import 'package:my_note/widgets/backgroud_home.dart';
import 'package:my_note/models/note_model.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<DocumentSnapshot<Object?>> notesRecent = context
        .watch<NoteModel>()
        .notes
        .where((note) => note['isDelete'] == false)
        .toList();
    notesRecent.sort((a, b) => b['createdAt'].compareTo(a['createdAt']));
    final notesImportant = context
        .watch<NoteModel>()
        .notes
        .where((note) => note['isDelete'] == false)
        .where((note) => note['important'] == true)
        .toList();
    notesImportant.sort((a, b) => b['createdAt'].compareTo(a['createdAt']));
    return Scaffold(
        appBar: AppBar(
          title: const Text('Trang chủ'),
        ),
        drawer: const DrawerBar(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const ImageWithText(),
              if (notesRecent.isEmpty) const TitleNotesWidget(label: 'GHI CHÚ'),
              if (notesRecent.isEmpty)
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Align(
                      alignment: FractionalOffset.topLeft,
                      child: Container(
                        margin: const EdgeInsets.only(right: 2.0),
                        width: 160.0,
                        height: 200,
                        child: Card(
                          color: Color.fromRGBO(248, 248, 248, 1),
                          child: InkWell(
                            onTap: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    const AddNoteDialog(),
                              );
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.assignment_add),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 60,
                                      child: Text(
                                        'Tạo ghi chú mới',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      )),
                ),
              if (notesRecent.isNotEmpty)
                const TitleNotesWidget(label: 'GẦN ĐÂY'),
              if (notesRecent.isNotEmpty) ListNotesWidget(notes: notesRecent),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: double.infinity,
                  color: Color.fromRGBO(242, 242, 242, 1),
                  child: const SizedBox(
                    height: 24,
                    width: double.infinity,
                  ),
                ),
              ),
              if (notesImportant.isNotEmpty)
                const TitleNotesWidget(label: 'QUAN TRỌNG'),
              if (notesImportant.isNotEmpty)
                ListNotesWidget(notes: notesImportant),
            ],
          ),
        ));
  }
}
