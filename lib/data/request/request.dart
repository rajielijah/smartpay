
class LoginRequest {
  String email;
  String password;
  String device_name;

  LoginRequest(this.email, this.password, this.device_name);
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