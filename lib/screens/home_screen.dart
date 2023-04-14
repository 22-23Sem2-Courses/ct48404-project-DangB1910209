import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
              if (notesRecent.isNotEmpty)
                const TitleNotesWidget(label: 'GẦN ĐÂY'),
              ListNotesWidget(notes: notesRecent),
              if (notesImportant.isNotEmpty)
                const TitleNotesWidget(label: 'QUAN TRỌNG'),
              ListNotesWidget(notes: notesImportant),
            ],
          ),
        ));
  }
}
