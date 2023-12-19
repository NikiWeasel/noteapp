part of 'notes_bloc.dart';

class NotesListState {
  final List<NotesDto> notesList;

  const NotesListState({
    this.notesList = const [],
  });
}

class NoteDtoState {
  final NotesDto? note;

  NoteDtoState({this.note});
}
