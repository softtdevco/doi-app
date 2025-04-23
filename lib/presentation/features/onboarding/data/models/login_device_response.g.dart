// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_device_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginDeviceResponse _$LoginDeviceResponseFromJson(Map<String, dynamic> json) =>
    LoginDeviceResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      code: (json['code'] as num?)?.toInt(),
      returnStatus: json['returnStatus'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginDeviceResponseToJson(
        LoginDeviceResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'code': instance.code,
      'returnStatus': instance.returnStatus,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      token: json['token'] as String?,
      user: json['user'] == null
          ? null
          : DoiUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };

DoiUser _$DoiUserFromJson(Map<String, dynamic> json) => DoiUser(
      deviceId: json['deviceID'] as String? ?? '',
      username: json['username'] as String? ?? '',
      country: json['country'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
      notification: json['notification'] as List<dynamic>? ?? [],
      id: json['_id'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
      v: (json['__v'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$DoiUserToJson(DoiUser instance) => <String, dynamic>{
      'deviceID': instance.deviceId,
      'username': instance.username,
      'country': instance.country,
      'avatar': instance.avatar,
      'notification': instance.notification,
      '_id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };
