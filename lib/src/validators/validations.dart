class Validations {
  static bool isValidUser(String user) {
    return user.length >= 12 && user.contains("@gmail.com");
  }

  static bool isValidPass(String pass) {
    return validatePassword(pass);
  }
}

bool validatePassword(String password) {
  final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}$');
  return regex.hasMatch(password);
}
