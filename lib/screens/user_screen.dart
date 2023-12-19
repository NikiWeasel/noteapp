import 'package:dart/dto/notes_dto.dart';
import 'package:dart/main.dart';
import 'package:dart/screens/notes_bloc/notes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

import 'note_screen.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class UserWidget extends StatefulWidget {
  final String user_id;

  const UserWidget(this.user_id);

  @override
  State<UserWidget> createState() => UserWidgetState();
}

class UserWidgetState extends State<UserWidget> {
  late final NotesListBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = NotesListBloc(restClient!);
  }

  List<NotesDto> getNotesList(NotesListState context, String userId) {
    final notesList =
        context.notesList.where((p) => p.user_id == userId).toList();
    return notesList;
  }

  void toNoteScreen(bool isNew, NotesDto? notesDto) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => NoteWidget(isNew, notesDto!)));
  }

  Widget getImage(String? baseString) {
    if (baseString != null && baseString != '') {
      return Image.memory(Base64.base64decode(baseString));
    } else {
      return Image.asset(
        'assets/images/file-icon.png',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _onRefresh();
    return BlocBuilder<NotesListBloc, NotesListState>(
      bloc: _bloc,
      builder: (context, snapshot) {
        final notesList =
            getNotesList(snapshot, widget.user_id).reversed.toList();
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.separated(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                return GFListTile(
                  avatar: SizedBox(
                    width: 80,
                    height: 80,
                    child: getImage(notesList[index].photo),
                  ),
                  // Image.asset('assets/images/cat.png',
                  //     width: 80, height: 80),
                  titleText: notesList[index].title,
                  subTitleText: 'Последнее изменение: ${notesList[index].date}',
                  description: Text(
                    notesList[index].content!,
                    maxLines: 2,
                  ),
                  onLongPress: () {
                    DialogHelper().openDialog(context, notesList[index]);
                    _onRefresh();
                  },
                  onTap: () {
                    toNoteScreen(false, notesList[index]);
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              toNoteScreen(
                true,
                NotesDto(
                  widget.user_id,
                  'New Note',
                  '',
                  DateFormat('dd.MM.yyyy').format(DateTime.now()),
                  '',
                ),
              );
              // _onRefresh();
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Future<void> _onRefresh() async {
    _bloc.add(RefreshEvent());
  }
}

class DialogHelper {
  final NotesDeleteBloc _bloc1 = NotesDeleteBloc(restClient!);

  Future<void> _onDelete(NotesDto note) async {
    _bloc1.add(DelNoteEvent(note));
  }

  Future openDialog(BuildContext context, NotesDto parameter) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Delete "${parameter.title}"',
          maxLines: 2,
        ),
        content: const Text('This this action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () {
              _onDelete(parameter);
              Navigator.of(context).pop();
            },
            child: const Text('Submit'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
