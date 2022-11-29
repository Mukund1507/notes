import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/note.dart';
import 'screens/home_page.dart';
import 'screens/notes_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Notes(),
      child: MaterialApp(
        title: 'Notes',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
        routes: {
          NotePage.routeName: (ctx) => const NotePage(),
        },
      ),
    );
  }
}
