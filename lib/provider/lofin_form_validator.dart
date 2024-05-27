import 'package:flutter/material.dart';

class LoginFormValidator extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  bool? correctCredentials;

  String email = '';
  String password = '';

  bool _isLoading = false;

  //modifica el valor de isLoading a partir del valo passat per paràmetre.
  //Un cop modificat valor s'envia una notificació a totes les classes que fan servir LoginFormProvider
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //Comproba si formKey retorna un valor valid. Si és valid la funció retorna true, si no retorna false
  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  //Modifica el valor de correctCredentials a partir del valor passat per paràmetre.
  //Al final ntifica a totes les classes que utilitzin LoginFFormProvider
  void updateCorrectCredentials(bool? correctCredentials) {
    this.correctCredentials = correctCredentials;

    notifyListeners();
  }
}
