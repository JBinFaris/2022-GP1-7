import 'package:flutter/cupertino.dart';

class DropDownProvider extends ChangeNotifier {
  String? _selectCity;


  String? get getCity => _selectCity;



  void setCity(String data) {
    _selectCity = data;
    notifyListeners();
  }


}
