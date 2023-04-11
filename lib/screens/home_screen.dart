import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_note/components/drawer_bar.dart';
import 'package:my_note/widgets/backgroud_home.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The title text which will be shown on the action bar
        title: const Text('Trang chủ'),
      ),
      drawer: const DrawerBar(),
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collectionGroup('notes')
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (!snapshot.hasData) {
                  return const Center(child: Text('Không có ghi chú nào'));
                } else {
                  return Row(
                    children: List.generate(
                      snapshot.data!.docs.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SizedBox(
                          width: 160,
                          height: 240,
                          child: Card(
                            child: InkWell(
                              onTap: () {},
                              child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'note.title',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Expanded(
                                        child: Text(
                                          'content',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 5,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        '16/2',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            )),
          ),
        ],
      ),
    );
  }
}
