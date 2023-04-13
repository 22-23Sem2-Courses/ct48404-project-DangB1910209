import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:my_note/components/sort_option.dart';
import 'package:my_note/models/note_model.dart';
import 'package:my_note/screens/note_detail_screen.dart';
import '../components/drawer_bar.dart';

class NotePage extends StatefulWidget {
  @override
  NotePage({Key? key}) : super(key: key);
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    bool isSortExpanded = false;

    void _showMenu() {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.sort),
                  title: const Text('Sắp xếp'),
                  onTap: () {
                    // Xử lý khi người dùng chọn mục chia sẻ
                    setState(() {
                      isSortExpanded = !isSortExpanded;
                    });
                  },
                ),
                if (isSortExpanded) const SortOptions(),
                ListTile(
                  leading: const Icon(Icons.filter_alt),
                  title: const Text('Lọc'),
                  onTap: () {},
                ),
              ],
            );
          });
        },
      );
    }

    return Scaffold(
      drawer: DrawerBar(),
      appBar: AppBar(title: const Text('Ghi chú'), actions: [
        IconButton(
            onPressed: () {
              _showMenu();
            },
            icon: const Icon(Icons.more_horiz))
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Container(
          margin: const EdgeInsets.all(0),
          child: Column(
            children: [
              Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 12.0),
                    child: Row(
                      children: const [
                        Text(
                          'Ghi chú',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.0),
                          child: Text(
                            '(2)',
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("notes")
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        if (!snapshot.hasData) {
                          return const Center(
                              child: Text('Không có ghi chú nào'));
                        } else {
                          final notes = snapshot.data!.docs;

                          return ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                final createdAt =
                                    DateTime.fromMillisecondsSinceEpoch(
                                        notes[index]['createdAt']
                                            .millisecondsSinceEpoch);
                                final createdAtFormatted =
                                    DateFormat('dd/MM/yyyy').format(createdAt);

                                return Card(
                                  child: InkWell(
                                    onTap: () {
                                      // Chuyển sang trang chi tiết khi click vào card
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         NoteDetailScreen(notes[index]),
                                      //   ),
                                      // );
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          title: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2.0, bottom: 4.0),
                                              child: Text(
                                                '${notes[index]['title']}',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )),
                                          subtitle: Text(
                                            '${notes[index]['content']}',
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          child: Text(
                                            '${createdAtFormatted}',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                      })),
            ],
          )),
    );
  }
}
