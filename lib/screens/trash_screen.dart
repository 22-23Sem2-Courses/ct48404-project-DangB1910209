import 'package:flutter/material.dart';
import 'package:my_note/components/drawer_bar.dart';
import 'package:my_note/models/note_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
        title: Text('Trash'),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: Text('Clear Trash'),
                onTap: () {
                  // Code to clear trash
                },
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 18.0),
            child: Row(
              children: [
                const Text(
                  'Thùng rác',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 2.0),
                  child: Text(
                    '(${trashNotes.length})',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: trashNotes.length,
            itemBuilder: (context, index) {
              final note = trashNotes[index];
              return Card(
                child: InkWell(
                  onTap: () {
                    // Code to restore note
                  },
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
                          '${note['content']}',
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: PopupMenuButton(
                          itemBuilder: (BuildContext context) => [
                            PopupMenuItem(
                              child: Text('Restore'),
                              onTap: () {
                                // Code to restore note
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
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
