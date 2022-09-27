import 'package:flutter/material.dart';

class AppConfig {
  static const int pageSize = 20;
    static String baseUrl = 'https://dev-mobile-app-api.winners.com.lr/api';
  static String balanceLD = "";
  static String balanceUSD = "";
  static String currency = "";
  static String bonusBalance = "";
  static String bonusBalanceCurrency = "";
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static String feedSr = "";
  static int betSlipAmountLd = 0;
  static int betSlipAmountUsd = 0;
  static bool placeBetVirtual = false;
}
