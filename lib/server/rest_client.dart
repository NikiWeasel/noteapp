import 'package:dart/dto/notes_dto.dart';
import 'package:dart/dto/user_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET('users/')
  Future<List<UserDto>> getUserList(); //todo login?

  @POST('users/')
  Future<void> addUser(@Body() UserDto dto);

  @GET('notes_list/')
  Future<List<NotesDto>> getNoteList();

  @POST('notes_list/')
  Future<void> addNote(@Body() NotesDto dto);

  @DELETE('notes_list/{id}/')
  Future<void> removeNote(@Path('id') String id);

  @PATCH('notes_list/{id}/')
  Future<void> updateNote(@Path('id') String id, @Body() NotesDto dto);
}
