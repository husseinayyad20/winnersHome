import 'dart:async';
import 'dart:developer';

import 'package:winners/user_app/core/constants/assets.dart';
import 'package:winners/user_app/core/constants/extensions/widget_extensions.dart';
import 'package:winners/user_app/core/constants/strings.dart';
import 'package:winners/user_app/core/constants/theme.dart';
import 'package:winners/user_app/core/hex_color.dart';

import 'package:winners/user_app/data/models/bet_slip/bet_slip_item/bet_slip_item.dart';
import 'package:winners/user_app/data/models/get_top_bet_sport_event_response_model/sport_event.dart';
import 'package:winners/user_app/data/models/teams_icons/teams_icon.dart';

import 'package:winners/user_app/presentation/notifiers/bet_slip/bet_slip_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/general_configuration_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/home_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/match_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/theme_notifier.dart';
import 'package:winners/user_app/presentation/pages/app_bar/app_bar.dart';
import 'package:winners/user_app/presentation/pages/home/widgets/match.dart';
import 'package:winners/user_app/presentation/pages/home/widgets/web_view.dart';
import 'package:winners/user_app/presentation/resources/fonts_manager.dart';
import 'package:winners/user_app/presentation/resources/values_manager.dart';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'widgets/timer_widget.dart';

List<String> dummyTabs = [
  'Main',
  'Handicaps',
  'Other Markets',
  'Goals',
  'Correct Score',
];
late bool _isDarkTheme;
late ThemeNotifier _themeNotifier;

class HomeMatchDetailsPage extends StatefulWidget {
  late MatchNotifier matchNotifier;
  final bool? isVirtual;
  HomeMatchDetailsPage({Key? key, required this.matchNotifier, this.isVirtual})
      : super(key: key);

  @override
  State<HomeMatchDetailsPage> createState() => _HomeMatchDetailsPageState();
}

class _HomeMatchDetailsPageState extends State<HomeMatchDetailsPage> {
  late WebViewController _controller;
  @override
  void initState() {
    widget.matchNotifier.getAllBetTypes();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {});
    });
    widget.matchNotifier.addListener(() {
      log('initStateListening');
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);
    bool isDarkTheme = (themeNotifier.getTheme() == AppThemes().darkTheme);
    ThemeData theme =
        isDarkTheme ? AppThemes().darkTheme : AppThemes().lightTheme;

    final homeNotifier = Provider.of<HomeNotifier>(context, listen: true);
    final configNotifier = Provider.of<GeneralConfigurationNotifier>(context);
    SportEvent sportEvent = widget.isVirtual ?? false
        ? homeNotifier.selectedVirtualSportEvent!
        : homeNotifier.selectedSportEvent!;
    final _betSlipNotifier =
        Provider.of<BetSlipNotifier>(context, listen: true);
    final homeTeamIcons = (configNotifier.teamsIcons?.teamsIcons ?? []).where(
      (element) => element.teamId == sportEvent.eventHomeTeamId!,
    );
    final awayTeamIcons = (configNotifier.teamsIcons?.teamsIcons ?? []).where(
      (element) => element.teamId == sportEvent.eventAwayTeamId!,
    );
    String tournamentName = sportEvent.eventTournament!.tournamentDisplayName!;
    String country = widget.isVirtual ?? false
        ? homeNotifier.virtualCountry!
        : homeNotifier.country!;

    return Scaffold(
      backgroundColor:
          isDarkTheme ? theme.primaryColorLight : theme.primaryColor,
      appBar: _appBar(country, tournamentName, homeNotifier, sportEvent,
          configNotifier, theme, isDarkTheme),
      body: ListView(
        // physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          _matchHeader(context, sportEvent, homeTeamIcons, awayTeamIcons, theme,
              isDarkTheme),
          if (homeNotifier.isStaticIconSelected && sportEvent.isStarted!)
            _staticFrame(sportEvent, configNotifier),
          _filterMenu(context, theme, isDarkTheme),
          _group(context, homeNotifier, _betSlipNotifier, theme),
        ],
      ),
    );
  }

//33181713_1_-1
  Widget _group(BuildContext context, HomeNotifier homeNotifier,
      BetSlipNotifier betSlipNotifier, ThemeData theme) {
    return widget.matchNotifier.loading
        ? widget.matchNotifier.errorMessage.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.matchNotifier.errorMessage,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              )
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.matchNotifier.currentGroups.map((e) {
                  String key = e['key'];
                  var feedId = e['feed']['feedId'];
                  var sportId = e['sport']['sportId'];
                  var eventId = e['eventId'];

                  Map<String, dynamic>? eventOddFields = widget.matchNotifier
                          .mEventOddFields['${feedId}_${sportId}_$key'] ??
                      {};
                  if (eventOddFields!.isEmpty) {
                    eventOddFields = widget.matchNotifier.mEventOddFields[
                            '${feedId}_${sportId}_${eventId}_$key'] ??
                        {};
                  }

                  /// KEY:-> eventId$betTypeId$oddSpecialField
                  // widget.matchNotifier.eventOddFields.values.map((e) => log(e));
                  if (eventOddFields!.isEmpty) {
                    return const SizedBox();
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e['betType']['betTypeName'],
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.medium,
                            color: theme.dividerColor,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        _groupBets(context, eventOddFields, betSlipNotifier),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    );
                  }
                }).toList()),
          );
  }

  Widget _groupBets(BuildContext context, Map<String, dynamic> eventOddFields,
      BetSlipNotifier betSlipNotifier) {
    if (eventOddFields.values.length == 1) {
      return singleBox(context, eventOddFields, betSlipNotifier);
    } else if (eventOddFields.values.length == 2) {
      return boxOfTwo(context, eventOddFields, betSlipNotifier);
    } else if (eventOddFields.values.length == 3) {
      return boxOfThree(context, eventOddFields, betSlipNotifier);
    }
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);
    bool isDarkTheme = (themeNotifier.getTheme() == AppThemes().darkTheme);
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        // crossAxisCount: 3,
        childAspectRatio: 9 / 5, // width/height ratio
        mainAxisSpacing: 0, // between rows
        crossAxisSpacing: 8, // between columns
        crossAxisCount: 3,
      ),

      physics:
          const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
      shrinkWrap: true, // You won't see infinite size error
      itemBuilder: (BuildContext context, index) {
        var e = eventOddFields.values.toList()[index];
        final uniquieId =
            '${eventOddFields.values.toList()[index]['feed']['feedId']}_${e['sport']['sportId']}_${e['activeOddFieldId']}';
        final selected = betSlipNotifier.isBetExist(id: uniquieId);
        // int index = eventOddFields.values.toList().indexOf(e);
        bool isFirst = index == 0 || index % 3 == 0;
        bool isLast = index == 2 || index % 3 == 2;
        return GridOddBox(
          eventOddFields.values.toList()[index],
          widget.matchNotifier,
          isFirst
              ? BetBorderRadius.first
              : isLast
                  ? BetBorderRadius.last
                  : BetBorderRadius.mid,
        );
      },
      itemCount: eventOddFields.values.length,
    );
  }

  Row boxOfTwo(
    BuildContext context,
    Map<String, dynamic> eventOddFields,
    BetSlipNotifier betSlipNotifier,
  ) {
    var fields = Map.fromEntries(eventOddFields.entries.toList()
      ..sort(((a, b) =>
          a.value['oddFieldColumn'].compareTo(b.value['oddFieldColumn']))));
    final firstUniqueId = fields.values.first['feed']['feedId'].toString() +
        '_' +
        fields.values.first['sport']['sportId'].toString() +
        '_' +
        fields.values.first['activeOddFieldId'].toString();
    final firstAlreadyExist = betSlipNotifier.isBetExist(id: firstUniqueId);
    final lastUniqueId = fields.values.last['feed']['feedId'].toString() +
        '_' +
        fields.values.last['sport']['sportId'].toString() +
        '_' +
        fields.values.last['activeOddFieldId'].toString();
    final lastAlreadyExist = betSlipNotifier.isBetExist(id: lastUniqueId);
    return Row(
      children: [
        OddBox(
          fields.values.first,
          widget.matchNotifier,
          const BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        OddBox(
          fields.values.last,
          widget.matchNotifier,
          const BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
      ],
    );
  }

  Row boxOfThree(BuildContext context, Map<String, dynamic> eventOddFields,
      BetSlipNotifier betSlipNotifier) {
    /*
        var sortMapByValue = Map.fromEntries(
    fruits.entries.toList()
    ..sort((e1, e2) => e1.value.compareTo(e2.value)));
    
        */
    var fields = Map.fromEntries(eventOddFields.entries.toList()
      ..sort(((a, b) =>
          a.value['oddFieldColumn'].compareTo(b.value['oddFieldColumn']))));
    final firstUniqueId = fields.values.first['feed']['feedId'].toString() +
        '_' +
        fields.values.first['sport']['sportId'].toString() +
        '_' +
        fields.values.first['activeOddFieldId'].toString();
    final firstSelected = betSlipNotifier.isBetExist(id: firstUniqueId);
    final midUniqueId = fields.values.toList()[1]['feed']['feedId'].toString() +
        '_' +
        fields.values.toList()[1]['sport']['sportId'].toString() +
        '_' +
        fields.values.toList()[1]['activeOddFieldId'].toString();
    final lastUniqueId = fields.values.last['feed']['feedId'].toString() +
        '_' +
        fields.values.last['sport']['sportId'].toString() +
        '_' +
        fields.values.last['activeOddFieldId'].toString();
    final midSelected = betSlipNotifier.isBetExist(id: midUniqueId);
    final lastSelected = betSlipNotifier.isBetExist(id: lastUniqueId);

    return Row(
      children: [
        OddBox(
            fields.values.first,
            widget.matchNotifier,
            const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            )),
        const SizedBox(
          width: 8,
        ),
        OddBox(
          fields.values.toList()[1],
          widget.matchNotifier,
          BorderRadius.zero,
        ),
        const SizedBox(
          width: 8,
        ),
        OddBox(
            fields.values.last,
            widget.matchNotifier,
            const BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            )),
      ],
    );
  }

  Widget singleBox(BuildContext context, Map<String, dynamic> eventOddFields,
      BetSlipNotifier betSlipNotifier) {
    return OddBox(
      eventOddFields.values.first,
      widget.matchNotifier,
      BorderRadius.circular(8),
    );
  }

  Widget _filterMenu(BuildContext context, ThemeData theme, bool isDarkTheme) {
    return Container(
      height: 48,
      color: theme.primaryColorLight,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: widget.matchNotifier.getUniqueDrillDowns?.toSet().map((e) {
              bool isSelected = e == widget.matchNotifier.selectedGroup;
              return InkWell(
                onTap: () {
                  widget.matchNotifier.setSelectedGroup(e);
                  widget.matchNotifier.getGroups();
                  setState(() {});
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  child: Text(
                    e,
                    style: GoogleFonts.poppins(
                        fontSize: isSelected ? FontSize.s16 : FontSize.s14,
                        fontWeight: isSelected
                            ? FontWeightManager.semiBold
                            : FontWeightManager.medium,
                        color: isDarkTheme ? Colors.white : Colors.black),
                  ),
                ),
              ).center();
            }).toList() ??
            [],
      ),
    );
  }

  Widget _matchHeader(
    BuildContext context,
    SportEvent sportEvent,
    Iterable<TeamsIconModel> homeTeamIcons,
    Iterable<TeamsIconModel> awayTeamIcons,
    ThemeData theme,
    bool isDarkTheme,
  ) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.250,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: theme.primaryColorDark,
        borderRadius: BorderRadius.circular(
          8,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Text(
              widget.isVirtual ?? false
                  ? sportEvent.virtualSeasonName! +
                      " Day : " +
                      sportEvent.virtualDayName
                  : 'ID: ${sportEvent.eventBetLineNo}',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeightManager.semiBold,
                  fontSize: FontSize.s16,
                  color: isDarkTheme ? Colors.white : Colors.black),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            flex: 4,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    const CircleAvatar(
                                      radius: 36,
                                      backgroundColor: Color(0xFF657698),
                                    ),
                                    CircleAvatar(
                                      radius: 28,
                                      backgroundColor: theme.primaryColorDark,
                                      child: homeTeamIcons.isNotEmpty
                                          ? FancyShimmerImage(
                                              imageUrl: homeTeamIcons
                                                  .firstWhere((element) =>
                                                      element.teamId ==
                                                      sportEvent
                                                          .eventHomeTeamId!)
                                                  .bigPath!,
                                              height: 32,
                                              width: 32,
                                            )
                                          : CircleAvatar(
                                              backgroundColor: HexColor(
                                                  sportEvent
                                                          .eventHomeTeamColor ??
                                                      'AEB4BF'),
                                              child: Text(
                                                '${sportEvent.eventHomeTeamName!.split(' ').first.substring(0, 1)}${sportEvent.eventHomeTeamName!.split(' ').last.substring(0, 1)}',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontWeight:
                                                      FontWeightManager.bold,
                                                  fontSize: FontSize.s16,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                                !sportEvent.isStarted!
                                    ? Container(
                                        width: 16,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF657698),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          sportEvent.homeTeamRank.toString() ==
                                                  '0'
                                              ? '-'
                                              : sportEvent.homeTeamRank
                                                  .toString(),
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            fontSize: FontSize.s10,
                                            fontWeight: FontWeightManager.bold,
                                            color: theme.primaryColor,
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),

                                //
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Expanded(
                              child: Text(
                                // 'Hasan Hasan Hasan HASAN',
                                sportEvent.eventHomeTeamName.toString(),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    fontSize: FontSize.s12,
                                    fontWeight: FontWeightManager.semiBold,
                                    color: isDarkTheme
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sportEvent.isStarted!
                          ? Column(
                              children: [
                                Container(
                                  height: 32,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.red,
                                  ),
                                  child: Text(
                                    Strings.live.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeightManager.bold,
                                      fontSize: FontSize.s16,
                                    ),
                                  ).center(),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Builder(builder: (context) {
                                    final time = widget.matchNotifier.eventScore
                                            ?.eventTime ??
                                        widget.matchNotifier.sportEvent
                                            .eventScore?.eventTime;
                                    return TimeWidget(time ?? 0);
                                  }),
                                ),
                              ],
                            )
                          : const SizedBox(
                              height: 22,
                            ),
                      Text(
                        sportEvent.isStarted!
                            ? widget.matchNotifier.eventScore?.score
                                    .toString() ??
                                widget
                                    .matchNotifier.sportEvent.eventScore?.score
                                    .toString() ??
                                ""
                            : sportEvent.eventDateOfMatchFormated.toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeightManager.bold,
                          fontSize: sportEvent.isStarted!
                              ? FontSize.s20
                              : FontSize.s12,
                          color: theme.dividerColor,
                        ),
                      ).center(),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        '${sportEvent.eventScore?.gameScore ?? ''}',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeightManager.bold,
                          fontSize: FontSize.s18,
                        ),
                      ).center()
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    const CircleAvatar(
                                      radius: 36,
                                      backgroundColor: Color(0xFF657698),
                                    ),
                                    CircleAvatar(
                                      radius: 28,
                                      backgroundColor: theme.primaryColorDark,
                                      child: awayTeamIcons.isNotEmpty
                                          ? FancyShimmerImage(
                                              imageUrl: awayTeamIcons
                                                  .firstWhere((element) =>
                                                      element.teamId ==
                                                      sportEvent
                                                          .eventAwayTeamId!)
                                                  .bigPath!,
                                              height: 32,
                                              width: 32,
                                            )
                                          : CircleAvatar(
                                              backgroundColor: HexColor(
                                                  sportEvent
                                                          .eventAwayTeamColor ??
                                                      'AEB4BF'),
                                              child: Text(
                                                '${sportEvent.eventAwayTeamName!.split(' ').first.substring(0, 1)}${sportEvent.eventAwayTeamName!.split(' ').last.substring(0, 1)}',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontWeight:
                                                      FontWeightManager.bold,
                                                  fontSize: FontSize.s16,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                                !sportEvent.isStarted!
                                    ? Container(
                                        width: 16,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF657698),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          sportEvent.awayTeamRank.toString() ==
                                                  '0'
                                              ? '-'
                                              : sportEvent.awayTeamRank
                                                  .toString(),
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            fontSize: FontSize.s10,
                                            fontWeight: FontWeightManager.bold,
                                            color: theme.primaryColor,
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Expanded(
                              child: Text(
                                sportEvent.eventAwayTeamName!,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    fontSize: FontSize.s12,
                                    fontWeight: FontWeightManager.semiBold,
                                    color: isDarkTheme
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  WinnersAppBar _appBar(
    String country,
    String tournamentName,
    HomeNotifier homeNotifier,
    SportEvent sportEvent,
    GeneralConfigurationNotifier configNotifier,
    ThemeData theme,
    bool isDarkTheme,
  ) {
    return WinnersAppBar(
        title: widget.isVirtual ?? false
            ? '${homeNotifier.selectedVirtualSportEvent!.eventCategory!.categoryDisplayName} / $tournamentName'
            : '${homeNotifier.selectedSportEvent!.eventCategory!.categoryDisplayName} / $tournamentName',
        onBack: () {
          homeNotifier.clearSelectedEvent();
          homeNotifier.deselectMatchNotifier();
          // Navigator.pop(context);
        },
        action: Row(
          children: [
            const SizedBox(
              width: AppSize.s4,
            ),
            if (sportEvent.isStarted!)
              InkWell(
                onTap: () {
                  homeNotifier.setStaticIconSelected(
                    !homeNotifier.isStaticIconSelected,
                  );
                },
                child: SvgPicture.asset(
                  isDarkTheme
                      ? homeNotifier.isStaticIconSelected
                          ? Assets.statics
                          : Assets.staticsDark
                      : homeNotifier.isStaticIconSelected
                          ? Assets.statics
                          : Assets.staticsGray,
                  width: 40,
                  height: 25,
                ),
              ),
            const SizedBox(
              width: AppSize.s8,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebViewPage(
                            name:
                                '${sportEvent.eventCategory!.categoryDisplayName} / $tournamentName',
                            link:
                                "${configNotifier.config!.data!.statisticsStaticUrl!}/${sportEvent.eventId}")));
              },
              child: SvgPicture.asset(
                isDarkTheme ? Assets.exDark : Assets.ex,
                width: 40,
                height: 25,
              ),
            ),
            const SizedBox(
              width: AppSize.s8,
            ),
            Container(
                width: 40,
                height: 25,
                decoration: BoxDecoration(
                    color: isDarkTheme
                        ? theme.primaryColor
                        : theme.primaryColorLight,
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "+${sportEvent.eventBetTypesCount.toString()}",
                  style: TextStyle(
                      fontSize: 11,
                      color: isDarkTheme ? Colors.white : Colors.black),
                ).center()),
            const SizedBox(
              width: AppSize.s14,
            ),
          ],
        ));
  }

  Widget _staticFrame(
      SportEvent sportEvent, GeneralConfigurationNotifier configNotifier) {
    return SizedBox(
      height: 300,
      child: WebView(
        initialUrl:
            '${configNotifier.config!.data!.liveTrackerFilePath!}?matchId=${sportEvent.eventId}&widgetId=${configNotifier.config!.data!.widgetId!}',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;

          // _loadHtmlFromAssets(getHtml(
          //     configNotifier.config!.data!.widgetHtml!,
          //     configNotifier.config!.data!.widgetJavaScript!,
          //     configNotifier.config!.data!.widgetId!,
          //     sportEvent));
        },
      ),
    );
  }

  _loadHtmlFromAssets(String htmlText) async {
    _controller.loadHtmlString(htmlText);
  }

  String getHtml(
      String htmlContent, String js, String id, SportEvent sportEvent) {
    StringBuffer htmlSb = StringBuffer();

    htmlSb.write('<!DOCTYPE html>');
    htmlSb.write("<html>");
    htmlSb.write("<head>");

    htmlSb.write("</head>");
    htmlSb.write("<body>");
    htmlSb.write(htmlContent
        .replaceAll("ReplaceWidgetId", id)
        .replaceAll("ReplaceEventId", sportEvent.eventId.toString()));
    htmlSb.write(js
        .replaceAll("ReplaceWidgetId", id)
        .replaceAll("ReplaceEventId", sportEvent.eventId.toString()));
    // .replaceAll("ReplaceObject",
    //     {"matchId": sportEvent.eventId.toString()}.toString()));

    htmlSb.write("</body>");

    htmlSb.write("</html>");
    return htmlSb.toString();
  }
}

class OddBox extends StatefulWidget {
  final Map<String, dynamic> odd;
  final MatchNotifier matchNotifier;
  final BorderRadius borderRadius;
  @override
  const OddBox(
    this.odd,
    this.matchNotifier,
    this.borderRadius, {
    Key? key,
  }) : super(
          key: key,
        );
  @override
  _OddBoxState createState() => _OddBoxState();
}

class _OddBoxState extends State<OddBox> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    oldval = widget.odd["oddValue"].toString();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String? oldval = "";
  var hasNew = false;
  @override
  Widget build(BuildContext context) {
    HomeNotifier homeNotifier =
        Provider.of<HomeNotifier>(context, listen: false);
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    bool isDarkTheme = (themeNotifier.getTheme() == AppThemes().darkTheme);

    ThemeData theme =
        isDarkTheme ? AppThemes().darkTheme : AppThemes().lightTheme;
    final feedId = homeNotifier.virtualFeedId?.toString() ??
        homeNotifier.feedIndex.toString();
    final sportId = homeNotifier.selectedSport.sportId.toString();
    final betLine = widget.odd["activeOddFieldId"].toString();
    final uniqueId = feedId + '_' + sportId + '_' + betLine;
    final liveUniqueId = '5' '_' + sportId + '_' + betLine;

    final betslipNotifier = Provider.of<BetSlipNotifier>(context, listen: true);
    final alreadyExist = betslipNotifier.isBetExist(id: uniqueId) ||
        betslipNotifier.isBetExist(id: liveUniqueId);
    final oddMap = widget.odd;
    if (oddMap["oddActive"] == false) {}

    if (oddMap["oddValue"].toString() != oldval) {
      oldval = oddMap["oddValue"].toString();
      hasNew = true;
    } else {
      hasNew = false;
    }

    return (oddMap["EnableBet"] == false)
        ? Container(
            key: UniqueKey(),
            height: 50,
            width: 55,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: widget.borderRadius,
            ),
            child: const Icon(Icons.lock))
        : Expanded(
            child: GestureDetector(
              onTap: () {
                final homeTeam =
                    widget.matchNotifier.sportEvent.eventHomeTeamName;
                final awayTeam =
                    widget.matchNotifier.sportEvent.eventAwayTeamName;
                final homeTeamId =
                    widget.matchNotifier.sportEvent.eventHomeTeamId;
                final awayTeamId =
                    widget.matchNotifier.sportEvent.eventAwayTeamId;
                final betSlip = BetSlipItem.fromMap(widget.odd);
                betSlip.homeTeamName = homeTeam;
                betSlip.awayTeamName = awayTeam;
                betSlip.homeTeamId = homeTeamId;
                betSlip.awayTeamId = awayTeamId;

                betSlip.season =
                    widget.matchNotifier.sportEvent.virtualSeasonName;
                betSlip.day = widget.matchNotifier.sportEvent.virtualDayName;

                alreadyExist
                    ? betslipNotifier.removeBet(id: uniqueId)
                    : betslipNotifier.addBet(betSlipItem: betSlip);

                // homeNotifier.setVirtualFeedId(matchNotifier.feedId);
              },
              child: Stack(
                alignment: (oddMap["oddValueStatus"]) == 1
                    ? Alignment.topCenter
                    : Alignment.bottomCenter,
                fit: StackFit.loose,
                children: [
                  Container(
                    key: UniqueKey(),
                    height: 55,
                    decoration: BoxDecoration(
                      color:
                          alreadyExist ? theme.highlightColor : theme.cardColor,
                      borderRadius: widget.borderRadius,
                    ),
                    child: Stack(
                      alignment: (oddMap["oddValueStatus"]) == 1
                          ? Alignment.topCenter
                          : Alignment.bottomCenter,
                      fit: StackFit.loose,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              child: Text(
                                widget.odd["oddField"],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.titleSmall?.copyWith(
                                    color: Colors.grey, fontSize: 10),
                              ),
                            ),
                            Center(
                              child: (widget.matchNotifier.sportEvent
                                              .virtualSeasonName ??
                                          '')
                                      .isNotEmpty
                                  ? oddMap['eventEnableBet']
                                      ? Text(
                                          oddMap["oddValue"].toString(),
                                          style:
                                              GoogleFonts.poppins(fontSize: 14)
                                                  .copyWith(
                                                      color: alreadyExist
                                                          ? Colors.white
                                                          : theme.hintColor),
                                        )
                                      : const Icon(Icons.lock)
                                  : oddMap['enableBet']
                                      ? Text(
                                          oddMap["oddValue"].toString(),
                                          style:
                                              GoogleFonts.poppins(fontSize: 14)
                                                  .copyWith(
                                                      color: alreadyExist
                                                          ? Colors.white
                                                          : theme.hintColor),
                                        )
                                      : const Icon(Icons.lock),
                            ),
                          ],
                        ),
                        if (hasNew)
                          BlinkingLine(getColor(oddMap["oddValueStatus"]))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Color getColor(int? isup) {
    if (isup == 0) {
      return Colors.transparent;
    } else {
      log('Either up or down');
      return (isup == 1 ? Colors.green : Colors.red);
    }
  }
}

class GridOddBox extends StatefulWidget {
  final Map<String, dynamic> odd;
  final MatchNotifier matchNotifier;
  final BetBorderRadius? betBorderRadius;

  @override
  const GridOddBox(
    this.odd,
    this.matchNotifier,
    this.betBorderRadius, {
    Key? key,
  }) : super(key: key);
  @override
  _GridOddBoxState createState() => _GridOddBoxState();
}

class _GridOddBoxState extends State<GridOddBox>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    oldval = widget.odd["oddValue"].toString();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String? oldval = "";
  var hasNew = false;
  @override
  Widget build(BuildContext context) {
    HomeNotifier homeNotifier =
        Provider.of<HomeNotifier>(context, listen: false);
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    bool isDarkTheme = (themeNotifier.getTheme() == AppThemes().darkTheme);

    ThemeData theme =
        isDarkTheme ? AppThemes().darkTheme : AppThemes().lightTheme;
    final feedId = homeNotifier.virtualFeedId?.toString() ??
        homeNotifier.feedIndex.toString();
    final sportId = homeNotifier.selectedSport.sportId.toString();
    final betLine = widget.odd["activeOddFieldId"].toString();
    final uniqueId = feedId + '_' + sportId + '_' + betLine;
    final liveUniqueId = '5' '_' + sportId + '_' + betLine;

    final betslipNotifier = Provider.of<BetSlipNotifier>(context, listen: true);
    final alreadyExist = betslipNotifier.isBetExist(id: uniqueId) ||
        betslipNotifier.isBetExist(id: liveUniqueId);
    final oddMap = widget.odd;
    if (oddMap["oddActive"] == false) {}

    if (oddMap["oddValue"].toString() != oldval) {
      oldval = oddMap["oddValue"].toString();
      hasNew = true;
    } else {
      hasNew = false;
    }

    return (oddMap["EnableBet"] == false)
        ? Container(
            key: UniqueKey(),
            // height: 50,
            // width: 55,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: widget.betBorderRadius == BetBorderRadius.first
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    )
                  : widget.betBorderRadius == BetBorderRadius.last
                      ? const BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        )
                      : const BorderRadius.only(),
            ),
            child: const Icon(
              Icons.lock,
            ),
          )
        : GestureDetector(
            onTap: () {
              final homeTeam =
                  widget.matchNotifier.sportEvent.eventHomeTeamName;
              final awayTeam =
                  widget.matchNotifier.sportEvent.eventAwayTeamName;
              final homeTeamId =
                  widget.matchNotifier.sportEvent.eventHomeTeamId;
              final awayTeamId =
                  widget.matchNotifier.sportEvent.eventAwayTeamId;
              final betSlip = BetSlipItem.fromMap(widget.odd);
              betSlip.homeTeamName = homeTeam;
              betSlip.awayTeamName = awayTeam;
              betSlip.homeTeamId = homeTeamId;
              betSlip.awayTeamId = awayTeamId;

              betSlip.season =
                  widget.matchNotifier.sportEvent.virtualSeasonName;
              betSlip.day = widget.matchNotifier.sportEvent.virtualDayName;

              alreadyExist
                  ? betslipNotifier.removeBet(id: uniqueId)
                  : betslipNotifier.addBet(betSlipItem: betSlip);

              // homeNotifier.setVirtualFeedId(matchNotifier.feedId);
            },
            child: Stack(
              alignment: (oddMap["oddValueStatus"]) == 1
                  ? Alignment.topCenter
                  : Alignment.bottomCenter,
              fit: StackFit.loose,
              children: [
                Container(
                  key: UniqueKey(),
                  height: 55,
                  // width: 100,
                  decoration: BoxDecoration(
                    color:
                        alreadyExist ? theme.highlightColor : theme.cardColor,
                    borderRadius:
                        widget.betBorderRadius == BetBorderRadius.first
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              )
                            : widget.betBorderRadius == BetBorderRadius.last
                                ? const BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  )
                                : const BorderRadius.only(),
                  ),
                  child: Stack(
                    alignment: (oddMap["oddValueStatus"]) == 1
                        ? Alignment.topCenter
                        : Alignment.bottomCenter,
                    fit: StackFit.loose,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              widget.odd["oddField"],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleSmall
                                  ?.copyWith(color: Colors.grey, fontSize: 10),
                            ),
                          ),
                          Center(
                            child: (widget.matchNotifier.sportEvent
                                            .virtualSeasonName ??
                                        '')
                                    .isNotEmpty
                                ? oddMap['eventEnableBet']
                                    ? Text(
                                        oddMap["oddValue"].toString(),
                                        style: GoogleFonts.poppins(fontSize: 14)
                                            .copyWith(
                                                color: alreadyExist
                                                    ? Colors.white
                                                    : theme.hintColor),
                                      )
                                    : const Icon(Icons.lock)
                                : oddMap['enableBet']
                                    ? Text(
                                        oddMap["oddValue"].toString(),
                                        style: GoogleFonts.poppins(fontSize: 14)
                                            .copyWith(
                                                color: alreadyExist
                                                    ? Colors.white
                                                    : theme.hintColor),
                                      )
                                    : const Icon(Icons.lock),
                          ),
                        ],
                      ),
                      if (oddMap['feedChangeStatus'] == 0)
                        BlinkingLine(getColor(oddMap["oddValueStatus"]))
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Color getColor(int? isup) {
    if (isup == 0) {
      return Colors.transparent;
    } else {
      log('Either up or down');
      return (isup == 1 ? Colors.green : Colors.red);
    }
  }
}

enum BetBorderRadius {
  first,
  mid,
  last,
}
