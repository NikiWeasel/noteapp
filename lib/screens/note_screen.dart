import 'dart:convert';
import 'dart:typed_data';

import 'package:dart/screens/notes_bloc/notes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
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

  @override
  void initState() {
    super.initState();
    _bloc = NotesAddBloc(restClient!);
  }

  Future<String> imagePicker() async {
    ImagePicker picker = ImagePicker();
    XFile? fileData = await picker.pickImage(source: ImageSource.gallery);

    // if (fileData=!null){return;}

    var imageBytes = await fileData?.readAsBytes();
    // print(imageBytes);
    String base64Image = base64Encode(imageBytes!);
    return base64Image;
    // Fluttertoast.showToast(
    //     msg: base64Image,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //     fontSize: 16.0
    // );
  }

  void saveNote(NotesDto newNote) {
    if (newNote != widget.note) {
      //todo ????
      if (widget.isNew) {
        _addNote(newNote);
      } else {
        // _patchNote();//todo редактирование ААААА
      }
    }
  }

  void _addNote(NotesDto newNote) {
    _bloc.add(AddNoteEvent(newNote));
  }

  // Future<void> _patchNote() async {//todo patch
  //   _bloc.add();
  // }

  Uint8List base64decode(String base64String) {
    var uint8image = const Base64Decoder().convert(base64String);
    return uint8image;
  }

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: widget.note.title);
    final contentController = TextEditingController(text: widget.note.content);
    return BlocBuilder<NotesAddBloc, NotesNetworkState1>(
      bloc: _bloc,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextField(
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        autofocus: false,
                        maxLines: null,
                        controller: titleController),
                    Text('Последнее изменение: ${widget.note.date.toString()}'),
                    SizedBox(
                      height: 500,
                      child: TextField(
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(border: InputBorder.none),
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
                      '',
                    );
                    saveNote(newNote); //const Icon(Icons.file_copy_outlined)
                  },
                  child: const Icon(Icons.file_copy_outlined),
                ),
              ),
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  imagePicker();
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

void imagePicker() async {
  ImagePicker picker = ImagePicker();
  XFile? fileData = await picker.pickImage(source: ImageSource.gallery);
  // if (fileData=!null){return;}

  var imageBytes = await fileData?.readAsBytes();
  // print(imageBytes);
  String base64Image = base64Encode(imageBytes!);
  print(base64Image);
  // Fluttertoast.showToast(
  //     msg: base64Image,
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.CENTER,
  //     timeInSecForIosWeb: 1,
  //     backgroundColor: Colors.red,
  //     textColor: Colors.white,
  //     fontSize: 16.0
  // );
}
