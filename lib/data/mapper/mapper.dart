

// ignore_for_file: constant_identifier_names, unused_import


import 'package:smartpay/app/extensions.dart';

import '../../domain/model/model.dart';
import '../responses/responses.dart';

const EMPTY = "";
const ZERO = 0;


extension ResponseDataMapper on ResponseDataResponse? {
  ResponseData toDomain() {
    return ResponseData(this?.pinId?.orEmpty() ?? EMPTY,
        this?.message?.orEmpty() ?? EMPTY, this?.to?.orEmpty() ?? EMPTY,
        this?.smsStatus?.orEmpty() ?? EMPTY,
        this?.status?.orEmpty() ?? EMPTY, this?.verified?.orEmpty() ?? EMPTY);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
        this?.otpIsDisabled.orBooless() ?? false,this?.userId?.orZero() ?? ZERO, this?.otpSent?.orBooless() ?? false, this?.activationRequired?.orBooless() ?? false, this?.responseData?.toDomain());
  }
}

extension AuthenticationBaseResponseMapper on AuthenticationBaseResponse? {
  AuthenticationBase toDomain() {
    return AuthenticationBase(
        this?.data?.toDomain(),
        this?.expiresIn?.orZero() ?? ZERO);
  }
}


