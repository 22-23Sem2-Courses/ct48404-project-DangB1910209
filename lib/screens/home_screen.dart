import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_note/components/drawer_bar.dart';
import 'package:my_note/screens/note_detail_screen.dart';
import 'package:my_note/widgets/backgroud_home.dart';
import 'package:my_note/models/note_model.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The title text which will be shown on the action bar
        title: const Text('Trang chủ'),
      ),
      drawer:  DrawerBar(),
      body: Column(
        children: <Widget>[
          const ImageWithText(),
          const Padding(
            padding: EdgeInsets.only(left: 8.0, top: 16.0, bottom: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'GHI CHÚ GẦN ĐÂY',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8.0),
            height: 200.0,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('notes')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: Text('Không có ghi chú nào'));
                  }
                  final notes = snapshot.data!.docs;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final createdAt = DateTime.fromMillisecondsSinceEpoch(
                          notes[index]['createdAt'].millisecondsSinceEpoch);
                      final createdAtFormatted =
                          DateFormat('dd/MM/yyyy').format(createdAt);
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
                                      note: NoteModel.fromDoc(notes[index])),
                                ),
                              );
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${notes[index]['title']}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child: Text(
                                        '${notes[index]['content']}',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 5,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
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
                  );
                }),
          ),
        ],
      ),
    );
  }
}
