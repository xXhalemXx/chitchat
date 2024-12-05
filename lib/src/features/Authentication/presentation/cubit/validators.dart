class Validators {
  String? nameValidator(String? value) {
    final validCharacters = RegExp(r'[a-zA-Z0-9._]');
    if (value == null || value.isEmpty || value == '') {
      return 'You need to fill this field';
    } else if (!validCharacters.hasMatch(value)) {
      return 'Enter valid name';
    }
    return null;
  }

  String? emailValidator(String? value) {
    final validCharacters = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value == null || value.isEmpty || value == '') {
      return 'You need to fill this field';
    } else if (!validCharacters.hasMatch(value)) {
      return 'Enter valid email address';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty || value == '') {
      return 'You need to fill this field';
    } else if (value.length < 6) {
      return 'Too short password';
    }
    return null;
  }

  String? conformPasswordValidator(String? firstPass, String? secondPass) {
    if (secondPass == null || secondPass.isEmpty || secondPass == '') {
      return 'You need to fill this field';
    } else {
      if (firstPass != secondPass) {
        return 'passwords do not match';
      } else {
        return null;
      }
    }
  }
}
