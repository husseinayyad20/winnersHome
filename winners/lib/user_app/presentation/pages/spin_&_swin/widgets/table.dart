import 'package:winners/user_app/core/constants/assets.dart';
import 'package:winners/user_app/core/constants/extensions/widget_extensions.dart';
import 'package:winners/user_app/core/constants/strings.dart';
import 'package:winners/user_app/core/constants/theme.dart';
import 'package:winners/user_app/core/widgets/button/drop_down_select/drop_down_select.dart';

import 'package:winners/user_app/data/models/spin_win/bet_slip_item.dart';

import 'package:winners/user_app/presentation/notifiers/general_configuration_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/spin_win/spin_win_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/theme_notifier.dart';
import 'package:winners/user_app/presentation/resources/color_manager.dart';
import 'package:winners/user_app/presentation/resources/fonts_manager.dart';
import 'package:winners/user_app/presentation/resources/styles_manager.dart';
import 'package:winners/user_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TableView extends StatefulWidget {
  const TableView({Key? key}) : super(key: key);

  @override
  State<TableView> createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  late ThemeNotifier _themeNotifier;
  late bool _isDarkTheme;

  late Size size;
  late SpinAndWinNotifier _spinNotifier;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    _themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);
    _spinNotifier = Provider.of<SpinAndWinNotifier>(context, listen: true);

    _isDarkTheme = (_themeNotifier.getTheme() == AppThemes().darkTheme);
    return Stack(
      children: [_tableView(), _overlayView()],
    );
  }

  Widget _overlayView() {
    return ValueListenableBuilder<bool>(
      valueListenable: _spinNotifier.value,
      builder: (context, value, child) {
        if (value) {
          return Container(
                  color: Colors.black54,
                  width: double.maxFinite,
                  height: double.maxFinite,
                  child: _overlayItem())
              .center();
        } else {
          return Container();
        }
      },
    );
  }

  Widget _tableView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: _spinNotifier.showBetSlip ? 500 : 560,
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Transform.scale(
                      scale: _spinNotifier.showBetSlip ? 1.0 : 1.28,
                      child: Stack(
                        //textDirection: TextDirection.rtl,
                        alignment: Alignment.topLeft,
                        children: [
                          Positioned(
                            left: _spinNotifier.showBetSlip ? 0 : 90,
                            top: _spinNotifier.showBetSlip ? 0 : 60,
                            child: InkWell(
                              onTap: () {
                                _spinNotifier.setValueNotifier(true);
                                _spinNotifier.setZeroClick(true);
                              },
                              child: SvgPicture.asset(Assets.zeroSide,
                                  height: 160, width: 60, fit: BoxFit.fill),
                            ),
                          ),
                          Positioned(
                            left: _spinNotifier.showBetSlip ? 36 : 120,
                            top: _spinNotifier.showBetSlip ? 0 : 60,
                            right: 0,
                            bottom: 0,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    _largeNumber(
                                        _spinNotifier.numbers[0]["number"],
                                        _spinNotifier.numbers[0]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[3]["number"],
                                        _spinNotifier.numbers[3]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[6]["number"],
                                        _spinNotifier.numbers[6]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[9]["number"],
                                        _spinNotifier.numbers[9]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[12]["number"],
                                        _spinNotifier.numbers[12]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[15]["number"],
                                        _spinNotifier.numbers[15]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[18]["number"],
                                        _spinNotifier.numbers[18]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[21]["number"],
                                        _spinNotifier.numbers[21]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[24]["number"],
                                        _spinNotifier.numbers[24]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[27]["number"],
                                        _spinNotifier.numbers[27]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[30]["number"],
                                        _spinNotifier.numbers[30]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[33]["number"],
                                        _spinNotifier.numbers[33]["color"],
                                        true),
                                    _largeNumber(
                                        "1\nto\n2", Colors.green.shade900, true,
                                        rowNumber: 1),
                                  ],
                                ),
                                Row(
                                  children: [
                                    _largeNumber(
                                        _spinNotifier.numbers[1]["number"],
                                        _spinNotifier.numbers[1]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[4]["number"],
                                        _spinNotifier.numbers[4]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[7]["number"],
                                        _spinNotifier.numbers[7]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[10]["number"],
                                        _spinNotifier.numbers[10]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[13]["number"],
                                        _spinNotifier.numbers[13]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[16]["number"],
                                        _spinNotifier.numbers[16]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[19]["number"],
                                        _spinNotifier.numbers[19]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[22]["number"],
                                        _spinNotifier.numbers[22]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[25]["number"],
                                        _spinNotifier.numbers[25]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[28]["number"],
                                        _spinNotifier.numbers[28]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[31]["number"],
                                        _spinNotifier.numbers[31]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[34]["number"],
                                        _spinNotifier.numbers[34]["color"],
                                        true),
                                    _largeNumber(
                                        "1\nto\n2", Colors.green.shade900, true,
                                        rowNumber: 2),
                                  ],
                                ),
                                Row(
                                  children: [
                                    _largeNumber(
                                        _spinNotifier.numbers[2]["number"],
                                        _spinNotifier.numbers[2]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[5]["number"],
                                        _spinNotifier.numbers[5]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[8]["number"],
                                        _spinNotifier.numbers[8]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[11]["number"],
                                        _spinNotifier.numbers[11]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[14]["number"],
                                        _spinNotifier.numbers[14]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[17]["number"],
                                        _spinNotifier.numbers[17]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[20]["number"],
                                        _spinNotifier.numbers[20]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[23]["number"],
                                        _spinNotifier.numbers[23]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[26]["number"],
                                        _spinNotifier.numbers[26]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[29]["number"],
                                        _spinNotifier.numbers[29]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[32]["number"],
                                        _spinNotifier.numbers[32]["color"],
                                        true),
                                    _largeNumber(
                                        _spinNotifier.numbers[35]["number"],
                                        _spinNotifier.numbers[35]["color"],
                                        true),
                                    _largeNumber(
                                        "1\nto\n2", Colors.green.shade900, true,
                                        rowNumber: 3),
                                  ],
                                ),
                                _tableFooter(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      //scolor: Colors.amber,
                      height: 430,
                      width: _spinNotifier.showBetSlip ? 220 : 43,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: SizedBox(
                              width: _spinNotifier.showBetSlip ? 200 : 30,
                              child: _spinNotifier.showBetSlip
                                  ? Align(
                                      alignment: Alignment.topRight,
                                      child: _betSlip())
                                  : Container(
                                      decoration: BoxDecoration(
                                          color: _themeNotifier
                                              .getTheme()
                                              .primaryColorLight,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              topRight: Radius.circular(4))),
                                    ),
                            ),
                          ),
                          Positioned(
                            left: 5,
                            top: 40,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: InkWell(
                                  onTap: () {
                                    if (_spinNotifier.betSlipItem.isNotEmpty) {
                                      _spinNotifier.setShowBetSlip(
                                          !_spinNotifier.showBetSlip);
                                    }
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(AppPadding.p2),
                                    child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.blue,
                                            shape: BoxShape.circle),
                                        child: Icon(
                                          !_spinNotifier.showBetSlip
                                              ? Icons.arrow_back_ios
                                              : Icons.arrow_forward_ios,
                                          size: 15,
                                          color: Colors.white,
                                        )
                                            .padding(
                                                padding: const EdgeInsets.all(
                                                    AppPadding.p4))
                                            .center()),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _neighbours()
        ],
      ),
    );
  }

  Widget _number(String number, Color color, int index) {
    return GestureDetector(
      onTap: () {
        if (_spinNotifier
            .checkIfBetSlipItemIsExistById(number + "neighbours")) {
          _spinNotifier.removeBetSlipItemById(number + "neighbours");
        } else {
          _spinNotifier.addByIndexToBetSlip(
              index, "neighbours", number + "neighbours");
        }
      },
      child: Container(
        height: 50,
        width: 24,
        decoration: BoxDecoration(
            color: color, border: Border.all(color: Colors.white, width: 2)),
        child: Text(
          number,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: FontSize.s10),
        ).center(),
      ),
    );
  }

  Widget _largeNumberOverlay(
    String number,
    Color color,
    bool show,
  ) {
    bool isTop = int.parse(_spinNotifier
                .numbers[_spinNotifier.cuurentNumberIndex]["number"]) %
            3 ==
        0;
    return _spinNotifier.value.value &&
            _spinNotifier.slectedNumber == number &&
            !_spinNotifier.zeroClick &&
            _spinNotifier.cuurentNumberIndex > 3
        ? Stack(
            children: [
              Container(
                height: 75,
                width: 60,
                decoration: BoxDecoration(
                    color: color,
                    border: Border.all(color: Colors.white, width: 1.2)),
                child: Text(
                  number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s12),
                ).center(),
              ),

              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      if (_spinNotifier
                          .checkIfBetSlipItemIsExistById("$number+tm")) {
                        _spinNotifier.removeBetSlipItemById('$number+tm');
                      } else {
                        if (_spinNotifier.isMid) {
                          _spinNotifier.addByListToBetSlip([
                            int.parse(_spinNotifier
                                    .numbers[_spinNotifier.cuurentNumberIndex]
                                ["number"]),
                            int.parse(_spinNotifier.numbers[
                                    _spinNotifier.cuurentNumberIndex - 1]
                                ["number"]),
                          ], "Split", "$number+tm");
                        } else {
                          if (!isTop) {
                            _spinNotifier.addByListToBetSlip([
                              int.parse(_spinNotifier
                                      .numbers[_spinNotifier.cuurentNumberIndex]
                                  ["number"]),
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex - 1]
                                  ["number"]),
                            ], "Spilt", "$number+tm");
                          } else {
                            _spinNotifier.addByListToBetSlip([
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex + 2]
                                  ["number"]),
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex + 1]
                                  ["number"]),
                              int.parse(_spinNotifier
                                      .numbers[_spinNotifier.cuurentNumberIndex]
                                  ["number"]),
                            ], "3 Line", "$number+tm");
                          }
                        }
                      }
                    },
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor:
                          (_spinNotifier.checkIfBetSlipItemIsExistById("tm"))
                              ? Colors.green
                              : Colors.white,
                      child: Icon(
                          _spinNotifier.checkIfBetSlipItemIsExistById("tm")
                              ? Icons.check_circle
                              : Icons.circle,
                          color:
                              _spinNotifier.checkIfBetSlipItemIsExistById("tm")
                                  ? Colors.white
                                  : Colors.grey,
                          size: 10),
                    ),
                  )),
              if (_spinNotifier.cuurentNumberIndex <
                  _spinNotifier.numbers.length - 3)
                Positioned(
                    top: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        if (_spinNotifier
                            .checkIfBetSlipItemIsExistById("$number+tr")) {
                          _spinNotifier.removeBetSlipItemById('$number+tr');
                        } else {
                          if (_spinNotifier.isMid) {
                            _spinNotifier.addByListToBetSlip([
                              int.parse(_spinNotifier
                                      .numbers[_spinNotifier.cuurentNumberIndex]
                                  ["number"]),
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex - 1]
                                  ["number"]),
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex + 3]
                                  ["number"]),
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex + 2]
                                  ["number"]),
                            ], "corner", "$number+tr");
                          } else {
                            if (!isTop) {
                              _spinNotifier.addByListToBetSlip([
                                int.parse(_spinNotifier.numbers[_spinNotifier
                                    .cuurentNumberIndex]["number"]),
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex - 1]
                                    ["number"]),
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex + 3]
                                    ["number"]),
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex + 2]
                                    ["number"]),
                              ], "Corner", "$number+tr");
                            } else {
                              _spinNotifier.addByListToBetSlip([
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex + 2]
                                    ["number"]),
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex + 1]
                                    ["number"]),
                                int.parse(_spinNotifier.numbers[_spinNotifier
                                    .cuurentNumberIndex]["number"]),
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex + 3]
                                    ["number"]),
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex + 4]
                                    ["number"]),
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex + 5]
                                    ["number"]),
                              ], "Six", "$number+tr");
                            }
                          }
                        }
                      },
                      child: CircleAvatar(
                        radius: 7,
                        backgroundColor: (_spinNotifier
                                .checkIfBetSlipItemIsExistById("$number+tr"))
                            ? Colors.green
                            : Colors.white,
                        child: Icon(
                            _spinNotifier
                                    .checkIfBetSlipItemIsExistById("$number+tr")
                                ? Icons.check_circle
                                : Icons.circle,
                            color: _spinNotifier
                                    .checkIfBetSlipItemIsExistById("$number+tr")
                                ? Colors.white
                                : Colors.grey,
                            size: 10),
                      ),
                    )),
              //boottom
              Positioned(
                  bottom: 0,
                  left: 0,
                  child: InkWell(
                    onTap: () {
                      if (_spinNotifier
                          .checkIfBetSlipItemIsExistById("$number+bl")) {
                        _spinNotifier.removeBetSlipItemById('$number+bl');
                      } else {
                        if (_spinNotifier.isMid) {
                          _spinNotifier.addByListToBetSlip([
                            _spinNotifier.cuurentNumberIndex,
                            _spinNotifier.cuurentNumberIndex + 1,
                            _spinNotifier.cuurentNumberIndex - 2,
                            _spinNotifier.cuurentNumberIndex - 3,
                          ], "Corner", "$number+bl");
                        } else {
                          if (isTop) {
                            _spinNotifier.addByListToBetSlip([
                              int.parse(_spinNotifier
                                      .numbers[_spinNotifier.cuurentNumberIndex]
                                  ["number"]),
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex + 1]
                                  ["number"]),
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex - 2]
                                  ["number"]),
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex - 3]
                                  ["number"]),
                            ], "Corner", "$number+bl");
                          } else {
                            _spinNotifier.addByListToBetSlip([
                              int.parse(_spinNotifier
                                      .numbers[_spinNotifier.cuurentNumberIndex]
                                  ["number"]),
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex - 1]
                                  ["number"]),
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex - 2]
                                  ["number"]),
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex - 3]
                                  ["number"]),
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex - 4]
                                  ["number"]),
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex - 5]
                                  ["number"]),
                            ], "Six", "$number+bl");
                          }
                        }
                      }
                    },
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor: (_spinNotifier
                              .checkIfBetSlipItemIsExistById("$number+bl"))
                          ? Colors.green
                          : Colors.white,
                      child: Icon(
                          _spinNotifier
                                  .checkIfBetSlipItemIsExistById("$number+bl")
                              ? Icons.check_circle
                              : Icons.circle,
                          color: _spinNotifier
                                  .checkIfBetSlipItemIsExistById("$number+bl")
                              ? Colors.white
                              : Colors.grey,
                          size: 10),
                    ),
                  )),
              if (_spinNotifier.cuurentNumberIndex <
                  _spinNotifier.numbers.length - 3)
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        if (_spinNotifier
                            .checkIfBetSlipItemIsExistById("$number+br")) {
                          _spinNotifier.removeBetSlipItemById('$number+br');
                        } else {
                          if (_spinNotifier.isMid) {
                            _spinNotifier.addByListToBetSlip([
                              int.parse(_spinNotifier
                                      .numbers[_spinNotifier.cuurentNumberIndex]
                                  ["number"]),
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex + 1]
                                  ["number"]),
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex + 3]
                                  ["number"]),
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex + 4]
                                  ["number"]),
                            ], "Corrner", "$number+br");
                          } else if (!isTop) {
                            _spinNotifier.addByListToBetSlip([
                              int.parse(_spinNotifier
                                      .numbers[_spinNotifier.cuurentNumberIndex]
                                  ["number"]),
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex - 1]
                                  ["number"]),
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex - 2]
                                  ["number"]),
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex + 1]
                                  ["number"]),
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex + 2]
                                  ["number"]),
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex + 3]
                                  ["number"]),
                            ], "Six", "$number+br");
                          } else {
                            _spinNotifier.addByListToBetSlip([
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex + 1]
                                  ["number"]),
                              int.parse(_spinNotifier
                                      .numbers[_spinNotifier.cuurentNumberIndex]
                                  ["number"]),
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex + 3]
                                  ["number"]),
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex + 4]
                                  ["number"]),
                            ], "Corner", "$number+br");
                          }
                        }
                      },
                      child: CircleAvatar(
                        radius: 7,
                        backgroundColor: (_spinNotifier
                                .checkIfBetSlipItemIsExistById("$number+br"))
                            ? Colors.green
                            : Colors.white,
                        child: Icon(
                            _spinNotifier
                                    .checkIfBetSlipItemIsExistById("$number+br")
                                ? Icons.check_circle
                                : Icons.circle,
                            color: _spinNotifier
                                    .checkIfBetSlipItemIsExistById("$number+br")
                                ? Colors.white
                                : Colors.grey,
                            size: 10),
                      ),
                    )),
              Positioned(
                  top: 0,
                  left: 0,
                  child: InkWell(
                    onTap: () {
                      if (_spinNotifier
                          .checkIfBetSlipItemIsExistById("$number+tl")) {
                        _spinNotifier.removeBetSlipItemById('$number+tl');
                      } else {
                        if (_spinNotifier.isMid) {
                          _spinNotifier.addByListToBetSlip([
                            int.parse(_spinNotifier.numbers[
                                    _spinNotifier.cuurentNumberIndex - 3]
                                ["number"]),
                            int.parse(_spinNotifier.numbers[
                                    _spinNotifier.cuurentNumberIndex - 4]
                                ["number"]),
                            int.parse(
                              _spinNotifier
                                      .numbers[_spinNotifier.cuurentNumberIndex]
                                  ["number"],
                            ),
                            int.parse(
                              _spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex - 1]
                                  ["number"],
                            ),
                          ], "Corner", "$number+tl");
                        } else {
                          if (!isTop) {
                            _spinNotifier.addByListToBetSlip([
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex - 3]
                                  ["number"]),
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex - 4]
                                  ["number"]),
                              int.parse(_spinNotifier
                                      .numbers[_spinNotifier.cuurentNumberIndex]
                                  ["number"]),
                              int.parse(
                                _spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex - 1]
                                    ["number"],
                              ),
                            ], "Six", "$number+tl");
                          } else {
                            _spinNotifier.addByListToBetSlip([
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex - 3]
                                  ["number"]),
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex - 2]
                                  ["number"]),
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex - 1]
                                  ["number"]),
                              int.parse(
                                _spinNotifier.numbers[
                                    _spinNotifier.cuurentNumberIndex]["number"],
                              ),
                              int.parse(
                                _spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex + 1]
                                    ["number"],
                              ),
                              int.parse(
                                _spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex + 2]
                                    ["number"],
                              ),
                            ], "Six", "tl");
                          }
                        }
                      }
                    },
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor: (_spinNotifier
                              .checkIfBetSlipItemIsExistById("$number+tl"))
                          ? Colors.green
                          : Colors.white,
                      child: Icon(
                          _spinNotifier
                                  .checkIfBetSlipItemIsExistById("$number+tl")
                              ? Icons.check_circle
                              : Icons.circle,
                          color: _spinNotifier
                                  .checkIfBetSlipItemIsExistById("$number+tl")
                              ? Colors.white
                              : Colors.grey,
                          size: 10),
                    ),
                  )),
              if (_spinNotifier.cuurentNumberIndex <
                  _spinNotifier.numbers.length - 3)
                // right
                Positioned(
                    top: 30,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        if (_spinNotifier
                            .checkIfBetSlipItemIsExistById("$number+rm")) {
                          _spinNotifier.removeBetSlipItemById('$number+rm');
                        } else {
                          _spinNotifier.addByListToBetSlip([
                            int.parse(_spinNotifier
                                    .numbers[_spinNotifier.cuurentNumberIndex]
                                ["number"]),
                            int.parse(_spinNotifier.numbers[
                                    _spinNotifier.cuurentNumberIndex + 3]
                                ["number"]),
                          ], "Spilt", "$number+rm");
                        }
                      },
                      child: CircleAvatar(
                        radius: 7,
                        backgroundColor: (_spinNotifier
                                .checkIfBetSlipItemIsExistById("$number+rm"))
                            ? Colors.green
                            : Colors.white,
                        child: Icon(
                            _spinNotifier
                                    .checkIfBetSlipItemIsExistById("$number+rm")
                                ? Icons.check_circle
                                : Icons.circle,
                            color: _spinNotifier
                                    .checkIfBetSlipItemIsExistById("$number+rm")
                                ? Colors.white
                                : Colors.grey,
                            size: 10),
                      ),
                    )),
              //left
              Positioned(
                  top: 30,
                  left: 0,
                  child: InkWell(
                    onTap: () {
                      if (_spinNotifier
                          .checkIfBetSlipItemIsExistById("$number+lm")) {
                        _spinNotifier.removeBetSlipItemById('$number+lm');
                      } else {
                        _spinNotifier.addByListToBetSlip([
                          int.parse(_spinNotifier
                                  .numbers[_spinNotifier.cuurentNumberIndex - 3]
                              ["number"]),
                          int.parse(_spinNotifier
                                  .numbers[_spinNotifier.cuurentNumberIndex]
                              ["number"]),
                        ], "Split", "$number+lm");
                      }
                    },
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor: (_spinNotifier
                              .checkIfBetSlipItemIsExistById("$number+lm"))
                          ? Colors.green
                          : Colors.white,
                      child: Icon(
                          _spinNotifier
                                  .checkIfBetSlipItemIsExistById("$number+lm")
                              ? Icons.check_circle
                              : Icons.circle,
                          color: _spinNotifier
                                  .checkIfBetSlipItemIsExistById("$number+lm")
                              ? Colors.white
                              : Colors.grey,
                          size: 10),
                    ),
                  )),
              Positioned(
                  bottom: 0,
                  left: 23,
                  child: InkWell(
                    onTap: () {
                      if (_spinNotifier
                          .checkIfBetSlipItemIsExistById("$number+mb")) {
                        _spinNotifier.removeBetSlipItemById('$number+mb');
                      } else {
                        if (_spinNotifier.isMid) {
                          _spinNotifier.addByListToBetSlip([
                            int.parse(_spinNotifier
                                    .numbers[_spinNotifier.cuurentNumberIndex]
                                ["number"]),
                            int.parse(_spinNotifier.numbers[
                                    _spinNotifier.cuurentNumberIndex + 1]
                                ["number"]),
                          ], "Spilt", "$number+mb");
                        } else if (!isTop) {
                          _spinNotifier.addByListToBetSlip([
                            int.parse(_spinNotifier
                                    .numbers[_spinNotifier.cuurentNumberIndex]
                                ["number"]),
                            int.parse(_spinNotifier.numbers[
                                    _spinNotifier.cuurentNumberIndex - 1]
                                ["number"]),
                            int.parse(_spinNotifier.numbers[
                                    _spinNotifier.cuurentNumberIndex - 2]
                                ["number"]),
                          ], "3 Line", "$number+mb");
                        } else {
                          _spinNotifier.addByListToBetSlip([
                            int.parse(_spinNotifier
                                    .numbers[_spinNotifier.cuurentNumberIndex]
                                ["number"]),
                            int.parse(_spinNotifier.numbers[
                                    _spinNotifier.cuurentNumberIndex + 1]
                                ["number"]),
                          ], "Split", "$number+mb");
                        }
                      }
                    },
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor: (_spinNotifier
                              .checkIfBetSlipItemIsExistById("$number+mb"))
                          ? Colors.green
                          : Colors.white,
                      child: Icon(
                          _spinNotifier
                                  .checkIfBetSlipItemIsExistById("$number+mb")
                              ? Icons.check_circle
                              : Icons.circle,
                          color: _spinNotifier
                                  .checkIfBetSlipItemIsExistById("$number+mb")
                              ? Colors.white
                              : Colors.grey,
                          size: 10),
                    ),
                  )),
              Positioned(
                  top: 15,
                  left: 10,
                  child: InkWell(
                    onTap: () {
                      if (_spinNotifier
                          .checkIfBetSlipItemIsExistById("$number+center")) {
                        _spinNotifier.removeBetSlipItemById('$number+center');
                      } else {
                        _spinNotifier.addByListToBetSlip([
                          int.parse(_spinNotifier
                                  .numbers[_spinNotifier.cuurentNumberIndex]
                              ["number"]),
                        ], "Win", "$number+center");
                      }
                    },
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor: (_spinNotifier
                              .checkIfBetSlipItemIsExistById("$number+center"))
                          ? Colors.green
                          : Colors.white,
                      child: Icon(
                          _spinNotifier.checkIfBetSlipItemIsExistById(
                                  "$number+center")
                              ? Icons.check_circle
                              : Icons.circle,
                          color: _spinNotifier.checkIfBetSlipItemIsExistById(
                                  "$number+center")
                              ? Colors.white
                              : Colors.grey,
                          size: 10),
                    ),
                  )),
            ],
          )
        : _spinNotifier.slectedNumber == number
            ? Stack(
                children: [
                  Container(
                    height: 75,
                    width: 60,
                    decoration: BoxDecoration(
                        color: color,
                        border: Border.all(color: Colors.white, width: 1.2)),
                    child: Text(
                      number,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: FontSize.s12),
                    ).center(),
                  ),
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          if (_spinNotifier
                              .checkIfBetSlipItemIsExistById("$number+tm")) {
                            _spinNotifier.removeBetSlipItemById('$number+tm');
                          } else {
                            if (_spinNotifier.isMid) {
                              _spinNotifier.addByListToBetSlip([
                                int.parse(_spinNotifier.numbers[_spinNotifier
                                    .cuurentNumberIndex]["number"]),
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex - 1]
                                    ["number"]),
                              ], "Split", "$number+tm");
                            } else {
                              if (!isTop) {
                                _spinNotifier.addByListToBetSlip([
                                  int.parse(_spinNotifier.numbers[_spinNotifier
                                      .cuurentNumberIndex]["number"]),
                                  int.parse(_spinNotifier.numbers[
                                          _spinNotifier.cuurentNumberIndex - 1]
                                      ["number"]),
                                ], "Spilt", "$number+tm");
                              } else {
                                _spinNotifier.addByListToBetSlip([
                                  int.parse(_spinNotifier.numbers[
                                          _spinNotifier.cuurentNumberIndex + 2]
                                      ["number"]),
                                  int.parse(_spinNotifier.numbers[
                                          _spinNotifier.cuurentNumberIndex + 1]
                                      ["number"]),
                                  int.parse(_spinNotifier.numbers[_spinNotifier
                                      .cuurentNumberIndex]["number"]),
                                ], "3 Line", "$number+tm");
                              }
                            }
                          }
                        },
                        child: CircleAvatar(
                          radius: 7,
                          backgroundColor: (_spinNotifier
                                  .checkIfBetSlipItemIsExistById("$number+tm"))
                              ? Colors.green
                              : Colors.white,
                          child: Icon(
                              _spinNotifier.checkIfBetSlipItemIsExistById(
                                      "$number+tm")
                                  ? Icons.check_circle
                                  : Icons.circle,
                              color:
                                  _spinNotifier.checkIfBetSlipItemIsExistById(
                                          "$number+tm")
                                      ? Colors.white
                                      : Colors.grey,
                              size: 10),
                        ),
                      )),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          if (_spinNotifier
                              .checkIfBetSlipItemIsExistById("$number+tr")) {
                            _spinNotifier.removeBetSlipItemById('$number+tr');
                          } else {
                            if (_spinNotifier.isMid) {
                              _spinNotifier.addByListToBetSlip([
                                int.parse(_spinNotifier.numbers[_spinNotifier
                                    .cuurentNumberIndex]["number"]),
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex - 1]
                                    ["number"]),
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex + 3]
                                    ["number"]),
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex + 2]
                                    ["number"]),
                              ], "corner", "$number+tr");
                            } else {
                              if (!isTop) {
                                _spinNotifier.addByListToBetSlip([
                                  int.parse(_spinNotifier.numbers[_spinNotifier
                                      .cuurentNumberIndex]["number"]),
                                  int.parse(_spinNotifier.numbers[
                                          _spinNotifier.cuurentNumberIndex - 1]
                                      ["number"]),
                                  int.parse(_spinNotifier.numbers[
                                          _spinNotifier.cuurentNumberIndex + 3]
                                      ["number"]),
                                  int.parse(_spinNotifier.numbers[
                                          _spinNotifier.cuurentNumberIndex + 2]
                                      ["number"]),
                                ], "Corner", "$number+tr");
                              } else {
                                _spinNotifier.addByListToBetSlip([
                                  int.parse(_spinNotifier.numbers[
                                          _spinNotifier.cuurentNumberIndex + 2]
                                      ["number"]),
                                  int.parse(_spinNotifier.numbers[
                                          _spinNotifier.cuurentNumberIndex + 1]
                                      ["number"]),
                                  int.parse(_spinNotifier.numbers[_spinNotifier
                                      .cuurentNumberIndex]["number"]),
                                  int.parse(_spinNotifier.numbers[
                                          _spinNotifier.cuurentNumberIndex + 3]
                                      ["number"]),
                                  int.parse(_spinNotifier.numbers[
                                          _spinNotifier.cuurentNumberIndex + 4]
                                      ["number"]),
                                  int.parse(_spinNotifier.numbers[
                                          _spinNotifier.cuurentNumberIndex + 5]
                                      ["number"]),
                                ], "Six", "$number+tr");
                              }
                            }
                          }
                        },
                        child: CircleAvatar(
                          radius: 7,
                          backgroundColor: (_spinNotifier
                                  .checkIfBetSlipItemIsExistById("$number+tr"))
                              ? Colors.green
                              : Colors.white,
                          child: Icon(
                              _spinNotifier.checkIfBetSlipItemIsExistById(
                                      "$number+tr")
                                  ? Icons.check_circle
                                  : Icons.circle,
                              color:
                                  _spinNotifier.checkIfBetSlipItemIsExistById(
                                          "$number+tr")
                                      ? Colors.white
                                      : Colors.grey,
                              size: 10),
                        ),
                      )),

                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          if (_spinNotifier
                              .checkIfBetSlipItemIsExistById("$number+br")) {
                            _spinNotifier.removeBetSlipItemById('$number+br');
                          } else {
                            if (_spinNotifier.isMid) {
                              _spinNotifier.addByListToBetSlip([
                                int.parse(_spinNotifier.numbers[_spinNotifier
                                    .cuurentNumberIndex]["number"]),
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex + 1]
                                    ["number"]),
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex + 3]
                                    ["number"]),
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex + 4]
                                    ["number"]),
                              ], "Corrner", "$number+br");
                            } else if (!isTop) {
                              _spinNotifier.addByListToBetSlip([
                                int.parse(_spinNotifier.numbers[_spinNotifier
                                    .cuurentNumberIndex]["number"]),
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex - 1]
                                    ["number"]),
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex - 2]
                                    ["number"]),
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex + 1]
                                    ["number"]),
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex + 2]
                                    ["number"]),
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex + 3]
                                    ["number"]),
                              ], "Six", "$number+br");
                            } else {
                              _spinNotifier.addByListToBetSlip([
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex + 1]
                                    ["number"]),
                                int.parse(_spinNotifier.numbers[_spinNotifier
                                    .cuurentNumberIndex]["number"]),
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex + 3]
                                    ["number"]),
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex + 4]
                                    ["number"]),
                              ], "Corner", "$number+br");
                            }
                          }
                        },
                        child: CircleAvatar(
                          radius: 7,
                          backgroundColor: (_spinNotifier
                                  .checkIfBetSlipItemIsExistById("$number+br"))
                              ? Colors.green
                              : Colors.white,
                          child: Icon(
                              _spinNotifier.checkIfBetSlipItemIsExistById(
                                      "$number+br")
                                  ? Icons.check_circle
                                  : Icons.circle,
                              color:
                                  _spinNotifier.checkIfBetSlipItemIsExistById(
                                          "$number+br")
                                      ? Colors.white
                                      : Colors.grey,
                              size: 10),
                        ),
                      )),
                  // right
                  Positioned(
                      top: 30,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          if (_spinNotifier
                              .checkIfBetSlipItemIsExistById("$number+rm")) {
                            _spinNotifier.removeBetSlipItemById('$number+rm');
                          } else {
                            _spinNotifier.addByListToBetSlip([
                              int.parse(_spinNotifier
                                      .numbers[_spinNotifier.cuurentNumberIndex]
                                  ["number"]),
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex + 3]
                                  ["number"]),
                            ], "Spilt", "$number+rm");
                          }
                        },
                        child: CircleAvatar(
                          radius: 7,
                          backgroundColor: (_spinNotifier
                                  .checkIfBetSlipItemIsExistById("$number+rm"))
                              ? Colors.green
                              : Colors.white,
                          child: Icon(
                              _spinNotifier.checkIfBetSlipItemIsExistById(
                                      "$number+rm")
                                  ? Icons.check_circle
                                  : Icons.circle,
                              color:
                                  _spinNotifier.checkIfBetSlipItemIsExistById(
                                          "$number+rm")
                                      ? Colors.white
                                      : Colors.grey,
                              size: 10),
                        ),
                      )),
                  //left
                  Positioned(
                      bottom: 0,
                      left: 23,
                      child: InkWell(
                        onTap: () {
                          if (_spinNotifier
                              .checkIfBetSlipItemIsExistById("$number+mb")) {
                            _spinNotifier.removeBetSlipItemById('$number+mb');
                          } else {
                            if (_spinNotifier.isMid) {
                              _spinNotifier.addByListToBetSlip([
                                int.parse(_spinNotifier.numbers[_spinNotifier
                                    .cuurentNumberIndex]["number"]),
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex + 1]
                                    ["number"]),
                              ], "Spilt", "$number+mb");
                            } else if (!isTop) {
                              _spinNotifier.addByListToBetSlip([
                                int.parse(_spinNotifier.numbers[_spinNotifier
                                    .cuurentNumberIndex]["number"]),
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex - 1]
                                    ["number"]),
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex - 2]
                                    ["number"]),
                              ], "3 Line", "$number+mb");
                            } else {
                              _spinNotifier.addByListToBetSlip([
                                int.parse(_spinNotifier.numbers[_spinNotifier
                                    .cuurentNumberIndex]["number"]),
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex + 1]
                                    ["number"]),
                              ], "Split", "$number+mb");
                            }
                          }
                        },
                        child: CircleAvatar(
                          radius: 7,
                          backgroundColor: (_spinNotifier
                                  .checkIfBetSlipItemIsExistById("$number+mb"))
                              ? Colors.green
                              : Colors.white,
                          child: Icon(
                              _spinNotifier.checkIfBetSlipItemIsExistById(
                                      "$number+mb")
                                  ? Icons.check_circle
                                  : Icons.circle,
                              color:
                                  _spinNotifier.checkIfBetSlipItemIsExistById(
                                          "$number+mb")
                                      ? Colors.white
                                      : Colors.grey,
                              size: 10),
                        ),
                      )),

                  Positioned(
                      top: 34,
                      left: 0,
                      child: InkWell(
                        onTap: () {
                          if (_spinNotifier
                              .checkIfBetSlipItemIsExistById("$number+lm")) {
                            _spinNotifier.removeBetSlipItemById('$number+lm');
                          } else {
                            _spinNotifier.addByListToBetSlip([
                              int.parse(_spinNotifier
                                      .numbers[_spinNotifier.cuurentNumberIndex]
                                  ["number"]),
                              0,
                            ], "Split", "$number+lm");
                            _spinNotifier.addByListToBetSlip([
                              int.parse(_spinNotifier.numbers[
                                      _spinNotifier.cuurentNumberIndex - 3]
                                  ["number"]),
                              int.parse(_spinNotifier
                                      .numbers[_spinNotifier.cuurentNumberIndex]
                                  ["number"]),
                            ], "Split", "$number+lm");
                          }
                        },
                        child: CircleAvatar(
                          radius: 7,
                          backgroundColor: (_spinNotifier
                                  .checkIfBetSlipItemIsExistById("$number+lm"))
                              ? Colors.green
                              : Colors.white,
                          child: Icon(
                              _spinNotifier.checkIfBetSlipItemIsExistById(
                                      "$number+lm")
                                  ? Icons.check_circle
                                  : Icons.circle,
                              color:
                                  _spinNotifier.checkIfBetSlipItemIsExistById(
                                          "$number+lm")
                                      ? Colors.white
                                      : Colors.grey,
                              size: 10),
                        ),
                      )),

                  Positioned(
                      top: 14,
                      left: 10,
                      child: InkWell(
                        onTap: () {
                          if (_spinNotifier.checkIfBetSlipItemIsExistById(
                              "$number+center")) {
                            _spinNotifier
                                .removeBetSlipItemById('$number+center');
                          } else {
                            _spinNotifier.addByListToBetSlip([
                              int.parse(_spinNotifier
                                      .numbers[_spinNotifier.cuurentNumberIndex]
                                  ["number"]),
                            ], "Win", "$number+center");
                          }
                        },
                        child: CircleAvatar(
                          radius: 7,
                          backgroundColor:
                              (_spinNotifier.checkIfBetSlipItemIsExistById(
                                      "$number+center"))
                                  ? Colors.green
                                  : Colors.white,
                          child: Icon(
                              _spinNotifier.checkIfBetSlipItemIsExistById(
                                      "$number+center")
                                  ? Icons.check_circle
                                  : Icons.circle,
                              color:
                                  _spinNotifier.checkIfBetSlipItemIsExistById(
                                          "$number+center")
                                      ? Colors.white
                                      : Colors.grey,
                              size: 10),
                        ),
                      )),
                  if (!isTop && !_spinNotifier.isMid)
                    Positioned(
                        bottom: 0,
                        left: 0,
                        child: InkWell(
                          onTap: () {
                            if (_spinNotifier
                                .checkIfBetSlipItemIsExistById("$number+bl")) {
                              _spinNotifier.removeBetSlipItemById('$number+bl');
                            } else {
                              _spinNotifier.addByListToBetSlip([
                                0,
                                int.parse(_spinNotifier.numbers[_spinNotifier
                                    .cuurentNumberIndex]["number"]),
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex - 1]
                                    ["number"]),
                                int.parse(_spinNotifier.numbers[
                                        _spinNotifier.cuurentNumberIndex - 2]
                                    ["number"]),
                              ], "four", "$number+bl");
                            }
                          },
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor:
                                (_spinNotifier.checkIfBetSlipItemIsExistById(
                                        "$number+bl"))
                                    ? Colors.green
                                    : Colors.white,
                            child: Icon(
                                _spinNotifier.checkIfBetSlipItemIsExistById(
                                        "$number+bl")
                                    ? Icons.check_circle
                                    : Icons.circle,
                                color:
                                    _spinNotifier.checkIfBetSlipItemIsExistById(
                                            "$number+bl")
                                        ? Colors.white
                                        : Colors.grey,
                                size: 10),
                          ),
                        )),
                ],
              )
            : Container(
                height: 75,
                width: 60,
                decoration: BoxDecoration(
                    color: color,
                    border: Border.all(color: Colors.white, width: 1.2)),
                child: Text(
                  number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s12),
                ).center(),
              );
  }

  Widget _largeNumber(String number, Color color, bool show, {int? rowNumber}) {
    return InkWell(
      onTap: () {
        if (rowNumber == null) {
          _spinNotifier.setValueNotifier(show);
          _spinNotifier.setCuurentNumberIndex(_spinNotifier.numbers
              .indexWhere((element) => element["number"] == number));
          _spinNotifier.setZeroClick(false);
        } else {
          if (rowNumber == 1) {
            if (_spinNotifier
                .checkIfBetSlipItemIsExistById(rowNumber.toString())) {
              _spinNotifier.removeBetSlipItemById(rowNumber.toString());
            } else {
              _spinNotifier.addBynumberLimitToBetSlip(
                  3, 36, true, "1 to 2", rowNumber.toString());
            }
          } else if (rowNumber == 2) {
            if (_spinNotifier
                .checkIfBetSlipItemIsExistById(rowNumber.toString())) {
              _spinNotifier.removeBetSlipItemById(rowNumber.toString());
            } else {
              _spinNotifier.addBynumberLimitToBetSlip(
                  2, 35, true, "1 to 2", rowNumber.toString());
            }
          } else {
            if (_spinNotifier.checkIfBetSlipItemIsExistById("1 to 2")) {
              _spinNotifier.removeBetSlipItemById("1 to 2");
            } else {
              _spinNotifier.addBynumberLimitToBetSlip(
                  1, 34, true, "1 to 2", "1 to 2");
            }
          }
        }
        _spinNotifier.setSlectedNumber(number);
      },
      child: Container(
        height: 53,
        width: 32,
        decoration: BoxDecoration(
            color: color, border: Border.all(color: Colors.white, width: 1.2)),
        child: Text(
          number,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: FontSize.s10),
        ).center(),
      ),
    );
  }

  Widget _tableFooter() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 55,
              width: 129,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(27, 94, 32, 1),
                  border: Border.all(color: Colors.white, width: 1.5)),
              child: Center(
                child: InkWell(
                  onTap: () {
                    if (_spinNotifier.checkIfBetSlipItemIsExistById("1st 12")) {
                      _spinNotifier.removeBetSlipItemById("1st 12");
                    } else {
                      _spinNotifier.addBynumberLimitToBetSlip(
                          1, 12, true, "1st 12", "1st 12",
                          plus: 1);
                    }
                  },
                  child: Container(
                    height: 30,
                    width: 90,
                    decoration: BoxDecoration(
                        color: Colors.green.shade900,
                        border: Border.all(color: Colors.white, width: 1.2)),
                    child: const Text(
                      "1st 12",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: FontSize.s10),
                    ).center(),
                  ),
                ),
              ),
            ),
            Container(
              height: 55,
              width: 129,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(27, 94, 32, 1),
                  border: Border.all(color: Colors.white, width: 1.5)),
              child: Center(
                child: InkWell(
                  onTap: () {
                    if (_spinNotifier.checkIfBetSlipItemIsExistById("2nd 12")) {
                      _spinNotifier.removeBetSlipItemById("2nd 12");
                    } else {
                      _spinNotifier.addBynumberLimitToBetSlip(
                          13, 24, true, "2nd 12", "2nd 12",
                          plus: 1);
                    }
                  },
                  child: Container(
                    height: 30,
                    width: 90,
                    decoration: BoxDecoration(
                        color: Colors.green.shade900,
                        border: Border.all(color: Colors.white, width: 1.2)),
                    child: const Text(
                      "2nd 12",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: FontSize.s10),
                    ).center(),
                  ),
                ),
              ),
            ),
            Container(
              height: 55,
              width: 129,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(27, 94, 32, 1),
                  border: Border.all(color: Colors.white, width: 1.5)),
              child: Center(
                child: InkWell(
                  onTap: () {
                    if (_spinNotifier.checkIfBetSlipItemIsExistById("3rd 12")) {
                      _spinNotifier.removeBetSlipItemById("3rd 12");
                    } else {
                      _spinNotifier.addBynumberLimitToBetSlip(
                          25, 36, true, "3rd 12", "3rd 12",
                          plus: 1);
                    }
                  },
                  child: Container(
                    height: 30,
                    width: 90,
                    decoration: BoxDecoration(
                        color: Colors.green.shade900,
                        border: Border.all(color: Colors.white, width: 1.2)),
                    child: const Text(
                      "3rd 12",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: FontSize.s10),
                    ).center(),
                  ),
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
              height: 55,
              width: 129,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(27, 94, 32, 1),
                  border: Border.all(color: Colors.white, width: 1.5)),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (_spinNotifier
                              .checkIfBetSlipItemIsExistById("1 - 18")) {
                            _spinNotifier.removeBetSlipItemById("1 - 18");
                          } else {
                            _spinNotifier.addBynumberLimitToBetSlip(
                                1, 18, false, "1 - 18", "1 - 18");
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green.shade900,
                              border: const Border(
                                  right: BorderSide(
                                      color: Colors.white, width: 1))),
                          child: const Text(
                            "1 - 18",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: FontSize.s10),
                          ).center(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (_spinNotifier
                              .checkIfBetSlipItemIsExistById("19-36")) {
                            _spinNotifier.removeBetSlipItemById("19-36");
                          } else {
                            _spinNotifier.addBynumberLimitToBetSlip(
                                19, 36, false, "19-36", "19-36");
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green.shade900,
                          ),
                          child: const Text(
                            "19-36",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: FontSize.s10),
                          ).center(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 55,
              width: 129,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(27, 94, 32, 1),
                  border: Border.all(color: Colors.white, width: 1.5)),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (_spinNotifier
                              .checkIfBetSlipItemIsExistById("red")) {
                            _spinNotifier.removeBetSlipItemById("red");
                          } else {
                            _spinNotifier.addByColorToBetSlip(
                                Colors.red, "red");
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green.shade900,
                              border: const Border(
                                  right: BorderSide(
                                      color: Colors.white, width: 1))),
                          child: Image.asset(Assets.redStar).center().padding(
                              padding: const EdgeInsets.all(AppPadding.p6)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (_spinNotifier
                              .checkIfBetSlipItemIsExistById("black")) {
                            _spinNotifier.removeBetSlipItemById("black");
                          } else {
                            _spinNotifier.addByColorToBetSlip(
                                Colors.black, "black");
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green.shade900,
                          ),
                          child: Image.asset(Assets.blackStar).center().padding(
                              padding: const EdgeInsets.all(AppPadding.p6)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 55,
              width: 129,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(27, 94, 32, 1),
                  border: Border.all(color: Colors.white, width: 1.5)),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (_spinNotifier
                              .checkIfBetSlipItemIsExistById("even")) {
                            _spinNotifier.removeBetSlipItemById("even");
                          } else {
                            _spinNotifier.addEvenToBetSlip("even");
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green.shade900,
                              border: const Border(
                                  right: BorderSide(
                                      color: Colors.white, width: 1))),
                          child: const Text(
                            "Even",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: FontSize.s12),
                          ).center(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (_spinNotifier
                              .checkIfBetSlipItemIsExistById("odd")) {
                            _spinNotifier.removeBetSlipItemById("odd");
                          } else {
                            _spinNotifier.addOddToBetSlip("odd");
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green.shade900,
                          ),
                          child: const Text(
                            "Odd",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: FontSize.s12),
                          ).center(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                if (_spinNotifier
                    .checkIfBetSlipItemIsExistById("14,31,9,22,18,29")) {
                  _spinNotifier.removeBetSlipItemById("14,31,9,22,18,29");
                } else {
                  _spinNotifier.addByListToBetSlip(
                      [14, 31, 9, 22, 18, 29], "Sector", "14,31,9,22,18,29");
                }
              },
              child: Container(
                height: 55,
                width: 129,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(27, 94, 32, 1),
                    border: Border.all(color: Colors.white, width: 1.5)),
                child: Center(
                  child: Container(
                    height: 30,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.green.shade900,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "14,31,9,22,18,29",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: FontSize.s10),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 5,
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(20)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (_spinNotifier
                    .checkIfBetSlipItemIsExistById("25,17,34,6,27,13")) {
                  _spinNotifier.removeBetSlipItemById("25,17,34,6,27,13");
                } else {
                  _spinNotifier.addByListToBetSlip(
                      [25, 17, 34, 6, 27, 13], "Sector", "25,17,34,6,27,13");
                }
              },
              child: Container(
                height: 55,
                width: 129,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(27, 94, 32, 1),
                    border: Border.all(color: Colors.white, width: 1.5)),
                child: Center(
                  child: Container(
                    height: 30,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.green.shade900,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "25,17,34,6,27,13",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: FontSize.s10),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 5,
                          decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(20)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (_spinNotifier
                    .checkIfBetSlipItemIsExistById("32,15,19,4,21,2")) {
                  _spinNotifier.removeBetSlipItemById("32,15,19,4,21,2");
                } else {
                  _spinNotifier.addByListToBetSlip(
                      [32, 15, 19, 4, 21, 2], "Sector", "32,15,19,4,21,2");
                }
              },
              child: Container(
                height: 55,
                width: 129,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(27, 94, 32, 1),
                    border: Border.all(color: Colors.white, width: 1.5)),
                child: Center(
                  child: Container(
                    height: 30,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.green.shade900,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "32,15,19,4,21,2",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: FontSize.s10),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 5,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(20)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                if (_spinNotifier
                    .checkIfBetSlipItemIsExistById("36,11,30,8,23,10")) {
                  _spinNotifier.removeBetSlipItemById("36,11,30,8,23,10");
                } else {
                  _spinNotifier.addByListToBetSlip(
                      [36, 11, 30, 8, 23, 10], "Sector", "36,11,30,8,23,10");
                }
              },
              child: Container(
                height: 55,
                width: 129,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(27, 94, 32, 1),
                    border: Border.all(color: Colors.white, width: 1.5)),
                child: Center(
                  child: Container(
                    height: 30,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.green.shade900,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "36,11,30,8,23,10",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: FontSize.s10),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 5,
                          decoration: BoxDecoration(
                              color: Colors.purpleAccent,
                              borderRadius: BorderRadius.circular(20)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (_spinNotifier
                    .checkIfBetSlipItemIsExistById("5,24,16,33,1,20")) {
                  _spinNotifier.removeBetSlipItemById("5,24,16,33,1,20");
                } else {
                  _spinNotifier.addByListToBetSlip(
                      [5, 24, 16, 33, 1, 20], "Sector", "5,24,16,33,1,20");
                }
              },
              child: Container(
                height: 55,
                width: 129,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(27, 94, 32, 1),
                    border: Border.all(color: Colors.white, width: 1.5)),
                child: Center(
                  child: Container(
                    height: 30,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.green.shade900,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "5,24,16,33,1,20",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: FontSize.s10),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 5,
                          decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(20)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (_spinNotifier
                    .checkIfBetSlipItemIsExistById("7,28,12,35,3,26")) {
                  _spinNotifier.removeBetSlipItemById("7,28,12,35,3,26");
                } else {
                  _spinNotifier.addByListToBetSlip(
                      [7, 28, 12, 35, 3, 26], "Sector", "7,28,12,35,3,26");
                }
              },
              child: Container(
                height: 55,
                width: 129,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(27, 94, 32, 1),
                    border: Border.all(color: Colors.white, width: 1.5)),
                child: Center(
                  child: Container(
                    height: 30,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.green.shade900,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "7,28,12,35,3,26",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: FontSize.s10),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 5,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _betSlip() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: _themeNotifier.getTheme().primaryColorLight,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                Strings.betSlip,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 120,
                child: Consumer<GeneralConfigurationNotifier>(
                  builder: (context, provider, child) {
                    return provider.currency != null
                        ? DropDownSelect<String>(
                            items: provider.currency!.data!
                                .map((e) => e.currencySymbol!)
                                .toList(),
                            onChanged: (value) {},
                            hintText:
                                provider.currency!.data!.first.currencySymbol!,
                          )
                        : const Text("");
                  },
                ),
              ),
            ],
          ).padding(padding: const EdgeInsets.all(AppPadding.p2)),
        ),
        Expanded(
          child: ListView.builder(
//physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) =>
                _betSlipItem(_spinNotifier.betSlipItem[index], index),
            itemCount: _spinNotifier.betSlipItem.length,
            shrinkWrap: true,
          ),
        )
      ],
    );
  }

  Widget _betSlipItem(BetSlipItem betSlipItem, int index) {
    betSlipItem.numbers.sort((a, b) => a.compareTo(b));
    return Container(
        decoration: BoxDecoration(
            color: _themeNotifier.getTheme().primaryColorDark,
            borderRadius: index == 0
                ? null
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        betSlipItem.numbers
                            .toString()
                            .replaceAll("[", "")
                            .replaceAll("]", ""),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        betSlipItem.type,
                        style: const TextStyle(fontSize: FontSize.s12),
                      ),
                      Text(
                        "No",
                        style: _themeNotifier.getTheme().textTheme.headline1,
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      _spinNotifier.removeBetSlipItem(index);
                    },
                    child: SvgPicture.asset(
                      Assets.delete,
                      color: _isDarkTheme
                          ? ColorManager.white
                          : const Color(0xFF525C6E),
                    ).padding(padding: const EdgeInsets.all(AppPadding.p8)),
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  betSlipItem.oddValue.toString(),
                  style: _themeNotifier.getTheme().textTheme.headline6,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    width: AppSize.s160,
                    height: AppSize.s40,
                    decoration: BoxDecoration(
                        color: const Color(0xFFDEE2E7),
                        borderRadius: BorderRadius.circular(AppSize.s8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            _spinNotifier.changeNumber(
                                _spinNotifier.textEditingControllerValue - 100);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                    color:
                                        _themeNotifier.getTheme().dividerColor),
                              ),
                            ),
                            child: Icon(
                              Icons.remove,
                              size: AppSize.s16,
                              color: _themeNotifier.getTheme().dividerColor,
                            )
                                .padding(
                                    padding:
                                        const EdgeInsets.all(AppPadding.p8))
                                .center(),
                          ),
                        ),
                        Expanded(
                            child: TextFormField(
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          onChanged: (value) {},
                          controller: _spinNotifier.textEditingController,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              textStyle: getBoldStyle(
                                  color: ColorManager.black,
                                  fontSize: FontSize.s15)),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ).padding(
                                padding: const EdgeInsets.only(
                                    bottom: AppPadding.p6))),
                        InkWell(
                          onTap: () {
                            _spinNotifier.changeNumber(_spinNotifier
                                    .textEditingControllerValue =
                                _spinNotifier.textEditingControllerValue + 100);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                    color:
                                        _themeNotifier.getTheme().dividerColor),
                              ),
                            ),
                            child: Icon(
                              Icons.add,
                              size: AppSize.s16,
                              color: _themeNotifier.getTheme().dividerColor,
                            )
                                .padding(
                                    padding:
                                        const EdgeInsets.all(AppPadding.p8))
                                .center(),
                          ),
                        )
                      ],
                    ))
              ],
            ),
            const Divider()
                .padding(padding: const EdgeInsets.all(AppPadding.p12))
          ],
        ).padding(padding: const EdgeInsets.all(AppPadding.p8)));
  }

  Widget _neighbours() {
    return Container(
      width: 580,
      // margin: EdgeInsets.only(right: 70),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        shape: BoxShape.rectangle,
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            Colors.black,
            Colors.green.shade900,
          ],
        ),
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(90.0),
          right: Radius.circular(90.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _number(_spinNotifier.neighboursList[1]["number"],
                  _spinNotifier.neighboursList[1]["color"], 1),
              _number(_spinNotifier.neighboursList[2]["number"],
                  _spinNotifier.neighboursList[2]["color"], 2),
              _number(_spinNotifier.neighboursList[3]["number"],
                  _spinNotifier.neighboursList[3]["color"], 3),
              _number(_spinNotifier.neighboursList[4]["number"],
                  _spinNotifier.neighboursList[4]["color"], 4),
              _number(_spinNotifier.neighboursList[5]["number"],
                  _spinNotifier.neighboursList[5]["color"], 5),
              _number(_spinNotifier.neighboursList[6]["number"],
                  _spinNotifier.neighboursList[6]["color"], 6),
              _number(_spinNotifier.neighboursList[7]["number"],
                  _spinNotifier.neighboursList[7]["color"], 7),
              _number(_spinNotifier.neighboursList[8]["number"],
                  _spinNotifier.neighboursList[8]["color"], 8),
              _number(_spinNotifier.neighboursList[9]["number"],
                  _spinNotifier.neighboursList[9]["color"], 9),
              _number(_spinNotifier.neighboursList[10]["number"],
                  _spinNotifier.neighboursList[10]["color"], 10),
              _number(_spinNotifier.neighboursList[11]["number"],
                  _spinNotifier.neighboursList[11]["color"], 11),
              _number(_spinNotifier.neighboursList[12]["number"],
                  _spinNotifier.neighboursList[12]["color"], 12),
              _number(_spinNotifier.neighboursList[13]["number"],
                  _spinNotifier.neighboursList[13]["color"], 13),
              _number(_spinNotifier.neighboursList[14]["number"],
                  _spinNotifier.neighboursList[14]["color"], 14),
              _number(_spinNotifier.neighboursList[15]["number"],
                  _spinNotifier.neighboursList[15]["color"], 15),
              _number(_spinNotifier.neighboursList[16]["number"],
                  _spinNotifier.neighboursList[16]["color"], 16),
              _number(_spinNotifier.neighboursList[17]["number"],
                  _spinNotifier.neighboursList[17]["color"], 17),
            ],
          ).padding(padding: const EdgeInsets.only(left: 82)),
          Row(
            children: [
              InkWell(
                onTap: () {
                  if (_spinNotifier
                      .checkIfBetSlipItemIsExistById("0neighbours")) {
                    _spinNotifier.removeBetSlipItemById("0neighbours");
                  } else {
                    _spinNotifier.addByIndexToBetSlip(
                        0, "neighbours", "0neighbours");
                  }
                },
                child: Container(
                  height: 100,
                  width: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  child: const Text(
                    "0",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: FontSize.s15),
                  ).center(),
                ),
              ),
              Container(
                height: 100,
                width: 492,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  color: _themeNotifier.getTheme().primaryColor,
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(50.0),
                    right: Radius.circular(50.0),
                  ),
                ),
                child: const Text(
                  "Neighbours",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: FontSize.s15),
                ).center(),
              ),
              Container(
                height: 100,
                width: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (_spinNotifier
                              .checkIfBetSlipItemIsExistById("10neighbours")) {
                            _spinNotifier.removeBetSlipItemById("10neighbours");
                          } else {
                            _spinNotifier.addByIndexToBetSlip(
                                18, "neighbours", "10neighbours");
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 20, right: 10),
                          child: const Text(
                            "10",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: FontSize.s15),
                          ).center(),
                        ),
                      ),
                    ),
                    const Divider(color: Colors.white, thickness: 2),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (_spinNotifier
                              .checkIfBetSlipItemIsExistById("5neighbours")) {
                            _spinNotifier.removeBetSlipItemById("5neighbours");
                          } else {
                            _spinNotifier.addByIndexToBetSlip(
                                19, "neighbours", "5neighbours");
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 20, right: 10),
                          child: const Text(
                            "5",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: FontSize.s15),
                          ).center(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _number(_spinNotifier.neighboursList[36]["number"],
                  _spinNotifier.neighboursList[36]["color"], 36),
              _number(_spinNotifier.neighboursList[35]["number"],
                  _spinNotifier.neighboursList[35]["color"], 35),
              _number(_spinNotifier.neighboursList[34]["number"],
                  _spinNotifier.neighboursList[34]["color"], 34),
              _number(_spinNotifier.neighboursList[33]["number"],
                  _spinNotifier.neighboursList[33]["color"], 33),
              _number(_spinNotifier.neighboursList[32]["number"],
                  _spinNotifier.neighboursList[32]["color"], 32),
              _number(_spinNotifier.neighboursList[31]["number"],
                  _spinNotifier.neighboursList[31]["color"], 31),
              _number(_spinNotifier.neighboursList[30]["number"],
                  _spinNotifier.neighboursList[30]["color"], 30),
              _number(_spinNotifier.neighboursList[29]["number"],
                  _spinNotifier.neighboursList[29]["color"], 29),
              _number(_spinNotifier.neighboursList[28]["number"],
                  _spinNotifier.neighboursList[28]["color"], 28),
              _number(_spinNotifier.neighboursList[27]["number"],
                  _spinNotifier.neighboursList[27]["color"], 27),
              _number(_spinNotifier.neighboursList[26]["number"],
                  _spinNotifier.neighboursList[26]["color"], 26),
              _number(_spinNotifier.neighboursList[25]["number"],
                  _spinNotifier.neighboursList[25]["color"], 25),
              _number(_spinNotifier.neighboursList[24]["number"],
                  _spinNotifier.neighboursList[24]["color"], 24),
              _number(_spinNotifier.neighboursList[23]["number"],
                  _spinNotifier.neighboursList[23]["color"], 23),
              _number(_spinNotifier.neighboursList[22]["number"],
                  _spinNotifier.neighboursList[22]["color"], 22),
              _number(_spinNotifier.neighboursList[21]["number"],
                  _spinNotifier.neighboursList[21]["color"], 21),
              _number(_spinNotifier.neighboursList[20]["number"],
                  _spinNotifier.neighboursList[20]["color"], 20),
            ],
          ).padding(padding: const EdgeInsets.only(left: 82)),
        ],
      ),
    );
  }

  Widget _overlayItem() {
    _spinNotifier.checkIfNumberInMid();

    bool isTop = int.parse(_spinNotifier
                .numbers[_spinNotifier.cuurentNumberIndex]["number"]) %
            3 ==
        0;
    return Stack(
      children: [
        Positioned(
            top: 15,
            right: 10,
            child: InkWell(
                onTap: () {
                  _spinNotifier.setValueNotifier(false);
                  _spinNotifier.setZeroClick(false);
                },
                child: const Icon(
                  Icons.close,
                  size: AppSize.s40,
                ))),
        Positioned(
            top: size.height / 5.5,
            bottom: 0,
            right: size.width / 2.5,
            // left:MediaQuery.of(context).size.width/2,
            child: _spinNotifier.zeroClick ||
                    _spinNotifier.cuurentNumberIndex <= 3 ||
                    _spinNotifier.cuurentNumberIndex >=
                        _spinNotifier.numbers.length - 3
                ? _spinNotifier.cuurentNumberIndex >=
                        _spinNotifier.numbers.length - 3
                    ? Row(
                        children: [
                          // Column(
                          //   children: [
                          //     _largeNumberOverlay(
                          //         _spinNotifier.numbers[27]["number"],
                          //         _spinNotifier.numbers[27]["color"],
                          //         false),
                          //     _largeNumberOverlay(
                          //         _spinNotifier.numbers[28]["number"],
                          //         _spinNotifier.numbers[28]["color"],
                          //         false),
                          //     _largeNumberOverlay(
                          //         _spinNotifier.numbers[29]["number"],
                          //         _spinNotifier.numbers[29]["color"],
                          //         false),
                          //   ],
                          // ),
                          Column(
                            children: [
                              _largeNumberOverlay(
                                  _spinNotifier.numbers[30]["number"],
                                  _spinNotifier.numbers[30]["color"],
                                  false),
                              _largeNumberOverlay(
                                  _spinNotifier.numbers[31]["number"],
                                  _spinNotifier.numbers[31]["color"],
                                  false),
                              _largeNumberOverlay(
                                  _spinNotifier.numbers[32]["number"],
                                  _spinNotifier.numbers[32]["color"],
                                  false),
                            ],
                          ),
                          Column(
                            children: [
                              _largeNumberOverlay(
                                  _spinNotifier.numbers[33]["number"],
                                  _spinNotifier.numbers[33]["color"],
                                  false),
                              _largeNumberOverlay(
                                  _spinNotifier.numbers[34]["number"],
                                  _spinNotifier.numbers[34]["color"],
                                  false),
                              _largeNumberOverlay(
                                  _spinNotifier.numbers[35]["number"],
                                  _spinNotifier.numbers[35]["color"],
                                  false),
                            ],
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          _spinNotifier.zeroClick
                              ? Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        child: const Text(
                                          "0",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ).center(),
                                        height: 225,
                                        // margin: const EdgeInsets.only(bottom: 26),
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.green.shade900,
                                            border: Border.all(
                                                color: Colors.white,
                                                width: 1.8)),
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 55,
                                        right: 0,
                                        child: InkWell(
                                          onTap: () {
                                            if (_spinNotifier
                                                .checkIfBetSlipItemIsExistById(
                                                    "011Win")) {
                                              _spinNotifier
                                                  .removeBetSlipItemById(
                                                      '011Win');
                                            } else {
                                              _spinNotifier
                                                  .addBynumberLimitToBetSlip(
                                                      0,
                                                      1,
                                                      false,
                                                      "Split",
                                                      "011Win",
                                                      fromZeroSide: true);
                                            }
                                          },
                                          child: CircleAvatar(
                                            radius: 7,
                                            backgroundColor: (_spinNotifier
                                                    .checkIfBetSlipItemIsExistById(
                                                        "011Win"))
                                                ? Colors.green
                                                : Colors.white,
                                            child: Icon(
                                                _spinNotifier
                                                        .checkIfBetSlipItemIsExistById(
                                                            "011Win")
                                                    ? Icons.check_circle
                                                    : Icons.circle,
                                                color: _spinNotifier
                                                        .checkIfBetSlipItemIsExistById(
                                                            "011Win")
                                                    ? Colors.white
                                                    : Colors.grey,
                                                size: 10),
                                          ),
                                        )),
                                    Positioned(
                                        bottom: 98,
                                        left: 10,
                                        child: InkWell(
                                          onTap: () {
                                            if (_spinNotifier
                                                .checkIfBetSlipItemIsExistById(
                                                    "0Win")) {
                                              _spinNotifier
                                                  .removeBetSlipItemById(
                                                      '0Win');
                                            } else {
                                              _spinNotifier
                                                  .addBynumberLimitToBetSlip(0,
                                                      0, false, "Win", "0Win",
                                                      fromZeroSide: true);
                                            }
                                          },
                                          child: CircleAvatar(
                                            radius: 7,
                                            backgroundColor: (_spinNotifier
                                                    .checkIfBetSlipItemIsExistById(
                                                        "0Win"))
                                                ? Colors.green
                                                : Colors.white,
                                            child: Icon(
                                                _spinNotifier
                                                        .checkIfBetSlipItemIsExistById(
                                                            "0Win")
                                                    ? Icons.check_circle
                                                    : Icons.circle,
                                                color: _spinNotifier
                                                        .checkIfBetSlipItemIsExistById(
                                                            "0Win")
                                                    ? Colors.white
                                                    : Colors.grey,
                                                size: 10),
                                          ),
                                        )),
                                    Positioned(
                                        bottom: 29,
                                        right: -1,
                                        child: InkWell(
                                          onTap: () {
                                            if (_spinNotifier
                                                .checkIfBetSlipItemIsExistById(
                                                    "01Win")) {
                                              _spinNotifier
                                                  .removeBetSlipItemById(
                                                      '01Win');
                                            } else {
                                              _spinNotifier
                                                  .addBynumberLimitToBetSlip(0,
                                                      3, false, "Four", "01Win",
                                                      fromZeroSide: true);
                                            }
                                          },
                                          child: CircleAvatar(
                                            radius: 7,
                                            backgroundColor: (_spinNotifier
                                                    .checkIfBetSlipItemIsExistById(
                                                        "01Win"))
                                                ? Colors.green
                                                : Colors.white,
                                            child: Icon(
                                                _spinNotifier
                                                        .checkIfBetSlipItemIsExistById(
                                                            "01Win")
                                                    ? Icons.check_circle
                                                    : Icons.circle,
                                                color: _spinNotifier
                                                        .checkIfBetSlipItemIsExistById(
                                                            "01Win")
                                                    ? Colors.white
                                                    : Colors.grey,
                                                size: 10),
                                          ),
                                        )),
                                    Positioned(
                                        bottom: 140,
                                        right: -2,
                                        child: InkWell(
                                          onTap: () {
                                            if (_spinNotifier
                                                .checkIfBetSlipItemIsExistById(
                                                    "2Win")) {
                                              _spinNotifier
                                                  .removeBetSlipItemById(
                                                      '2Win');
                                            } else {
                                              _spinNotifier.addByListToBetSlip(
                                                  [0, 2], "Split", "2Win");
                                            }
                                          },
                                          child: CircleAvatar(
                                            radius: 7,
                                            backgroundColor: (_spinNotifier
                                                    .checkIfBetSlipItemIsExistById(
                                                        "2Win"))
                                                ? Colors.green
                                                : Colors.white,
                                            child: Icon(
                                                _spinNotifier
                                                        .checkIfBetSlipItemIsExistById(
                                                            "2Win")
                                                    ? Icons.check_circle
                                                    : Icons.circle,
                                                color: _spinNotifier
                                                        .checkIfBetSlipItemIsExistById(
                                                            "2Win")
                                                    ? Colors.white
                                                    : Colors.grey,
                                                size: 10),
                                          ),
                                        )),
                                    Positioned(
                                        bottom: 210,
                                        right: -2,
                                        child: InkWell(
                                          onTap: () {
                                            if (_spinNotifier
                                                .checkIfBetSlipItemIsExistById(
                                                    "3Win")) {
                                              _spinNotifier
                                                  .removeBetSlipItemById(
                                                      '3Win');
                                            } else {
                                              _spinNotifier.addByListToBetSlip(
                                                  [0, 3], "Split", "3Win");
                                            }
                                          },
                                          child: CircleAvatar(
                                            radius: 7,
                                            backgroundColor: (_spinNotifier
                                                    .checkIfBetSlipItemIsExistById(
                                                        "3Win"))
                                                ? Colors.green
                                                : Colors.white,
                                            child: Icon(
                                                _spinNotifier
                                                        .checkIfBetSlipItemIsExistById(
                                                            "3Win")
                                                    ? Icons.check_circle
                                                    : Icons.circle,
                                                color: _spinNotifier
                                                        .checkIfBetSlipItemIsExistById(
                                                            "3Win")
                                                    ? Colors.white
                                                    : Colors.grey,
                                                size: 10),
                                          ),
                                        )),
                                  ],
                                )
                              : Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    child: const Text(
                                      "0",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ).center(),
                                    height: 225,
                                    // margin: const EdgeInsets.only(bottom: 26),
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.green.shade900,
                                        border: Border.all(
                                            color: Colors.white, width: 1.8)),
                                  ),
                                ),
                          Column(
                            children: [
                              Stack(
                                children: [
                                  _largeNumberOverlay(
                                      _spinNotifier.numbers[0]["number"],
                                      _spinNotifier.numbers[0]["color"],
                                      false),
                                ],
                              ),
                              _largeNumberOverlay(
                                  _spinNotifier.numbers[1]["number"],
                                  _spinNotifier.numbers[1]["color"],
                                  false),
                              _largeNumberOverlay(
                                  _spinNotifier.numbers[2]["number"],
                                  _spinNotifier.numbers[2]["color"],
                                  false),
                            ],
                          ),
                          if (_spinNotifier.cuurentNumberIndex <= 3)
                            Column(
                              children: [
                                _largeNumberOverlay(
                                    _spinNotifier.numbers[3]["number"],
                                    _spinNotifier.numbers[3]["color"],
                                    false),
                                _largeNumberOverlay(
                                    _spinNotifier.numbers[4]["number"],
                                    _spinNotifier.numbers[4]["color"],
                                    false),
                                _largeNumberOverlay(
                                    _spinNotifier.numbers[5]["number"],
                                    _spinNotifier.numbers[5]["color"],
                                    false),
                              ],
                            ),
                        ],
                      )
                : Column(
                    children: [
                      Row(
                        children: [
                          _largeNumberOverlay(
                              _spinNotifier.numbers[_spinNotifier.isMid
                                  ? _spinNotifier.cuurentNumberIndex - 4
                                  : _spinNotifier.cuurentNumberIndex >= 4
                                      ? isTop
                                          ? _spinNotifier.cuurentNumberIndex - 3
                                          : _spinNotifier.cuurentNumberIndex - 5
                                      : _spinNotifier.cuurentNumberIndex -
                                          3]["number"],
                              _spinNotifier.numbers[_spinNotifier.isMid
                                  ? _spinNotifier.cuurentNumberIndex - 4
                                  : _spinNotifier.cuurentNumberIndex >= 4
                                      ? isTop
                                          ? _spinNotifier.cuurentNumberIndex - 3
                                          : _spinNotifier.cuurentNumberIndex - 5
                                      : _spinNotifier.cuurentNumberIndex -
                                          3]["color"],
                              false),
                          _largeNumberOverlay(
                              _spinNotifier.numbers[_spinNotifier.isMid
                                  ? _spinNotifier.cuurentNumberIndex - 1
                                  : _spinNotifier.cuurentNumberIndex >= 4
                                      ? isTop
                                          ? _spinNotifier.cuurentNumberIndex
                                          : _spinNotifier.cuurentNumberIndex - 2
                                      : _spinNotifier
                                          .cuurentNumberIndex]["number"],
                              _spinNotifier.numbers[_spinNotifier.isMid
                                  ? _spinNotifier.cuurentNumberIndex - 1
                                  : _spinNotifier.cuurentNumberIndex >= 4
                                      ? isTop
                                          ? _spinNotifier.cuurentNumberIndex
                                          : _spinNotifier.cuurentNumberIndex - 2
                                      : _spinNotifier
                                          .cuurentNumberIndex]["color"],
                              false),
                          _largeNumberOverlay(
                              _spinNotifier.numbers[_spinNotifier.isMid
                                  ? _spinNotifier.cuurentNumberIndex + 2
                                  : _spinNotifier.cuurentNumberIndex >= 4
                                      ? isTop
                                          ? _spinNotifier.cuurentNumberIndex + 3
                                          : _spinNotifier.cuurentNumberIndex + 1
                                      : _spinNotifier.cuurentNumberIndex +
                                          3]["number"],
                              _spinNotifier.numbers[_spinNotifier.isMid
                                  ? _spinNotifier.cuurentNumberIndex + 2
                                  : _spinNotifier.cuurentNumberIndex >= 4
                                      ? isTop
                                          ? _spinNotifier.cuurentNumberIndex + 3
                                          : _spinNotifier.cuurentNumberIndex + 1
                                      : _spinNotifier.cuurentNumberIndex +
                                          3]["color"],
                              false)
                        ],
                      ),
                      Row(
                        children: [
                          _largeNumberOverlay(
                              _spinNotifier.numbers[_spinNotifier.isMid
                                  ? _spinNotifier.cuurentNumberIndex - 3
                                  : _spinNotifier.cuurentNumberIndex >= 4
                                      ? isTop
                                          ? _spinNotifier.cuurentNumberIndex - 2
                                          : _spinNotifier.cuurentNumberIndex - 4
                                      : _spinNotifier.cuurentNumberIndex -
                                          2]["number"],
                              _spinNotifier.numbers[_spinNotifier.isMid
                                  ? _spinNotifier.cuurentNumberIndex - 3
                                  : _spinNotifier.cuurentNumberIndex >= 4
                                      ? isTop
                                          ? _spinNotifier.cuurentNumberIndex - 2
                                          : _spinNotifier.cuurentNumberIndex - 4
                                      : _spinNotifier.cuurentNumberIndex -
                                          2]["color"],
                              false),
                          _largeNumberOverlay(
                              _spinNotifier.numbers[_spinNotifier.isMid
                                  ? _spinNotifier.cuurentNumberIndex
                                  : _spinNotifier.cuurentNumberIndex >= 4
                                      ? isTop
                                          ? _spinNotifier.cuurentNumberIndex + 1
                                          : _spinNotifier.cuurentNumberIndex - 1
                                      : _spinNotifier.cuurentNumberIndex +
                                          1]["number"],
                              _spinNotifier.numbers[_spinNotifier.isMid
                                  ? _spinNotifier.cuurentNumberIndex
                                  : _spinNotifier.cuurentNumberIndex >= 4
                                      ? isTop
                                          ? _spinNotifier.cuurentNumberIndex + 1
                                          : _spinNotifier.cuurentNumberIndex - 1
                                      : _spinNotifier.cuurentNumberIndex +
                                          1]["color"],
                              false),
                          _largeNumberOverlay(
                              _spinNotifier.numbers[_spinNotifier.isMid
                                  ? _spinNotifier.cuurentNumberIndex + 3
                                  : _spinNotifier.cuurentNumberIndex >= 4
                                      ? isTop
                                          ? _spinNotifier.cuurentNumberIndex + 4
                                          : _spinNotifier.cuurentNumberIndex + 2
                                      : _spinNotifier.cuurentNumberIndex +
                                          4]["number"],
                              _spinNotifier.numbers[_spinNotifier.isMid
                                  ? _spinNotifier.cuurentNumberIndex + 3
                                  : _spinNotifier.cuurentNumberIndex >= 4
                                      ? isTop
                                          ? _spinNotifier.cuurentNumberIndex + 4
                                          : _spinNotifier.cuurentNumberIndex + 2
                                      : _spinNotifier.cuurentNumberIndex +
                                          4]["color"],
                              false)
                        ],
                      ),
                      Row(
                        children: [
                          _largeNumberOverlay(
                              _spinNotifier.numbers[_spinNotifier.isMid
                                  ? _spinNotifier.cuurentNumberIndex - 2
                                  : _spinNotifier.cuurentNumberIndex >= 4
                                      ? isTop
                                          ? _spinNotifier.cuurentNumberIndex - 1
                                          : _spinNotifier.cuurentNumberIndex - 3
                                      : _spinNotifier.cuurentNumberIndex -
                                          1]["number"],
                              _spinNotifier.numbers[_spinNotifier.isMid
                                  ? _spinNotifier.cuurentNumberIndex - 2
                                  : _spinNotifier.cuurentNumberIndex >= 4
                                      ? isTop
                                          ? _spinNotifier.cuurentNumberIndex - 1
                                          : _spinNotifier.cuurentNumberIndex - 3
                                      : _spinNotifier.cuurentNumberIndex -
                                          1]["color"],
                              false),
                          _largeNumberOverlay(
                              _spinNotifier.numbers[_spinNotifier.isMid
                                  ? _spinNotifier.cuurentNumberIndex + 1
                                  : _spinNotifier.cuurentNumberIndex >= 4
                                      ? isTop
                                          ? _spinNotifier.cuurentNumberIndex + 2
                                          : _spinNotifier.cuurentNumberIndex
                                      : _spinNotifier.cuurentNumberIndex +
                                          2]["number"],
                              _spinNotifier.numbers[_spinNotifier.isMid
                                  ? _spinNotifier.cuurentNumberIndex + 1
                                  : _spinNotifier.cuurentNumberIndex >= 4
                                      ? isTop
                                          ? _spinNotifier.cuurentNumberIndex + 2
                                          : _spinNotifier.cuurentNumberIndex
                                      : _spinNotifier.cuurentNumberIndex +
                                          2]["color"],
                              false),
                          _largeNumberOverlay(
                              _spinNotifier.numbers[_spinNotifier.isMid
                                  ? _spinNotifier.cuurentNumberIndex + 4
                                  : _spinNotifier.cuurentNumberIndex >= 4
                                      ? isTop
                                          ? _spinNotifier.cuurentNumberIndex + 5
                                          : _spinNotifier.cuurentNumberIndex + 3
                                      : _spinNotifier.cuurentNumberIndex +
                                          5]["number"],
                              _spinNotifier.numbers[_spinNotifier.isMid
                                  ? _spinNotifier.cuurentNumberIndex + 4
                                  : _spinNotifier.cuurentNumberIndex >= 4
                                      ? isTop
                                          ? _spinNotifier.cuurentNumberIndex + 5
                                          : _spinNotifier.cuurentNumberIndex + 3
                                      : _spinNotifier.cuurentNumberIndex +
                                          5]["color"],
                              false)
                        ],
                      ),
                    ],
                  ))
      ],
    );
  }
}
