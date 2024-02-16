class EmailLogin {
  Data? data;
  String? message;
  String? code;
  int? expiresIn;

  EmailLogin({this.data, this.message, this.code, this.expiresIn});

  EmailLogin.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['code'] = code;
    data['expires_in'] = expiresIn;
    return data;
  }
}

class Data {
  bool? otpIsDisabled;
  int? userId;
  bool? otpSent;
  bool? activationRequired;

  Data({this.otpIsDisabled,this.userId, this.otpSent, this.activationRequired});

  Data.fromJson(Map<String, dynamic> json) {
    otpIsDisabled = json['otpIsDisabled'];
    userId = json['userId'];
    otpSent = json['otpSent'];
    activationRequired = json['activationRequired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['otpIsDisabled'] = otpIsDisabled;
    data['userId'] = userId;
    data['otpSent'] = otpSent;
    data['activationRequired'] = activationRequired;
    return data;
  }
}
