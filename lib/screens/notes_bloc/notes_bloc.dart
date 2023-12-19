import 'dart:async';

import 'package:dart/dto/notes_dto.dart';
import 'package:dart/main.dart';
import 'package:dart/server/rest_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesListBloc extends Bloc<NotesNetworkEvent, NotesListState> {
  final RestClient _networkRepository;

  NotesListBloc(this._networkRepository) : super(const NotesListState()) {
    on<RefreshEvent>(_onRefresh);
  }

  Future<void> _onRefresh(
    RefreshEvent event,
    Emitter<NotesListState> emit,
  ) async {
    final notes = await restClient!.getNoteList();
    emit(NotesListState(notesList: notes));
  }
}

class NotesAddBloc extends Bloc<NotesPatchAddEvent, NoteDtoState> {
  final RestClient _networkRepository;

  NotesAddBloc(this._networkRepository) : super(NoteDtoState()) {
    //todo переименоваит
    on<AddNoteEvent>(_onAddNote);
    on<PatchNoteEvent>(_onPatchNote);
  }

  Future<void> _onAddNote(
    AddNoteEvent event,
    Emitter<NoteDtoState> emit,
  ) async {
    //todo Переименовать state
    await restClient!.addNote(event.newNote);
  }

  //
  Future<void> _onPatchNote(
    PatchNoteEvent event,
    Emitter<NoteDtoState> emit,
  ) async {
    await restClient!.updateNote(event.note.id.toString(), event.note);
  }
}

class NotesDeleteBloc extends Bloc<DelNoteEvent, NoteDtoState> {
  final RestClient _networkRepository;

  NotesDeleteBloc(this._networkRepository) : super(NoteDtoState()) {
    on<DelNoteEvent>(_onDelNote);
  }

  Future<void> _onDelNote(
    DelNoteEvent event,
    Emitter<NoteDtoState> emit,
  ) async {
    await restClient!.removeNote(event.note.id.toString());
  }
}

class NotesPatchBloc extends Bloc<DelNoteEvent, NoteDtoState> {
  final RestClient _networkRepository;

  NotesPatchBloc(this._networkRepository) : super(NoteDtoState()) {
    on<DelNoteEvent>(_onPatchNote);
  }

  Future<void> _onPatchNote(
    DelNoteEvent event,
    Emitter<NoteDtoState> emit,
  ) async {
    await restClient!.updateNote(event.note.user_id.toString(), event.note);
  }
}
