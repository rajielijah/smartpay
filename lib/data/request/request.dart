
class LoginRequest {
  String email;
  String password;
  String deviceToken;

  LoginRequest(this.email, this.password, this.deviceToken);
}

class OtpRequest {
  String otp;
  String pinId;
  String userId;
  String organizationId;
  int roleId;
  String otpVia;
  String deviceToken;

  OtpRequest(this.otp, this.pinId, this.userId, this.organizationId, this.roleId, this.otpVia,this.deviceToken);
}
class OtpRequestEmail {
  String otp;
  String userId;
  String organizationId;
  int roleId;
  String otpVia;
  String deviceToken;

  OtpRequestEmail(this.otp,this.userId, this.organizationId, this.roleId, this.otpVia,this.deviceToken);
}

class ForgotPasswordRequest{
  String email;
  String otpVia;
  int roleId;

  ForgotPasswordRequest(this.email,this.otpVia,this.roleId);
}