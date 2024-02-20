
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

