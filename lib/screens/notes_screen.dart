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
  final List<Note> notes = [
    Note(
      id: 'p1',
      notebook: "1",
      title: 'Beginning Flutter With Dart',
      content:
          'You can learnaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa Flutter as well Dart. You can learn Flutter as well Dart.You can learn Flutter as well Dart.',
      createdAt: '30/3/2023',
      updatedAt: '30/3/2023',
    ),
  ];
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
      drawer: const DrawerBar(),
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
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: notes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: InkWell(
                            onTap: () {
                              // Chuyển sang trang chi tiết khi click vào card
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NoteDetailPage(id: '1'),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 2.0, bottom: 4.0),
                                      child: Text(
                                        '${notes[index].title}',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  subtitle: Text(
                                    '${notes[index].content}',
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Text(
                                    'Hôm qua',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }))
            ],
          )),
    );
  }
}
