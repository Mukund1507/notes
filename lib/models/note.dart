class Note {
  final String id;
  String title;
  final String body;
  Note({required this.id, this.title = '', required this.body});
}

class Notes {
  List<Note> notesList = [
    Note(id: 'Id1', body: 'My name is Mukund Sharma.', title: 'Intro'),
  ];
}
