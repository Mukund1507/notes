import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'notes_page.dart';
import '/models/note.dart';
import '/const.dart';

class NotesListPage extends StatelessWidget {
  final Priority priority;
  const NotesListPage({super.key, required this.priority});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Notes>(context);
    final allNotes = (priority == Priority.high)
        ? provider.highPriorityNotesList
        : (priority == Priority.low)
            ? provider.lowPriorityNotesList
            : provider.neutralPriorityNotesList;
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
    );
  }
}
