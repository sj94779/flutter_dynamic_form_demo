String? emailValidator(String? arg) {
  if (arg == null || arg.isEmpty) {
    return 'error empty email address';
  }

  Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern.toString());
  if (!regex.hasMatch(arg)) {
    return 'error invalid email address';
  }
  return null;
}


String? passwordValidator(String? arg) {
  if (arg == null || arg.isEmpty) {
    return 'error empty password';
  }
  if (arg.length < 8) {
    return 'error password length';
  }

  // String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[! \" # . @ _ ` ~ $ % ^ * : , ; | -]).{6,}$';
  // RegExp regExp = RegExp(pattern);
  // if (!regExp.hasMatch(arg)) {
  //   return 'error invalid password';
  // }
  return null;
}
