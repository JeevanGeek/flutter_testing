class Validator {
  String? validateEmail(String? value) {
    return value == null || !value.contains('@') ? 'Invalid email' : null;
  }

  String? validatePassword(String? value) {
    return value == null || value.length < 8 ? 'Short password' : null;
  }
}
