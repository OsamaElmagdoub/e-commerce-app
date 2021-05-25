import 'package:flutter/cupertino.dart';

class ModalHud extends ChangeNotifier{

  bool isloading = false;
  changeinloading(bool value){

isloading = value;
notifyListeners();
  }

}