part of 'user_dto.dart';

UserDto _$UserDtoFromJson(Map<String, dynamic> data) => UserDto(
      // data['id'] as String,
      data['username'] as String?,
      data['email'] as String?,
      data['password'] as String?,
    )..id = data['id'] as String;

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
    };
