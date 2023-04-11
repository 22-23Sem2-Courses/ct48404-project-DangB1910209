import 'package:flutter/material.dart';
import 'package:my_note/main.dart';
import '../screens/notes_screen.dart';

class DrawerBar extends StatelessWidget {
  const DrawerBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 80.0,
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
        ],
      ),
    );
  }
}
