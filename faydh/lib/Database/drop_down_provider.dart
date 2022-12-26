import 'package:flutter/cupertino.dart';

class DropDownProvider extends ChangeNotifier {
  String? _selectCity;
  String? _selectNigbehood;

  String? get getCity => _selectCity;
  String? get getNigbehood => _selectNigbehood;

  void setCity(String data) {
    _selectCity = data;
    notifyListeners();
  }

  void setNigbehood(String data) {
    _selectNigbehood = data;
    notifyListeners();
  }

  void clear() {
    _selectCity = '';
    notifyListeners();
  }
}
