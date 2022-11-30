import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/note.dart';
import 'notes_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final allNotes = Provider.of<Notes>(context, listen: true).notesList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: ListView.builder(
          itemCount: allNotes.length,
          itemBuilder: (ctx, index) {
            return Column(
              children: [
                ListTile(
                  title: Text(allNotes[index].title),
                  subtitle: Text(allNotes[index].body),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        NotePage.routeName,
                        arguments: allNotes[index],
                      );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ),
                const Divider(thickness: 2),
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            NotePage.routeName,
            arguments: Note(
              id: DateTime.now().toString(),
              title: '',
              body: '',
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
