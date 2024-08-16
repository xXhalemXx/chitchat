class Validators {
  static String? nameValidator(String? value) {
    final validCharacters = RegExp(r'[a-zA-Z0-9._]');
    if (value == null || value.isEmpty || value == '') {
      return 'You need to fill this field';
    } else if (!validCharacters.hasMatch(value)) {
      return 'Enter valid name';
    }
    return null;
  }

  static String? emailValidator(String? value) {
    final validCharacters = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value == null || value.isEmpty || value == '') {
      return 'You need to fill this field';
    } else if (!validCharacters.hasMatch(value)) {
      return 'Enter valid email address';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty || value == '') {
      return 'You need to fill this field';
    } else if (value.length < 6) {
      return 'Too short password';
    }
    return null;
  }
}
