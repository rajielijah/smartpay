import 'package:json_annotation/json_annotation.dart';

// import '../../domain/model/model.dart';

part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "code")
  String? code;
  @JsonKey(name: "message")
  String? message;
}


@JsonSerializable()
class ResponseDataResponse {
  @JsonKey(name: "pinId")
  String? pinId;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "to")
  String? to;
  @JsonKey(name: "smsStatus")
  String? smsStatus;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "verified")
  String? verified;

  ResponseDataResponse(this.pinId,this.message,this.to,this.smsStatus,this.status,this.verified);

// from json
  factory ResponseDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ResponseDataResponseFromJson(json);

// to json
  Map<String, dynamic> toJson() => _$ResponseDataResponseToJson(this);
}
@JsonSerializable()
class AuthenticationBaseResponse extends BaseResponse {
  @JsonKey(name: "data")
  AuthenticationResponse? data;
  @JsonKey(name: "expires_in")
  int? expiresIn;


  AuthenticationBaseResponse(this.data,this.expiresIn);

// from json
  factory AuthenticationBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationBaseResponseFromJson(json);

// to json
  Map<String, dynamic> toJson() => _$AuthenticationBaseResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "otpIsDisabled")
  bool? otpIsDisabled;
  @JsonKey(name: "userId")
  int? userId;
  @JsonKey(name: "otpSent")
  bool? otpSent;
  @JsonKey(name: "activationRequired")
  bool? activationRequired;
  @JsonKey(name: "responseData")
  ResponseDataResponse? responseData;

  AuthenticationResponse(this.otpIsDisabled,this.userId,this.otpSent,this.activationRequired,this.responseData);

// from json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

// to json
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}




