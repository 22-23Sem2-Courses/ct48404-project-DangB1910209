import 'package:flutter/material.dart';

class SortOptions extends StatefulWidget {
  const SortOptions({super.key});

  @override
  _SortOptionsState createState() => _SortOptionsState();
}

class _SortOptionsState extends State<SortOptions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: const BoxDecoration(
              border: Border(
            top: BorderSide(
              //                   <--- left side
              color: Color.fromRGBO(160, 160, 160, 1),
              width: 1.0,
            ),
          )),
          child: ListTile(
            tileColor: const Color.fromRGBO(242, 242, 242, 1),
            dense: true,
            visualDensity: const VisualDensity(vertical: -1),
            title: const Text('Ngày cập nhật'),
            onTap: () {},
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              border: Border(
            top: BorderSide(
              //                   <--- left side
              color: Color.fromRGBO(160, 160, 160, 1),
              width: 1.0,
            ),
          )),
          child: ListTile(
            tileColor: const Color.fromRGBO(242, 242, 242, 1),
            dense: true,
            visualDensity: const VisualDensity(vertical: -1),
            title: const Text('Ngày tạo'),
            onTap: () {},
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              border: Border(
            top: BorderSide(
              //                   <--- left side
              color: Color.fromRGBO(160, 160, 160, 1),
              width: 1.0,
            ),
          )),
          child: ListTile(
            tileColor: const Color.fromRGBO(242, 242, 242, 1),
            dense: true,
            visualDensity: const VisualDensity(vertical: -1),
            title: const Text('Tiêu đề'),
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
