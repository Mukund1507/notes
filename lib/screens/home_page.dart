import 'package:flutter/material.dart';
import 'package:notes/screens/notes_list_page.dart';
import 'package:provider/provider.dart';

import '/models/note.dart';
import 'notes_page.dart';
import '/const.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void nextPage(BuildContext ctx, Priority priority) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) {
      return NotesListPage(priority: priority);
    }));
  }

  @override
  Widget build(BuildContext context) {
    final allNotes = Provider.of<Notes>(context, listen: true).notesList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: const Text('High priority'),
            trailing: IconButton(
              onPressed: () => nextPage(context, Priority.high),
              icon: const Icon(Icons.arrow_upward),
            ),
          ),
          const Divider(thickness: 2),
          ListTile(
            title: const Text('Neutral priority'),
            trailing: IconButton(
              onPressed: () => nextPage(context, Priority.neutral),
              icon: const Icon(Icons.arrow_forward),
            ),
          ),
          const Divider(thickness: 2),
          ListTile(
            title: const Text('Low priority'),
            trailing: IconButton(
              onPressed: () => nextPage(context, Priority.low),
              icon: const Icon(Icons.arrow_downward),
            ),
          ),
          const Divider(thickness: 2),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'All Notes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
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
          ),
        ],
      ),
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
