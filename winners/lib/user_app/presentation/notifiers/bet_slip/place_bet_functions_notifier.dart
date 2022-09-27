import 'package:winners/user_app/data/models/bet_slip_configuration/place_bet_function.dart';

import 'package:flutter/material.dart';

class PlaceBetSlipFunctionsNotifier extends ChangeNotifier {
  late List<PlaceBetFunction> _betFunctions;
  late List<bool> _betFunctionsActive;
  List<PlaceBetFunction> get betFunctions => _betFunctions;
  List<bool> get betFunctionsActive => _betFunctionsActive;

  /// current index of bet functions [index]
  void onBetSelected(
    int index,
  ) {
    for (int i = 0; i < _betFunctions.length; i++) {
      if (i == index) {
        // set active at selected position
        _betFunctionsActive[i] = true;
      } else {
        _betFunctionsActive[i] = false;
      }
    }

    notifyListeners();
  }

  /// init betFunctions list from api [list]
  void initBetFunctions(List<PlaceBetFunction> list) {
    _betFunctions = list.where((element) => element.active!).toList();
    _betFunctionsActive = list.map((e) => e.optionIsDefault!).toList();
  }
}
