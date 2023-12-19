import 'package:dart/screens/notes_bloc/notes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../dto/notes_dto.dart';
import '../main.dart';

class NoteWidget extends StatefulWidget {
  final NotesDto note;
  final bool isNew;

  const NoteWidget(this.isNew, this.note);

  @override
  State<NoteWidget> createState() => Note_screen();
}

class Note_screen extends State<NoteWidget> {
  late final NotesAddBloc _bloc;

  // String? imageString;
  final base64 = Base64();
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _bloc = NotesAddBloc(restClient!);
    setPictureVisibility(widget.note.photo!);
  }

  void saveNote(NotesDto newNote) {
    if (newNote != widget.note) {
      if (widget.isNew) {
        _addNote(newNote);
      } else {
        newNote.id = widget.note.id;
        _patchNote(newNote);
      }
    }
  }

  void setPictureVisibility(String? image) {
    if (image != null && image != '') {
      setState(() {
        _isVisible = true;
      });
    } else {
      _isVisible = false;
    }
  }

  void _addNote(NotesDto newNote) {
    _bloc.add(AddNoteEvent(newNote));
  }

  Future<void> _patchNote(NotesDto newNote) async {
    _bloc.add(PatchNoteEvent(newNote));
  }

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: widget.note.title);
    final contentController = TextEditingController(text: widget.note.content);
    return BlocBuilder<NotesAddBloc, NoteDtoState>(
      bloc: _bloc,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Visibility(
                        visible: _isVisible,
                        child: SizedBox(
                          width: 320,
                          height: 250,
                          child: Image.memory(
                              Base64.base64decode(widget.note.photo!)),
                        )),
                    TextField(
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        autofocus: false,
                        maxLines: 1,
                        controller: titleController),
                    Text('Последнее изменение: ${widget.note.date.toString()}'),
                    SizedBox(
                      height: 500,
                      child: TextField(
                          keyboardType: TextInputType.multiline,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          autofocus: true,
                          maxLines: null,
                          controller: contentController),
                    ),
                  ]),
            ),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                child: FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    final newNote = NotesDto(
                      widget.note.user_id,
                      titleController.text,
                      contentController.text,
                      DateFormat('dd.MM.yyyy').format(DateTime.now()),
                      widget.note.photo,
                    );
                    saveNote(newNote);
                  },
                  child: const Icon(Icons.file_copy_outlined),
                ),
              ),
              FloatingActionButton(
                heroTag: null,
                onPressed: () async {
                  final res = await base64.imagePicker();
                  widget.note.photo = res;
                  setPictureVisibility(widget.note.photo);
                },
                child: const Icon(Icons.image),
              ),
            ],
          ),
        );
      },
    );
  }
}
