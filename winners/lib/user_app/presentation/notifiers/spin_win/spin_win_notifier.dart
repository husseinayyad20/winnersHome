


import 'package:winners/user_app/data/models/spin_win/bet_slip_item.dart';
import 'package:flutter/material.dart';

class SpinAndWinNotifier extends ChangeNotifier {
  final List<Map> _numbers = [
    {"number": "3", "color": Colors.red},
    {"number": "2", "color": Colors.black},
    {"number": "1", "color": Colors.red},
    {"number": "6", "color": Colors.black},
    {"number": "5", "color": Colors.red},
    {"number": "4", "color": Colors.black},
    {"number": "9", "color": Colors.red},
    {"number": "8", "color": Colors.black},
    {"number": "7", "color": Colors.red},
    {"number": "12", "color": Colors.red},
    {"number": "11", "color": Colors.black},
    {"number": "10", "color": Colors.black},
    {"number": "15", "color": Colors.black},
    {"number": "14", "color": Colors.red},
    {"number": "13", "color": Colors.black},
    {"number": "18", "color": Colors.red},
    {"number": "17", "color": Colors.black},
    {"number": "16", "color": Colors.red},
    {"number": "21", "color": Colors.red},
    {"number": "20", "color": Colors.black},
    {"number": "19", "color": Colors.red},
    {"number": "24", "color": Colors.black},
    {"number": "23", "color": Colors.red},
    {"number": "22", "color": Colors.black},
    {"number": "27", "color": Colors.red},
    {"number": "26", "color": Colors.black},
    {"number": "25", "color": Colors.red},
    {"number": "30", "color": Colors.red},
    {"number": "29", "color": Colors.black},
    {"number": "28", "color": Colors.black},
    {"number": "33", "color": Colors.black},
    {"number": "32", "color": Colors.red},
    {"number": "31", "color": Colors.black},
    {"number": "36", "color": Colors.red},
    {"number": "35", "color": Colors.black},
    {"number": "34", "color": Colors.red},
  ];
  final List<Map> _neighboursList = [
    {"number": "0", "color": Colors.green},
    {"number": "32", "color": Colors.red},
    {"number": "15", "color": Colors.black},
    {"number": "19", "color": Colors.red},
    {"number": "4", "color": Colors.black},
    {"number": "21", "color": Colors.red},
    {"number": "2", "color": Colors.black},
    {"number": "25", "color": Colors.red},
    {"number": "17", "color": Colors.black},
    {"number": "34", "color": Colors.red},
    {"number": "6", "color": Colors.black},
    {"number": "27", "color": Colors.red},
    {"number": "13", "color": Colors.black},
    {"number": "36", "color": Colors.red},
    {"number": "11", "color": Colors.black},
    {"number": "30", "color": Colors.red},
    {"number": "8", "color": Colors.black},
    {"number": "23", "color": Colors.red},
    {"number": "10", "color": Colors.black},
    {"number": "5", "color": Colors.red},
    {"number": "24", "color": Colors.black},
    {"number": "16", "color": Colors.red},
    {"number": "33", "color": Colors.black},
    {"number": "1", "color": Colors.red},
    {"number": "20", "color": Colors.black},
    {"number": "14", "color": Colors.red},
    {"number": "31", "color": Colors.black},
    {"number": "9", "color": Colors.red},
    {"number": "22", "color": Colors.black},
    {"number": "18", "color": Colors.red},
    {"number": "29", "color": Colors.black},
    {"number": "7", "color": Colors.red},
    {"number": "28", "color": Colors.black},
    {"number": "12", "color": Colors.red},
    {"number": "35", "color": Colors.black},
    {"number": "3", "color": Colors.red},
    {"number": "26", "color": Colors.black},
  ];

  bool _isMid = false;
  bool get isMid => _isMid;
  final List<Map> _midList = [
    {"number": "2"},
    {"number": "5"},
    {"number": "8"},
    {"number": "11"},
    {"number": "14"},
    {"number": "17"},
    {"number": "20"},
    {"number": "23"},
    {"number": "26"},
    {"number": "29"},
    {"number": "32"},
    {"number": "35"},
  ];
  List<Map> get midList => _midList;
  List<Map> get numbers => _numbers;
  List<Map> get neighboursList => _neighboursList;
  var _value = ValueNotifier(false);
  get value => _value;
  bool _showBetSlip = false;
  bool get showBetSlip => _showBetSlip;
  bool _zeroClick = false;
  bool get zeroClick => _zeroClick;
  int _cuurentNumberIndex = 0;
  int get cuurentNumberIndex => _cuurentNumberIndex;
  final List<BetSlipItem> _betSlipItem = [];
  String _slectedNumber = "";
  String get slectedNumber => _slectedNumber;
  int textEditingControllerValue = 100;
  TextEditingController textEditingController =
      TextEditingController(text: "100");
  void initData() {
    textEditingControllerValue = 100;
    textEditingController = TextEditingController(text: "100");
  }

  void changeNumber(int value) {
    if (value > 0) {
      textEditingControllerValue = value;
      textEditingController.text = textEditingControllerValue.toString();
      notifyListeners();
    }
  }

  void setShowBetSlip(bool value) {
    _showBetSlip = value;
    notifyListeners();
  }

  void setSlectedNumber(String value) {
    _slectedNumber = value;
  }

  void setIsMid(bool value) {
    _isMid = value;
  }

  // void addToBetSlip(BetSlipItem item) {
  //   _betSlipItem.add(item);
  //   setShowBetSlip(true);
  // }

  // check if selectd number in mid not on top or botttom
  void checkIfNumberInMid() {
    setIsMid(false);
    for (var element in _midList) {
      if (_numbers[_cuurentNumberIndex]["number"].toString() ==
          element["number"]) {
        setIsMid(true);
      }
    }
  }

  void addEvenToBetSlip(String id) {
    List<int> number = [];
    for (var element in _numbers) {
      if (int.parse(element["number"]) % 2 == 0) {
        number.add(int.parse(element["number"]));
      }
    }
    _betSlipItem.add(BetSlipItem(number, "Even", 3.44,id));
    setShowBetSlip(true);
  }

  void addOddToBetSlip(String id) {
    List<int> number = [];
    for (var element in _numbers) {
      if (int.parse(element["number"]) % 2 != 0) {
        number.add(int.parse(element["number"]));
      }
    }
    _betSlipItem.add(BetSlipItem(number, "Odd", 3.44,id));
    setShowBetSlip(true);
  }

  void addByColorToBetSlip(Color color,String id) {
    List<int> number = [];
    for (var element in _numbers) {
      if (element["color"] == color) {
        number.add(int.parse(element["number"]));
      }
    }
    _betSlipItem
        .add(BetSlipItem(number, color == Colors.red ? "Red" : "Black", 3.44,id));
    setShowBetSlip(true);
  }

  void addByListToBetSlip(List<int> numberList,String type,String id) {
    _betSlipItem.add(BetSlipItem(numberList, type, 3.44,id));
    setShowBetSlip(true);
  }

  void addByIndexToBetSlip(int index, String type,String id) {
    List<int> number = [];

    for (int i = 0; i < _neighboursList.length; i++) {
      if (index == 0) {
        if (i == index + 1 ||
            i == index + 2 ||
            i == index ||
            i == _neighboursList.length - 1 ||
            i == _neighboursList.length - 2) {
          number.add(int.parse(_neighboursList[i]["number"]));
        }
      } else if (index == 1) {
        if (i == _neighboursList.length ||
            i == 0 ||
            i == index ||
            i == _neighboursList.length - 1 ||
            i == index + 1 ||
            i == index + 2) {
          number.add(int.parse(_neighboursList[i]["number"]));
        }
      } else if (index == 36) {
        if (i == index ||
            i == 0 ||
            i == 1 ||
            i == index - 1 ||
            i == index - 2) {
          number.add(int.parse(_neighboursList[i]["number"]));
        }
      } else {
        if (i == index ||
            i == index + 1 ||
            i == index + 2 ||
            i == index - 1 ||
            i == index - 2) {
          number.add(int.parse(_neighboursList[i]["number"]));
        }
      }
    }
    _betSlipItem.add(BetSlipItem(number, type, 3.44,id));
    setShowBetSlip(true);
  }

  void addBynumberLimitToBetSlip(int from, int to, bool inRow, String type,String id,
      {int plus = 3,bool fromZeroSide=false}) {
    List<int> number = [];
  if(fromZeroSide){
          number.add(0);
        }
    for (var element in _numbers) {
      if (inRow) {
        for (int i = from; i <= to; i = i + plus) {
          if (element["number"] == i.toString()) {
            number.add(int.parse(element["number"]));
          }
        }
      } else {
      
        if (int.parse(element["number"]) >= from &&
            int.parse(element["number"]) <= to) {
          number.add(int.parse(element["number"]));
        }
      }
    }

    _betSlipItem.add(BetSlipItem(number, type, 3.44,id));

    setShowBetSlip(true);
  }

  void removeBetSlipItem(int index) {
    _betSlipItem.removeAt(index);
    if (_betSlipItem.isEmpty) {
      _showBetSlip = false;
    }
    notifyListeners();
  }

  void removeBetSlipItemById(String id) {
    int index=0;
    for (int i=0 ;i< _betSlipItem.length;i++) {
    if(_betSlipItem[i].id==id){
      index=i;
    }
    
    _betSlipItem.removeAt(index);
    if (_betSlipItem.isEmpty) {
      _showBetSlip = false;
    }
    notifyListeners();
  }
  }

  bool checkIfBetSlipItemIsExistById(String id) {
    
    bool isExist=false;
  for (var element in _betSlipItem) {
    if(element.id==id){
      isExist=true;
    }
    
  }
  return isExist;
  }

  List<BetSlipItem> get betSlipItem => _betSlipItem;
  void setZeroClick(bool value) {
    _zeroClick = value;
    notifyListeners();
  }

  void setCuurentNumberIndex(int value) {
    _cuurentNumberIndex = value;
  }

  void setValueNotifier(bool value) {
    _value = ValueNotifier(value);
  }
}
