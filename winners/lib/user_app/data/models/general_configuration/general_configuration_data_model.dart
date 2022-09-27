import 'dart:convert';

import 'package:winners/user_app/data/models/general_configuration/history_tab.dart';
import 'package:winners/user_app/data/models/general_configuration/tip_me_customer_types.dart';
import 'package:equatable/equatable.dart';

/// Response Sample
/*
  {
    "data": {
      "tokenExpiresMinutes": 5, //The time interval for Token expiration
      "placeBetSeconds": 2, //The seconds to wait before sending Bet slip to the server
      "booongoAddress": "https://gate3.betsrv.com/op/winners-prod/game.html", //Slots IFRAME URL
      "feedSR": "https://hub-feed.winners.com.lr/FeedChangesHub", // Feeds (Sports, my_bets) singalR hostname
      "booongoSR": "https://hub-bng.winners.com.lr/BooongoHub", // SignalR URL for boongo (SLOTS)
      "jackpotSR": "https://hub-bng.winners.com.lr/JackpotHub", // SignalR URL for jackspot 
      "imagesPath": "https://web-api.winners.com.lr/api/general/image/", // Base url of the images
      "vfl": "https://vflwinnersinc.aitcloud.de/vflbb/vleague.php?clientid=1365&lang=en", // Iframe for Virtual sport 
      "vhc": "https://vhc20dev.aitcloud.de/vhcstaging/vhc/index/clientid:1365/lang:en", // Iframe for Virtual sport 
      "vflm": "https://vfwinnersinc.aitcloud.de/vflm", // Iframe for Virtual sport 
      "vbl": "https://vblwinnersinc.aitcloud.de/vbl/vbl/index?clientid=1365&amp;lang=en", // Iframe for Virtual sport 
      "vto": "https://vtodev.aitcloud.de/vtostaging/vto/index/clientid:1365/lang:en", // Iframe for Virtual sport 
      "vdr": "https://vdrdev.aitcloud.de/vdrstaging/vdr/index/clientid:1365/lang:en", // Iframe for Virtual sport 
      "epl": "https://vfwinnersinc.aitcloud.de/vflmepl/desktop/index?clientid=4394&amp;lang=en&amp;layout=Vflm3", // Iframe for Virtual sport 
      "statisticsDomainUrl": "https://winners.com.lr/Statistics", // Statistics route for each match
      "statisticsStaticUrl": "https://s5.sir.sportradar.com/winnersinc/en/match", // Statistics route for each match
      "statisticsVirtualUrl": "https://s5.sir.sportradar.com/winnersinc/en/match",// Statistics route for each match
      "statisticsMenuUrl": "https://s5.sir.sportradar.com/winnersinc/en/match", // Statistics route for each match
      "id": 0,
      "name": null
    },
    "status": 1, //  Success = 1, Warning = 2, Error = 3, TokenExpired = 4
    "message": "Configuration",
    "success": true,
    "detail": null,
    "serverDateTime": 1646212771883 //Sync the app datetime with the server timestamp
  }
*/
class GeneralConfigurationDataModel extends Equatable {
  const GeneralConfigurationDataModel(
      {this.tokenExpiresMinutes,
      this.placeBetSeconds,
      this.booongoAddress,
      this.feedSr,
      this.booongoSr,
      this.jackpotSr,
      this.imagesPath,
      this.vfl,
      this.vhc,
      this.memberChangeSR,
      this.vflm,
      this.vbl,
      this.vto,
      this.vdr,
      this.epl,
      this.statisticsDomainUrl,
      this.statisticsStaticUrl,
      this.statisticsVirtualUrl,
      this.statisticsMenuUrl,
      this.id,
      this.name,
      this.slotsImagesPath,
      this.mobileAppNeedToUpdate,
      this.historyTabs,
      this.sportBannerDisplaySeconds,
      this.customerServiceMessage,
      this.widgetHtml,
      this.widgetJavaScript,
      this.widgetId,
      this.lonestarImage,
      this.voucherImage,
      this.liveTrackerFilePath,
      this.orangeImage,
      this.orangeMessage,
      this.showPinCode,
      this.tipMeCustomerTypes,
      this.tipMeImage,
      this.tipMeOTPCharacters,
      this.accessToSignInAndRegister,
      this.androidImage,
      this.apkAndroidLink,
      this.apkAppleLink,
      this.appleImage});

  final int? tokenExpiresMinutes;
  final int? placeBetSeconds;
  final String? booongoAddress;
  final String? feedSr;
  final String? booongoSr;
  final String? jackpotSr;
  final String? imagesPath;
  final String? vfl;
  final String? vhc;
  final String? vflm;
  final String? vbl;
  final String? vto;
  final String? vdr;
  final String? epl;
  final String? memberChangeSR;
  final String? statisticsDomainUrl;
  final String? statisticsStaticUrl;
  final String? statisticsVirtualUrl;
  final String? statisticsMenuUrl;
  final int? id;
  final dynamic name;
  final String? slotsImagesPath;
  final bool? mobileAppNeedToUpdate;
  final List<HistoryTab>? historyTabs;
  final int? sportBannerDisplaySeconds;
  final String? customerServiceMessage;
  final String? widgetHtml;
  final String? widgetJavaScript;
  final String? widgetId;

  final String? lonestarImage;

  final String? voucherImage;

  final String? liveTrackerFilePath;
  final String? orangeImage;
  final String? orangeMessage;
  final int? showPinCode;
  final List<TipMeCustomerTypes>? tipMeCustomerTypes;
  final String? tipMeImage;
  final int? tipMeOTPCharacters;
  final int? accessToSignInAndRegister;
  final String? apkAndroidLink;
  final String? apkAppleLink;
  final String? androidImage;
  final String? appleImage;

  factory GeneralConfigurationDataModel.fromMap(Map<String, dynamic> data) =>
      GeneralConfigurationDataModel(
        memberChangeSR: data['memberChangeSR'] as String?,
        tokenExpiresMinutes: data['tokenExpiresMinutes'] as int?,
        placeBetSeconds: data['placeBetSeconds'] as int?,
        booongoAddress: data['booongoAddress'] as String?,
        feedSr: data['feedSR'] as String?,
        booongoSr: data['booongoSR'] as String?,
        jackpotSr: data['jackpotSR'] as String?,
        imagesPath: data['imagesPath'] as String?,
        vfl: data['vfl'] as String?,
        vhc: data['vhc'] as String?,
        vflm: data['vflm'] as String?,
        vbl: data['vbl'] as String?,
        vto: data['vto'] as String?,
        vdr: data['vdr'] as String?,
        epl: data['epl'] as String?,
        statisticsDomainUrl: data['statisticsDomainUrl'] as String?,
        statisticsStaticUrl: data['statisticsStaticUrl'] as String?,
        statisticsVirtualUrl: data['statisticsVirtualUrl'] as String?,
        statisticsMenuUrl: data['statisticsMenuUrl'] as String?,
        id: data['id'] as int?,
        name: data['name'] as dynamic,
        slotsImagesPath: data['slotsImagesPath'] as String,
        mobileAppNeedToUpdate: data['mobileAppNeedToUpdate'] as bool,
        historyTabs: (data['historyTabs'] as List<dynamic>?)
            ?.map((e) => HistoryTab.fromMap(e as Map<String, dynamic>))
            .toList(),
        sportBannerDisplaySeconds: data['sportBannerDisplaySeconds'] as int?,
        customerServiceMessage: data['customerServiceMessage'] as String?,
        widgetHtml: data['widgetHtml'] as String?,
        widgetJavaScript: data['widgetJavaScript'] as String?,
        widgetId: data['lmtWidgetId'] as String?,
        lonestarImage: data['lonestarImage'] as String?,
        voucherImage: data['voucherImage'] as String?,
        liveTrackerFilePath: data['liveTrackerFilePath'] as String?,
        orangeImage: data['orangeImage'] as String?,
        orangeMessage: data['orangeMessage'] as String?,
        showPinCode: data['showPinCode'] as int?,
        tipMeCustomerTypes: (data['tipMeCustomerTypes'] as List<dynamic>?)
            ?.map((e) => TipMeCustomerTypes.fromMap(e as Map<String, dynamic>))
            .toList(),
        tipMeImage: data['tipMeImage'] as String,
        tipMeOTPCharacters: data['tipMeOTPCharacters'] as int? ?? 4,
        accessToSignInAndRegister: data["accessToSignInAndRegister"] as int,
        apkAndroidLink: data['apkAndroidLink'] as String?,
        apkAppleLink: data['apkAppleLink'] as String?,
        androidImage: data['androidImage'] as String?,
        appleImage: data['appleImage'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'accessToSignInAndRegister': accessToSignInAndRegister,
        'memberChangeSR': memberChangeSR,
        'tokenExpiresMinutes': tokenExpiresMinutes,
        'placeBetSeconds': placeBetSeconds,
        'booongoAddress': booongoAddress,
        'feedSR': feedSr,
        'booongoSR': booongoSr,
        'jackpotSR': jackpotSr,
        'imagesPath': imagesPath,
        'vfl': vfl,
        'vhc': vhc,
        'vflm': vflm,
        'vbl': vbl,
        'vto': vto,
        'vdr': vdr,
        'epl': epl,
        'statisticsDomainUrl': statisticsDomainUrl,
        'statisticsStaticUrl': statisticsStaticUrl,
        'statisticsVirtualUrl': statisticsVirtualUrl,
        'statisticsMenuUrl': statisticsMenuUrl,
        'id': id,
        'name': name,
        "slotsImagesPath": slotsImagesPath,
        "mobileAppNeedToUpdate": mobileAppNeedToUpdate,
        'historyTabs': historyTabs,
        'sportBannerDisplaySeconds': sportBannerDisplaySeconds,
        'customerServiceMessage': customerServiceMessage,
        'widgetHtml': widgetHtml,
        'widgetJavaScript': widgetJavaScript,
        'LMTWidgetId': widgetId,
        'lonestarImage': lonestarImage,
        'voucherImage': voucherImage,
        'liveTrackerFilePath': liveTrackerFilePath,
        'orangeImage': orangeImage,
        'orangeMessage': orangeMessage,
        'showPinCode': showPinCode,
        'tipMeCustomerTypes': tipMeCustomerTypes,
        'tipMeImage': tipMeImage,
        'tipMeOTPCharacters': tipMeOTPCharacters,
        'apkAndroidLink': apkAndroidLink,
        'apkAppleLink': apkAppleLink,
        'androidImage': androidImage,
        'appleImage': appleImage,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GeneralConfigurationDataModel].
  factory GeneralConfigurationDataModel.fromJson(String data) {
    return GeneralConfigurationDataModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GeneralConfigurationDataModel] to a JSON string.
  String toJson() => json.encode(toMap());

  GeneralConfigurationDataModel copyWith({
    int? tokenExpiresMinutes,
    int? placeBetSeconds,
    String? booongoAddress,
    String? feedSr,
    String? booongoSr,
    String? jackpotSr,
    String? imagesPath,
    String? vfl,
    String? vhc,
    String? vflm,
    String? memberChangeSR,
    String? vbl,
    String? vto,
    String? vdr,
    String? epl,
    String? statisticsDomainUrl,
    String? statisticsStaticUrl,
    String? statisticsVirtualUrl,
    String? statisticsMenuUrl,
    int? id,
    dynamic name,
    String? slotsImagesPath,
    bool? mobileAppNeedToUpdate,
    List<HistoryTab>? historyTabs,
    int? sportBannerDisplaySeconds,
    String? customerServiceMessage,
    String? widgetHtml,
    String? widgetJavaScript,
    String? widgetId,
    String? lonestarImage,
    String? voucherImage,
    String? liveTrackerFilePath,
    String? orangeImage,
    String? orangeMessage,
    int? showPinCode,
    List<TipMeCustomerTypes>? tipMeCustomerTypes,
    String? tipMeImage,
    int? tipMeOTPCharacters,
    String? apkAndroidLink,
    String? apkAppleLink,
    String? androidImage,
    String? appleImage,
  }) {
    return GeneralConfigurationDataModel(
      memberChangeSR: memberChangeSR ?? this.memberChangeSR,
      tokenExpiresMinutes: tokenExpiresMinutes ?? this.tokenExpiresMinutes,
      placeBetSeconds: placeBetSeconds ?? this.placeBetSeconds,
      booongoAddress: booongoAddress ?? this.booongoAddress,
      feedSr: feedSr ?? this.feedSr,
      booongoSr: booongoSr ?? this.booongoSr,
      jackpotSr: jackpotSr ?? this.jackpotSr,
      imagesPath: imagesPath ?? this.imagesPath,
      vfl: vfl ?? this.vfl,
      vhc: vhc ?? this.vhc,
      vflm: vflm ?? this.vflm,
      vbl: vbl ?? this.vbl,
      vto: vto ?? this.vto,
      vdr: vdr ?? this.vdr,
      epl: epl ?? this.epl,
      statisticsDomainUrl: statisticsDomainUrl ?? this.statisticsDomainUrl,
      statisticsStaticUrl: statisticsStaticUrl ?? this.statisticsStaticUrl,
      statisticsVirtualUrl: statisticsVirtualUrl ?? this.statisticsVirtualUrl,
      statisticsMenuUrl: statisticsMenuUrl ?? this.statisticsMenuUrl,
      id: id ?? this.id,
      name: name ?? this.name,
      slotsImagesPath: slotsImagesPath ?? this.slotsImagesPath,
      historyTabs: historyTabs ?? this.historyTabs,
      sportBannerDisplaySeconds:
          sportBannerDisplaySeconds ?? this.sportBannerDisplaySeconds,
      customerServiceMessage:
          customerServiceMessage ?? this.customerServiceMessage,
      widgetHtml: widgetHtml ?? this.widgetHtml,
      widgetJavaScript: widgetJavaScript ?? this.widgetJavaScript,
      widgetId: widgetId ?? this.widgetId,
      lonestarImage: lonestarImage ?? this.lonestarImage,
      voucherImage: voucherImage ?? this.voucherImage,
      liveTrackerFilePath: liveTrackerFilePath ?? this.liveTrackerFilePath,
      orangeImage: orangeImage ?? this.orangeImage,
      orangeMessage: orangeMessage ?? this.orangeMessage,
      showPinCode: showPinCode ?? this.showPinCode,
      tipMeCustomerTypes: tipMeCustomerTypes ?? this.tipMeCustomerTypes,
      tipMeImage: tipMeImage ?? this.tipMeImage,
      tipMeOTPCharacters: tipMeOTPCharacters ?? this.tipMeOTPCharacters,
      accessToSignInAndRegister:
          accessToSignInAndRegister ?? this.accessToSignInAndRegister,
      apkAndroidLink: apkAndroidLink ?? this.apkAndroidLink,
      apkAppleLink: apkAppleLink ?? this.apkAppleLink,
      androidImage: androidImage ?? this.androidImage,
      appleImage: appleImage ?? this.appleImage,
    );
  }

  @override
  bool get stringify => true;
  String getProp(String propName) {
    return <String, dynamic>{
      'vflm': vflm,
      'epl': epl,
    }[propName];
  }

  @override
  List<Object?> get props {
    return [
      accessToSignInAndRegister,
      tokenExpiresMinutes,
      placeBetSeconds,
      booongoAddress,
      feedSr,
      booongoSr,
      jackpotSr,
      imagesPath,
      vfl,
      vhc,
      vflm,
      vbl,
      vto,
      vdr,
      epl,
      statisticsDomainUrl,
      statisticsStaticUrl,
      statisticsVirtualUrl,
      statisticsMenuUrl,
      id,
      name,
      slotsImagesPath,
      historyTabs,
      sportBannerDisplaySeconds,
      customerServiceMessage,
      widgetHtml,
      widgetJavaScript,
      widgetId,
      lonestarImage,
      voucherImage,
      liveTrackerFilePath,
      orangeImage,
      orangeMessage,
      showPinCode,
      tipMeCustomerTypes,
      tipMeImage,
      tipMeOTPCharacters,
      apkAndroidLink,
      apkAppleLink,
      androidImage,
      appleImage,
    ];
  }
}
