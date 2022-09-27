

import 'package:winners/user_app/core/constants/assets.dart';
import 'package:winners/user_app/core/constants/extensions/widget_extensions.dart';
import 'package:winners/user_app/core/constants/strings.dart';
import 'package:winners/user_app/core/constants/theme.dart';

import 'package:winners/user_app/presentation/notifiers/spin_win/spin_win_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/theme_notifier.dart';
import 'package:winners/user_app/presentation/pages/app_bar/app_bar.dart';
import 'package:winners/user_app/presentation/pages/spin_&_swin/widgets/table.dart';
import 'package:winners/user_app/presentation/pages/spin_&_swin/widgets/wheel.dart';
import 'package:winners/user_app/presentation/resources/color_manager.dart';
import 'package:winners/user_app/presentation/resources/fonts_manager.dart';
import 'package:winners/user_app/presentation/resources/values_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:provider/provider.dart';

class SpinAndWin extends StatefulWidget {
  const SpinAndWin({Key? key}) : super(key: key);

  @override
  State<SpinAndWin> createState() => _SpinAndWinState();
}

class _SpinAndWinState extends State<SpinAndWin>
    with WidgetsBindingObserver, TickerProviderStateMixin {

  Orientation? _currentOrientation;
  bool showTable=false;
late SpinAndWinNotifier _spinNotifier;
  @override
  void initState() {
    super.initState();
     _spinNotifier = Provider.of<SpinAndWinNotifier>(context, listen: false);
     _spinNotifier.initData();
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight
      ],
    );
    
    WidgetsBinding.instance.addObserver(this);
  
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );

    super.dispose();
  }

  @override
  void didChangeMetrics() {
    _currentOrientation = MediaQuery.of(context).orientation;
  
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _currentOrientation = MediaQuery.of(context).orientation;
      });
     
    });
  }



  late ThemeNotifier _themeNotifier;
  late bool _isDarkTheme;
  @override
  @override
  Widget build(BuildContext context) {
    _currentOrientation = MediaQuery.of(context).orientation;
    _themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);

    _isDarkTheme = (_themeNotifier.getTheme() == AppThemes().darkTheme);
    ThemeData theme =
        _isDarkTheme ? AppThemes().darkTheme : AppThemes().lightTheme;
    
    return Theme(
      data: theme,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 0.9),
        child: Scaffold(
            backgroundColor: _currentOrientation == Orientation.landscape
                ?theme.primaryColor
                : Colors.grey,
            appBar: _appBar(_isDarkTheme, _currentOrientation),
            body: _currentOrientation == Orientation.portrait
                ? SvgPicture.asset(Assets.rotate).center()
                : SafeArea(child: showTable?const TableView() : const Wheel().padding(padding: const EdgeInsets.only(top: AppPadding.p12)))),
      ),
    );
  }

  WinnersAppBar _appBar(bool isDarkTheme, Orientation? currentOrientation) {
    return WinnersAppBar(
      title: Strings.spinAndWin,
      
      height: 80,
      onBack: (() {
        Navigator.of(context).pop();
      }),
      action: currentOrientation == Orientation.landscape
          ? Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(
                            color: isDarkTheme ? Colors.white : Colors.black,
                            width: 1)),
                    width: 45,
                    height: 30,
                    child: const Text("0").center(),
                  ),
                  Text(
                    "366",
                    style: _themeNotifier.getTheme().textTheme.headline1,
                  )
                ],
              ),
              const SizedBox(
                width: AppSize.s14,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(
                            color: isDarkTheme ? Colors.white : Colors.black,
                            width: 1)),
                    width: 45,
                    height: 30,
                    child: const Text("6").center(),
                  ),
                  Text(
                    "367",
                    style: _themeNotifier.getTheme().textTheme.headline1,
                  )
                ],
              ),
              const SizedBox(
                width: AppSize.s14,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(
                            color: isDarkTheme ? Colors.white : Colors.black,
                            width: 1)),
                    width: 45,
                    height: 30,
                    child: const Text("16").center(),
                  ),
                  Text(
                    "368",
                    style: _themeNotifier.getTheme().textTheme.headline1,
                  )
                ],
              ),
              const SizedBox(
                width: AppSize.s14,
              ),
              Container(
                color: _themeNotifier.getTheme().primaryColorLight,
                width: 254,
                height: double.infinity,
                child: Row(
                  children: [
                    const SizedBox(
                      width: AppSize.s4,
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          showTable=!showTable;
                        });
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(showTable?Assets.wheel:Assets.tableIcon,width: 20,),
                          const SizedBox(
                            width: AppSize.s4,
                          ),
                          Text(showTable?Strings.toTheWheel:Strings.backToTable,
                              style: _themeNotifier.getTheme().textTheme.headline1),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: AppSize.s20,
                    ),
                    Text("388",
                        style: _themeNotifier.getTheme().textTheme.headline1),
                    const SizedBox(
                      width: AppSize.s12,
                    ),
                    Text("14:85",
                        style: _themeNotifier.getTheme().textTheme.headline1),
                    const SizedBox(
                      width: AppSize.s12,
                    ),
                    SvgPicture.asset(Assets.polygon),
                  ],
                ),
              ),
              Container(
                color: ColorManager.accentColor,
                width: 130,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Balance:",
                          style: TextStyle(
                              color: Colors.white, fontSize: FontSize.s16)),
                      SizedBox(
                        height: AppSize.s4,
                      ),
                      Text(" LD 2000,44",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: FontSize.s16)),
                    ]),
                height: double.maxFinite,
                
              )
            ])
          : null,
    );
  }
}
