import 'package:flutter/material.dart';
import 'package:my_note/screens/home_screen.dart';
import 'package:my_note/screens/trash_screen.dart';
import '../screens/notes_screen.dart';

class DrawerBar extends StatelessWidget {
  const DrawerBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 60.0,
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
            ),
            title: const Text('Trang chủ'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.description,
            ),
            title: const Text('Ghi chú'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NotePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.delete,
            ),
            title: const Text('Thùng rác'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TrashPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
