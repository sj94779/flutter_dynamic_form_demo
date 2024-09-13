import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../model/form_model.dart';

class DynamicFormOneViewModel extends ChangeNotifier {
  List<ResponseForm> formResponse = [];
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

  getFromJson(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/json/form.json");
    final jsonResult = jsonDecode(data);

    jsonResult
        .forEach((element) => formResponse.add(ResponseForm.fromJson(element)));

    isLoading = false;

    notifyListeners();
  }
}
