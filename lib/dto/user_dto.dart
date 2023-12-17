import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  String id = const Uuid().v4();
  String? username;
  String? email;
  String? password;

  UserDto(this.username, this.email, this.password);

  factory UserDto.fromJson(Map<String, dynamic> data) =>
      _$UserDtoFromJson(data);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

}
