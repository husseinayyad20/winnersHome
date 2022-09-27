class Urls {
  /// Base URL
  static const String baseUrl = 'https://dev-mobile-app-api.boxsyst.com';

  /// API URL
  static const String api = '$baseUrl/api';

  /// GENERAL API
  static const String generalConfigurationApi = '$api/General/Configuration';
  static const String myBets = '/Members/MemberForms';
  static const String betsByBetCode = '/General/BetsByBetCode';
  static const String formsDetails = '/Members/FormsDetails';
  static const String placeBetStaticLive = '/Members/PlaceBetStaticLive';
  static const String placeBetStaticVirtual = '/Members/PlaceBetVirtual';
  // static const String placeBetSingle = '/Members/PlaceBetSingle';
  static const String placeBetSingle = '/Members/PlaceBetSingles';
    static const String betSlipConfiguration = '/General/BetSlipConfiguration';
  
  static const String createBetCode = '/General/CreateBetCode';
  static const String getSportTypesIcons = '/General/GetSportTypesIcons';

  static const String getBetSlipSportTypesIcons =
      '/General/GetBetSlipSportTypesIcons';

    static const String refreshToken = '/refreshToken';
}
