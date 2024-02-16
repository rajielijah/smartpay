// extension on String


import '../data/mapper/mapper.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return EMPTY;
    } else {
      return this!;
    }
  }
}

// extension on Integer

extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return ZERO;
    } else {
      return this!;
    }
  }
}

extension NonNullBoolean on bool? {
  bool orBooless() {
    if (this == null) {
      return false;
    } else {
      return this!;
    }
  }
}

extension StringExtension on String {
  String get addOverFlow {
    if (length < 25) {
      return this;
    } else {
      return "${substring(0, 25)}...";
    }
  }
}
