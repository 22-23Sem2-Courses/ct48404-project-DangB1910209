import 'package:flutter/material.dart';
import 'package:my_note/models/note_model.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_note/screens/home_screen.dart';
import 'package:my_note/screens/trash_screen.dart';
import '../screens/notes_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NoteModel>(
            create: (contenxt) => NoteModel()..fetchNotes())
      ],
      child: MaterialApp(
        title: 'Flutter Hello World',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/",
        routes: {
          '/': (context) => const MyHomePage(),
          '/notes': (context) => NotePage(),
          '/trash': (context) => TrashPage(),
        },
      ),
    );
  }
}
