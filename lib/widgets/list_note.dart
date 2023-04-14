import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_note/models/note_model.dart';
import 'package:my_note/screens/note_detail_screen.dart';
import 'package:my_note/widgets/quill.dart';

class ListNotesWidget extends StatefulWidget {
  final List<DocumentSnapshot<Object?>> notes;

  const ListNotesWidget({super.key, required this.notes});

  @override
  ListNotesWidgetState createState() => ListNotesWidgetState();
}

class ListNotesWidgetState extends State<ListNotesWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8.0),
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.notes.length,
        itemBuilder: (context, index) {
          final createdAt = DateTime.fromMillisecondsSinceEpoch(
              widget.notes[index]['createdAt'].millisecondsSinceEpoch);
          final createdAtFormatted = DateFormat('dd/MM/yyyy').format(createdAt);
          return Container(
            margin: const EdgeInsets.only(right: 2.0),
            width: 160.0,
            child: Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteDetailScreen(
                          note: NoteModel.fromDoc(widget.notes[index])),
                    ),
                  );
                },
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.notes[index]['title']}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Text(
                            NotesBlockEmbed(widget.notes[index]['content'])
                                .document
                                .toPlainText()
                                .replaceAll('\n', ' '),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                          ),
                        ),
                        Text(
                          createdAtFormatted,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          );
        },
      ),
    );
  }
}
