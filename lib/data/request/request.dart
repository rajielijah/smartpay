
class LoginRequest {
  String email;
  String password;
  String device_name;

  LoginRequest(this.email, this.password, this.device_name);
}

class EmailRequest {
  String email;

  EmailRequest(this.email);
}

class VerifyEmailRequest {
  String email;
  String token;

  VerifyEmailRequest(this.email, this.token);
}

class RegisterRequest {
  String full_name;
  String email;
  String password;
  String device_name;
  String username;
  String country;

  RegisterRequest(this.email, this.password, this.device_name, this.country, this.full_name, this.username);
}

class OtpRequest {
  String otp;
  String pinId;
  String userId;
  String organizationId;
  int roleId;
  String otpVia;
  String device_name;

  OtpRequest(this.otp, this.pinId, this.userId, this.organizationId, this.roleId, this.otpVia,this.device_name);
}
class OtpRequestEmail {
  String otp;
  String userId;
  String organizationId;
  int roleId;
  String otpVia;
  String device_name;

  OtpRequestEmail(this.otp,this.userId, this.organizationId, this.roleId, this.otpVia,this.device_name);
}

class ForgotPasswordRequest{
  String email;
  String otpVia;
  int roleId;

  ForgotPasswordRequest(this.email,this.otpVia,this.roleId);
}