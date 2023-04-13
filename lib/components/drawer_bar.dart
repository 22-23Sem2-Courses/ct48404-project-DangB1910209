import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_note/screens/home_screen.dart';
import 'package:my_note/services/auth.dart';
import '../screens/notes_screen.dart';

class DrawerBar extends StatelessWidget {
  DrawerBar({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;

  Future<>

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 140.0,
            child: DrawerHeader(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.brown.shade800,
                    child: const Text('V'),
                  ),
                  const Padding(
                    child: Text("vatcmnvo@gmail.com"),
                    padding: EdgeInsets.only(left: 10.0),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
            ),
            title: const Text('Trang chủ'),
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
              )
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.description,
            ),
            title: const Text('Ghi chú'),
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NotePage()),
              )
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.delete,
            ),
            title: const Text('Thùng rác'),
            onTap: () => print('on tap'),
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
            ),
            title: const Text('Đăng xuất'),
            onTap: () => print('on tap'),
          ),
        ],
      ),
    );
  }
}
