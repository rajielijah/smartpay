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

class LoginModel {
  LoginData? data;
  String? message;
  bool? status;

  LoginModel({this.data, this.message, this.status});

  LoginModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class LoginData {
  String? token;
  UserData? userData;
  LoginData(
      {
      this.token,
      this.userData
      });

  LoginData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
     userData = json['data'] != null ? UserData.fromJson(json['data']) : null;
   }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
      if (this.userData != null) {
      data['data'] = this.userData!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class UserData {
  String? full_name;
  String? username;
  String? email;
  String? country;
  String? id;
  String? phone;
  String? phone_country;
  String? avatar;

  UserData(
      {
      this.full_name, this.country, this.email, this.id, this.username,
      this.avatar, this.phone, this.phone_country
      });

  UserData.fromJson(Map<String, dynamic> json) {
    full_name = json['full_name'];
    username = json['username'];
    email = json['email'];
    country = json['country'];
    id = json['id'];
    phone = json['phone'];

    phone_country = json['phone_country'];
    avatar = json['avatar'];


   }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['full_name'] = full_name;
    data['country'] = country;
    data['email'] = email;
    data['id'] = id;
    data['phone'] = phone;
    data['avatar'] = avatar;
    data['phone_country'] = phone_country;


    return data;
  }
}