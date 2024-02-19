class ResponseData {
  String pinId;
  String message;
  String to;
  String smsStatus;
  String status;
  String verified;

  ResponseData(this.pinId,this.message,this.to,this.smsStatus,this.status,this.verified);
}
class AuthenticationBase{
  Authentication? data;
  int? expiresIn;

  AuthenticationBase(this.data,this.expiresIn);
}

class Authentication {
  bool? otpIsDisabled;
  int userId;
  bool otpSent;
  bool activationRequired;
  ResponseData? responseData;

  Authentication(this.otpIsDisabled,this.userId,this.otpSent,this.activationRequired,this.responseData);
}

class SliderObject {
  String title;
  String subtitle;
  String image;
  String image1;


  SliderObject(this.title, this.image, this.subtitle, this.image1);
}