part of 'notes_bloc.dart';

abstract class NotesNetworkEvent {
  const NotesNetworkEvent();
}

abstract class NotesPatchAddEvent {
  const NotesPatchAddEvent();
}

class RefreshEvent extends NotesNetworkEvent {}

class AddNoteEvent extends NotesPatchAddEvent {
  NotesDto newNote;

  AddNoteEvent(this.newNote);
}

class PatchNoteEvent extends NotesPatchAddEvent {
  NotesDto note;

  PatchNoteEvent(this.note);
}

class DelNoteEvent extends NotesNetworkEvent {
  //todo поменять название чтобы типо и del и patch
  NotesDto note;

  DelNoteEvent(this.note);
}
