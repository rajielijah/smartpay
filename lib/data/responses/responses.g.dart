// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse()
  ..code = json['code'] as String?
  ..message = json['message'] as String?;

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };

ResponseDataResponse _$ResponseDataResponseFromJson(
        Map<String, dynamic> json) =>
    ResponseDataResponse(
      json['pinId'] as String?,
      json['message'] as String?,
      json['to'] as String?,
      json['smsStatus'] as String?,
      json['status'] as String?,
      json['verified'] as String?,
    );

Map<String, dynamic> _$ResponseDataResponseToJson(
        ResponseDataResponse instance) =>
    <String, dynamic>{
      'pinId': instance.pinId,
      'message': instance.message,
      'to': instance.to,
      'smsStatus': instance.smsStatus,
      'status': instance.status,
      'verified': instance.verified,
    };

AuthenticationBaseResponse _$AuthenticationBaseResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticationBaseResponse(
      json['data'] == null
          ? null
          : AuthenticationResponse.fromJson(
              json['data'] as Map<String, dynamic>),
      json['expires_in'] as int?,
    )
      ..code = json['code'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AuthenticationBaseResponseToJson(
        AuthenticationBaseResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
      'expires_in': instance.expiresIn,
    };

AuthenticationResponse _$AuthenticationResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticationResponse(
      json['otpIsDisabled'] as bool?,
      json['userId'] as int?,
      json['otpSent'] as bool?,
      json['activationRequired'] as bool?,
      json['responseData'] == null
          ? null
          : ResponseDataResponse.fromJson(
              json['responseData'] as Map<String, dynamic>),
    )
      ..code = json['code'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'otpIsDisabled': instance.otpIsDisabled,
      'userId': instance.userId,
      'otpSent': instance.otpSent,
      'activationRequired': instance.activationRequired,
      'responseData': instance.responseData,
    };
