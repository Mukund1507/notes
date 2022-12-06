import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'notes_page.dart';
import '/models/note.dart';
import '/const.dart';

class NotesListPage extends StatelessWidget {
  final Priority priority;
  const NotesListPage({super.key, required this.priority});

  void showPasswordField(BuildContext ctx, Note note) {
    final TextEditingController passwordController = TextEditingController();
    showDialog(
      context: ctx,
      builder: ((context) => AlertDialog(
            actions: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Enter Password',
                  style: TextStyle(
                      fontSize: 20, color: Theme.of(context).primaryColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    suffixIcon: Icon(Icons.remove_red_eye),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 30),
                    ElevatedButton(
                      onPressed: () {
                        if (note.password == passwordController.text) {
                          Navigator.pop(context);
                          Navigator.pushNamed(
                            context,
                            NotePage.routeName,
                            arguments: note,
                          );
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

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
                    if (allNotes[index].password == null) {
                      Navigator.pushNamed(
                        context,
                        NotePage.routeName,
                        arguments: allNotes[index],
                      );
                    } else {
                      showPasswordField(
                        context,
                        allNotes[index],
                      );
                    }
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
              const Divider(thickness: 2),
            ],
          );
        },
      ),
    );
  }
}
