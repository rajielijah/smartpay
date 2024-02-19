class SignUp {
  SignUpData? data;
  String? message;
  bool? status;

  SignUp({this.data, this.message, this.status});

  SignUp.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? SignUpData.fromJson(json['data']) : null;
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

class SignUpData {
  int? token;
  SignUpData(
      {
      this.token,
      });

  SignUpData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
   }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}


class VerifyEmail {
  VerifyEmailData? data;
  String? message;
  bool? status;

  VerifyEmail({this.data, this.message, this.status});

  VerifyEmail.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? VerifyEmailData.fromJson(json['data']) : null;
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

class VerifyEmailData {
  String? email;
  VerifyEmailData(
      {
      this.email,
      });

  VerifyEmailData.fromJson(Map<String, dynamic> json) {
    email = json['email'];
   }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    return data;
  }
}

class Register {
  RegisterData? data;
  String? message;
  bool? status;

  Register({this.data, this.message, this.status});

  Register.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? RegisterData.fromJson(json['data']) : null;
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

class RegisterData {
  int? token;
  UserData? userData;
  RegisterData(
      {
      this.token,
      this.userData
      });

  RegisterData.fromJson(Map<String, dynamic> json) {
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


  UserData(
      {
      this.full_name, this.country, this.email, this.id, this.username
      });

  UserData.fromJson(Map<String, dynamic> json) {
    full_name = json['full_name'];
    username = json['username'];
    email = json['email'];
    country = json['country'];
    id = json['id'];

   }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['full_name'] = full_name;
    data['country'] = country;
    data['email'] = email;
    data['id'] = id;

    return data;
  }
}