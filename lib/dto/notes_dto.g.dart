part of 'notes_dto.dart';

NotesDto _$NotesDtoFromJson(Map<String, dynamic> data) => NotesDto(
      data['user_id'] as String,
      data['title'] as String?,
      data['content'] as String?,
      data['date'] as String?,
      data['photo'] as String?,
    )..id = data['id'] as String;

Map<String, dynamic> _$NotesDtoToJson(NotesDto instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'title': instance.title,
      'content': instance.content,
      'date': instance.date,
      'photo': instance.photo,
    };
