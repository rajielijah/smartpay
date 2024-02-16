
import 'package:freezed_annotation/freezed_annotation.dart';


part 'freezed_data_class.freezed.dart';




@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String email, String password) = _LoginObject;
}

// @freezed
// class OtpObject with _$OtpObject{
//   factory OtpObject(String otp, String otpVia) = _OtpObject;
// }2