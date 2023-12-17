import 'package:uuid/uuid.dart';

part 'notes_dto.g.dart';

class NotesDto {
  String? id = const Uuid().v4();
  String? user_id;
  String? title = 'New Note';
  String? content;
  String? date = DateTime.now().toString();
  String? photo;

  NotesDto(this.user_id, this.title, this.content, this.date, this.photo);


  factory NotesDto.fromJson(Map<String, dynamic> data) =>
      _$NotesDtoFromJson(data);

  Map<String, dynamic> toJson() => _$NotesDtoToJson(this);
}
