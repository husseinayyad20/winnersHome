import 'dart:convert';


import 'dart:io';


import 'package:winners/user_app/core/constants/app_config.dart';
import 'package:winners/user_app/data/constants/url_constants.dart';
import 'package:winners/user_app/data/exception.dart';
import 'package:winners/user_app/data/models/banner/banner_model.dart';
import 'package:winners/user_app/data/models/bet_slip/bet_code/bet_code.dart';
import 'package:winners/user_app/data/models/bet_slip/bet_slip.dart';
import 'package:winners/user_app/data/models/bet_slip/bet_slip_sport_icon/bet_slip_sport_icon.dart';
import 'package:winners/user_app/data/models/bet_slip/place_bet/place_bet.dart';
import 'package:winners/user_app/data/models/bet_slip_configuration/bet_slip_configuration_model.dart';
import 'package:winners/user_app/data/models/country_flag/countries_flag_model.dart';
import 'package:winners/user_app/data/models/currency/currency_model.dart';
import 'package:winners/user_app/data/models/general_configuration/general_configuration_model.dart';
import 'package:winners/user_app/data/models/header/header.dart';
import 'package:winners/user_app/data/models/leagues_tabs/leagues_tabs_model.dart';
import 'package:winners/user_app/data/models/page_model/page_model.dart';
import 'package:winners/user_app/data/models/sport_type_icon/sport_type_icon.dart';
import 'package:winners/user_app/data/models/teams_icons/teams_icons_model.dart';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:device_info_plus/device_info_plus.dart';

abstract class RemoteDataSource {
  Future<GeneralConfigurationModel> getGeneralConfiguration();

  Future<BetSlip> getBetSlip(Map<String, dynamic> data);

  Future<PlaceBet> placeBetMultiple(Map<String, dynamic> data);

  Future<PlaceBet> placeBetSingle(Map<String, dynamic> data);

  Future<CurrencyModel> getCurrency();

  Future<BetSlipConfigurationModel> getBetSlipConfiguration();

  Future<BannerModel> getBanners();

  Future<BetCode> createBetCode(Map<String, dynamic> data);

  Future<CountriesFlagModel> getCountriesFlags();
   Future<BetSlipSportIcon> getBetSlipSportsIcons();
    Future<LeaguesTabsModel> getLaguesTabs();
      Future<SportTypeIcon> getSportTypeIcon();

  Future<HeaderModel> getHeaderTabs();
    Future<TeamsIcons> getTeamsIcons();
      Future<PageModel> getPage(String pageName);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  RemoteDataSourceImpl();
  http.Client client = InterceptedClient.build(
    interceptors: [
      LoggingInterceptor(),
    ],
  );
  String token = "", memberId = "";
  
 @override
  Future<BetCode> createBetCode(Map<String, dynamic> data) async {
    String base = AppConfig.baseUrl;
    final rxPrefs = RxSharedPreferences.getInstance();
    rxPrefs.read("token", (p0) => token = p0.toString());
    rxPrefs.read("memberId", (p0) => memberId = p0.toString());
    var body = jsonEncode(data);
    final response = await client.post(
      Uri.parse(base + Urls.createBetCode),
      body: body,
      headers: {
        'Content-Type': 'application/json',
        "token": token,
        "memberId": memberId,
      },
    );
    if (response.statusCode == 200) {
      return BetCode.fromJson(json.decode(json.encode(response.body)));
    } else {
      throw ServerException();
    }
  }
  
   @override
  Future<BannerModel> getBanners() async {
    String base = AppConfig.baseUrl;
    final response = await client.get(
      Uri.parse('$base/General/GetBannerImages'),
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36',
        'Accept': '/',
        'Content-Type': 'application/json;charset=UTF-8',
        'Connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate',
      
        'Content-Length': '0',
        'MemberId': '',
        'Token': '',
        'Accept-Language': 'he-IL,he;q=0.9,en-US;q=0.8,en;q=0.7,ar;q=0.6',
      },
    );
    if (response.statusCode == 200) {
      return BannerModel.fromJson(
        json.decode(
          json.encode(
            response.body,
          ),
        ),
      );
    } else {
      throw ServerException();
    }
  }
  

  @override
  Future<BetSlip> getBetSlip(Map<String, dynamic> data) async {
    String base = AppConfig.baseUrl;
    final rxPrefs = RxSharedPreferences.getInstance();
    rxPrefs.read("token", (p0) => token = p0.toString());
    rxPrefs.read("memberId", (p0) => memberId = p0.toString());
    var body = jsonEncode(data);
    final response = await client.post(
      Uri.parse(base + Urls.betsByBetCode),
      body: body,
      headers: {
        'Content-Type': 'application/json',
        "token": token,
        "memberId": memberId,
      },
    );
    if (response.statusCode == 200) {
      return BetSlip.fromJson(json.decode(json.encode(response.body)));
    } else {
      throw ServerException();
    }
  }
  
  @override
  Future<GeneralConfigurationModel> getGeneralConfiguration() async {
    String base = AppConfig.baseUrl;

    final appversion = await PackageInfo.fromPlatform();
    final version = appversion.version;

    final response = await client.post(Uri.parse('$base/General/Configuration'),
        headers: {
          'User-Agent': 'PostmanRuntime/7.29.0',
          'Accept': '*/*',
          'Content-Type': 'application/json;charset=UTF-8',
          'Connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        
          'MemberId': '',
          'Token': '',
          'Accept-Language': 'he-IL,he;q=0.9,en-US;q=0.8,en;q=0.7,ar;q=0.6',
        },
        body: jsonEncode({
          "token": "",
          "memberId": 5846,
          "data": {"mobileAppVersion": version}
        }));

    if (response.statusCode == 200) {
      return GeneralConfigurationModel.fromJson(
          json.decode(json.encode(response.body)));
    } else {
      throw ServerException();
    }
  }
  
 @override
  Future<CountriesFlagModel> getCountriesFlags() async {
    String base = AppConfig.baseUrl;
    final response = await client.get(
      Uri.parse('$base/General/GetCountryFlagImages'),
      headers: {
        'Accept': '/',
        'Content-Type': 'application/json;charset=UTF-8',
        'Connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate',
       
        'Content-Length': '0',
        'MemberId': '',
        'Token': '',
      },
    );
    if (response.statusCode == 200) {
      return CountriesFlagModel.fromJson(
        json.decode(
          response.body,
        ),
      );
    } else {
      throw ServerException();
    }
  }
  
 
  @override
  Future<CurrencyModel> getCurrency() async {
    String base = AppConfig.baseUrl;
    final response = await client.post(
      Uri.parse('$base/General/GetCurrencies'),
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36',
        'Accept': '/',
        'Content-Type': 'application/json;charset=UTF-8',
        'Connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate',
        
        'Content-Length': '0',
        'MemberId': '',
        'Token': '',
        'Accept-Language': 'he-IL,he;q=0.9,en-US;q=0.8,en;q=0.7,ar;q=0.6',
      },
    );
    if (response.statusCode == 200) {
      return CurrencyModel.fromJson(
        json.decode(
          json.encode(
            response.body,
          ),
        ),
      );
    } else {
      throw ServerException();
    }
  }

  
 
  
   @override
  Future<PlaceBet> placeBetMultiple(Map<String, dynamic> data) async {
    String base = AppConfig.baseUrl;
    final ip = await Ipify.ipv4();
       final rxPrefs = RxSharedPreferences.getInstance();
    rxPrefs.read("token", (p0) => token = p0.toString());
    String deviceId = await getDeviceIdentifier();
    // String macAddress = '';
    // macAddress = await getMAc().then((value) => value);
    data.addEntries(
      [
        MapEntry('ip', ip),
        MapEntry('macAddress', deviceId),
      ],
    );
    var body = jsonEncode(data);

    final response = await client.post(
      Uri.parse("http://dev-ent-api.boxsyst.com/api/placeBetStaticLive"),
      body: body,
      headers: {
        'Content-Type': 'application/json',
        "Authorization": token,
        "memberId": data["memberId"],
      },
    );
    if (response.statusCode == 200) {
      return PlaceBet.fromJson(json.decode(json.encode(response.body)));
    } else {
      throw ServerException();
    }
  }
  
   @override
  Future<PlaceBet> placeBetSingle(Map<String, dynamic> data) async {
    String base = AppConfig.baseUrl;
      final rxPrefs = RxSharedPreferences.getInstance();
    rxPrefs.read("token", (p0) => token = p0.toString());
    String deviceId = await getDeviceIdentifier();
    final ip = await Ipify.ipv4();
    // String macAddress = '';
    // macAddress = await getMAc().then((value) => value);
    data.addEntries(
      [
        MapEntry('ip', ip),
        MapEntry('macAddress', deviceId),
      ],
    );
    var body = jsonEncode(data);
    final response = await client.post(
      Uri.parse("http://dev-ent-api.boxsyst.com/api/placeBetSingles"),
      body: body,
      headers: {
        'Content-Type': 'application/json',
        "Authorization": token,
        "memberId": data["memberId"],
      },
    );
    print(response.body);
    print(body);

    if (response.statusCode == 200) {
      return PlaceBet.fromJson(json.decode(json.encode(response.body)));
    } else {
      throw ServerException();
    }
  }

  
  Future<String> getDeviceIdentifier() async {
    String deviceIdentifier = "unknown";
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceIdentifier = androidInfo.id!;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceIdentifier = iosInfo.identifierForVendor!;
    }
    return deviceIdentifier;
  }
  
  @override
  Future<BetSlipConfigurationModel> getBetSlipConfiguration() async {
    String base = AppConfig.baseUrl;

    final response = await client.post(
       Uri.parse(base + Urls.betSlipConfiguration),
      
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36',
        'Accept': '/',
        'Content-Type': 'application/json;charset=UTF-8',
        'Connection': 'keep-alive',
       
        'Content-Length': '0',
        'MemberId': '',
        'Token': '',
        'Accept-Language': 'he-IL,he;q=0.9,en-US;q=0.8,en;q=0.7,ar;q=0.6',
      },
    );
    if (response.statusCode == 200) {
      return BetSlipConfigurationModel.fromJson(
        json.decode(
          json.encode(
            response.body,
          ),
        ),
      );
    } else {
      throw ServerException();
    }
  }
  
  @override
  Future<BetSlipSportIcon> getBetSlipSportsIcons() async {
    String base = AppConfig.baseUrl;
    final response = await client.get(
      Uri.parse("$base${Urls.getBetSlipSportTypesIcons}?ImageExtension=svg"),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return BetSlipSportIcon.fromJson(
        json.decode(
          json.encode(
            response.body,
          ),
        ),
      );
    } else {
      throw ServerException();
    }
    
  }
  
  @override
  Future<LeaguesTabsModel> getLaguesTabs() async {
    String base = AppConfig.baseUrl;
    final response = await client.get(
      Uri.parse('$base/General/GetSportTopLeaguesTabImages?ImageExtension=svg'),
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36',
        'Accept': '*/*',
        'Content-Type': 'application/json;charset=UTF-8',
        'Connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate',
      
        'Content-Length': '0',
        'MemberId': '',
        'Token': '',
        'Accept-Language': 'he-IL,he;q=0.9,en-US;q=0.8,en;q=0.7,ar;q=0.6',
      },
    );
    if (response.statusCode == 200) {
      return LeaguesTabsModel.fromJson(
        json.decode(
          json.encode(
            response.body,
          ),
        ),
      );
    } else {
      throw ServerException();
    }
  }
  
  @override
  Future<SportTypeIcon> getSportTypeIcon() async {
    String base = AppConfig.baseUrl;

    final response = await client.get(
      Uri.parse('$base${Urls.getSportTypesIcons}?ImageExtension=svg'),
      headers: {
        'Content-Type': 'application/json',
        "token": token,
        "memberId": "5846",
      },
    );
    if (response.statusCode == 200) {
      return SportTypeIcon.fromJson(json.decode(json.encode(response.body)));
    } else {
      throw ServerException();
    }
  }
  
  @override
  Future<HeaderModel> getHeaderTabs() async {
    String base = AppConfig.baseUrl;
    final response = await client.get(
      Uri.parse('$base/General/GetHeaderTabs'),
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36',
        'Accept': '/',
        'Content-Type': 'application/json;charset=UTF-8',
        'Connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate',
        
        'Content-Length': '0',
        'MemberId': '',
        'Token': '',
        'Accept-Language': 'he-IL,he;q=0.9,en-US;q=0.8,en;q=0.7,ar;q=0.6',
      },
    );
    if (response.statusCode == 200) {
      return HeaderModel.fromJson(
        json.decode(
          json.encode(
            response.body,
          ),
        ),
      );
    } else {
      throw ServerException();
    }
  }
  
   @override
  Future<TeamsIcons> getTeamsIcons() async {
    String base = AppConfig.baseUrl;
    final response = await client.get(
      Uri.parse('$base/General/GetTeamsIcons?ImageExtension=svg'),
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36',
        'Accept': '/',
        'Content-Type': 'application/json;charset=UTF-8',
        'Connection': 'keep-alive',
     
        'Content-Length': '0',
        'MemberId': '',
        'Token': '',
        'Accept-Language': 'he-IL,he;q=0.9,en-US;q=0.8,en;q=0.7,ar;q=0.6',
      },
    );
    if (response.statusCode == 200) {
      return TeamsIcons.fromJson(
        json.decode(
          json.encode(
            response.body,
          ),
        ),
      );
    } else {
      throw ServerException();
    }
  }
  
   @override
  Future<PageModel> getPage(String pageName) async {
    String base = AppConfig.baseUrl;
    final response = await client.get(
      Uri.parse('$base/Pages/$pageName'),
      headers: {
        'Accept': '/',
        'Content-Type': 'application/json;charset=UTF-8',
        'Connection': 'keep-alive',
      },
    );
    if (response.statusCode == 200) {
      return PageModel.fromJson(
        json.decode(
          json.encode(
            response.body,
          ),
        ),
      );
    } else {
      throw ServerException();
    }
  }





}

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    try {
      Map<String, dynamic> resp = jsonDecode(data.body!);
      if (resp['status'] == 4 && resp['message'] == 'No Valid Token.') {
        final rxPrefs = RxSharedPreferences.getInstance();
        rxPrefs.write('token', 'NA', (p0) => null);
      }
      return data;
    } catch (e) {
      return Future.error(Error.safeToString(e));
    }
  }
  
}
