import 'package:flutter/material.dart';
import '../components/drawer_bar.dart';
import '../screens/notes_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hello World',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const MyHomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/notes': (context) => NotePage(),
      },
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The title text which will be shown on the action bar
        title: Text('Trang chủ'),
      ),
      drawer: new DrawerBar(),
      body: Center(
        child: Text(
          'Hello, World!',
        ),
      ),
    );
  }
}
