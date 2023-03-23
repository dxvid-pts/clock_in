
enum ErrorCode {
  noInternet,
  emailInUse,
  emailInvalid,
  badPasswordLength,
  nameInvalid,
  badNameLength,
  invalidCredentials,
  unknown,
}

extension ErrorCodeMessage on ErrorCode {
  bool isEmailSpecific() {
    return this == ErrorCode.emailInUse || this == ErrorCode.emailInvalid;
  }

  bool isPasswordSpecific() {
    return this == ErrorCode.badPasswordLength;
  }

  bool isUsernameSpecific() {
    return this == ErrorCode.nameInvalid || this == ErrorCode.badNameLength;
  }

  bool isGeneral() {
    return !isEmailSpecific() && !isPasswordSpecific() && !isUsernameSpecific();
  }

  String get message {
    switch (this) {
      case ErrorCode.noInternet:
        return "No internet connection";
      case ErrorCode.emailInUse:
        return "Email already in use";
      case ErrorCode.badPasswordLength:
        return "The length must be between 8 and 72.";
      case ErrorCode.emailInvalid:
        return "Please enter a valid email";
      case ErrorCode.nameInvalid:
        return "Please enter a valid name";
      case ErrorCode.badNameLength:
        return "The length must be between 3 and 150.";
      case ErrorCode.invalidCredentials:
        return "Invalid login credentials";
      case ErrorCode.unknown:
        return "An error occurred";
    }
  }
}
