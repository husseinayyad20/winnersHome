
import 'package:winners/user_app/core/constants/theme.dart';

import 'package:winners/user_app/presentation/notifiers/bet_slip/bet_slip_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/bet_slip/place_bet_functions_notifier.dart';


import 'package:winners/user_app/presentation/notifiers/general_configuration_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/home_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/spin_win/spin_win_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/theme_notifier.dart';





import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Providers {
  static List<SingleChildWidget> providersList = [

    ChangeNotifierProvider(
      lazy: false,
      create: (_) {
        return ThemeNotifier(AppThemes().darkTheme);
      },
    ),
    ChangeNotifierProvider(
      lazy: false,
      create: (_) {
        return HomeNotifier();
      },
    ),
    ChangeNotifierProvider(
      lazy: false,
      create: (_) {
        return GeneralConfigurationNotifier();
      },
    ),
    ChangeNotifierProvider(
      lazy: false,
      create: (_) {
        return BetSlipNotifier();
      },
    ),
    ChangeNotifierProvider(
      lazy: false,
      create: (_) {
        return PlaceBetSlipFunctionsNotifier();
      },
    ),
     ChangeNotifierProvider(
      lazy: false,
      create: (_) {
        return SpinAndWinNotifier();
      },
    ),
     

  ];
}
