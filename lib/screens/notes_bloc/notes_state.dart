part of 'notes_bloc.dart';

class NotesNetworkState {
  final List<NotesDto> notesList;

  const NotesNetworkState({
    this.notesList = const [],
  });
}

class NotesNetworkState1 {
  final NotesDto? note;

  NotesNetworkState1({this.note});
}
