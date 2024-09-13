import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DynamicFormTwoViewModel extends ChangeNotifier {
 // List<ResponseForm> formResponse = [];
  List<dynamic> fields = [];
  Map<String, dynamic> formData = {};

  bool isLoading = true;
  var dropdownvalue;
  var dateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  int groupValue = 0;

  bool _switchValue = false;

  bool get switchValue {
    return _switchValue;
  }

  set switchValue(bool value) {
    _switchValue = value;
    notifyListeners();
  }

  bool _isChecked = false;

  bool get isChecked {
    return _isChecked;
  }

  set isChecked(bool value) {
    _isChecked = value;
    notifyListeners();
  }

  bool _obscurePassword = true;

  bool get obscurePassword => _obscurePassword;

  void onPasswordVisibilityTap() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  loadFormFields() {


    // Example JSON data; in a real app, you might load this from an API
    String jsonString = '''
    {
      "fields": [
        {
          "type": "text",
          "label": "Name",
          "key": "name",
          "placeholder": "Enter your name"
        },
        {
          "type": "email",
          "label": "Email",
          "key": "email",
          "placeholder": "Enter your email"
        },
        {
          "type": "password",
          "label": "Password",
          "key": "password",
          "placeholder": "Enter your password"
        },
        {
          "type": "dropdown",
          "label": "Country",
          "key": "country",
          "options": ["USA", "Canada", "UK"]
        },
        {
          "type": "checkbox",
          "label": "I agree to the terms and conditions",
          "key": "terms"
        },
        {
          "type": "radio",
          "label": "Gender",
          "key": "gender",
          "options": ["Male", "Female", "Other"]
        }
      ]
    }
    ''';

    var jsonData = jsonDecode(jsonString);
     fields = jsonData['fields'];

   notifyListeners();
  }


}
