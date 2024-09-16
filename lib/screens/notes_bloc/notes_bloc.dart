import 'dart:async';

import 'package:dart/dto/notes_dto.dart';
import 'package:dart/main.dart';
import 'package:dart/server/rest_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesListBloc extends Bloc<NotesNetworkEvent, NotesNetworkState> {
  final RestClient _networkRepository;

  NotesListBloc(this._networkRepository) : super(const NotesNetworkState()) {
    on<RefreshEvent>(_onRefresh);
  }

  Future<void> _onRefresh(
    RefreshEvent event,
    Emitter<NotesNetworkState> emit,
  ) async {
    final notes = await restClient!.getNoteList();
    emit(NotesNetworkState(notesList: notes));
  }
}

class NotesAddBloc extends Bloc<AddNoteEvent, NotesNetworkState1> {
  final RestClient _networkRepository;

  NotesAddBloc(this._networkRepository) : super(NotesNetworkState1()) {
    on<AddNoteEvent>(_onAddNote);
  }

  Future<void> _onAddNote(
    AddNoteEvent event,
    Emitter<NotesNetworkState1> emit,
  ) async {
    //todo Переименовать state
    await restClient!.addNote(event.newNote);
  }
}

class NotesDeleteBloc extends Bloc<DelNoteEvent, NotesNetworkState1> {
  final RestClient _networkRepository;

  NotesDeleteBloc(this._networkRepository) : super(NotesNetworkState1()) {
    on<DelNoteEvent>(_onDelNote);
  }

  Future<void> _onDelNote(
    DelNoteEvent event,
    Emitter<NotesNetworkState1> emit,
  ) async {
    await restClient!.removeNote(event.note.id.toString());
  }
}

class NotesPatchBloc extends Bloc<DelNoteEvent, NotesNetworkState1> {
  final RestClient _networkRepository;

  NotesPatchBloc(this._networkRepository) : super(NotesNetworkState1()) {
    on<DelNoteEvent>(_onDelNote);
  }

  Future<void> _onDelNote(
    DelNoteEvent event,
    Emitter<NotesNetworkState1> emit,
  ) async {
    await restClient!.updateNote(event.note.user_id.toString(), event.note);
  }
}
