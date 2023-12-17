part of 'notes_bloc.dart';

abstract class NotesNetworkEvent {
  const NotesNetworkEvent();
}

class RefreshEvent extends NotesNetworkEvent {}

class AddNoteEvent extends NotesNetworkEvent {
  NotesDto newNote;

  AddNoteEvent(this.newNote);
}

class DelNoteEvent extends NotesNetworkEvent {
  //todo поменять название чтобы типо и del и remove
  NotesDto note;

  DelNoteEvent(this.note);
}
