import 'package:flutter/material.dart';

class Model extends ChangeNotifier{
  int i = 0;
  bool buttonCheck = false;
  increment_i(){
    i++;
    if(i==4){
      buttonCheck = true;
    }
    notifyListeners();
  }
  decrement_i(){
    i--;
    buttonCheck = false;
    notifyListeners();
  }
}