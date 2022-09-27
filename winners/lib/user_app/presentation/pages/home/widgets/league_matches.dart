import 'dart:convert';

import 'package:winners/user_app/core/constants/theme.dart';
import 'package:winners/user_app/data/models/get_top_bet_sport_event_response_model/sport_event.dart';
import 'package:winners/user_app/presentation/notifiers/home_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/match_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'daily_layout.dart';
import 'match.dart';

class LeagueMatches extends StatefulWidget {
  final int tournamentId;
  final int selectedDate;
  final int feed;
  final int sport;
  final bool? isExpanded;
  const LeagueMatches(
    this.tournamentId,
    this.selectedDate,
    this.feed,
    this.sport, {
    Key? key,
    this.isExpanded,
  }) : super(key: key);

  @override
  _LeagueMatchesState createState() => _LeagueMatchesState();
}

class _LeagueMatchesState extends State<LeagueMatches> {
  Map<String, dynamic> sportEvents = {};
  Map<String, dynamic> eventOdds = {};
  Map<String, dynamic> eventOddFields = {};
  DateFormat formattedDate = DateFormat('dd-MM-yyyy');

  int tournamentId = 0;

  late HomeNotifier homeNotifier;
  onEvents(List<Object>? arguments) {
    if (tournamentId == 0) {
      return;
    }
    if (!mounted) {
      return;
    }

    String response = decode(arguments!.first.toString());
    //  log(json.decode(json.encode(response)));
    Map<String, dynamic> encodedResponse = json.decode(response);
    final newsportEvents =
        encodedResponse['data']['sportEvents'] as Map<String, dynamic>;
    if (newsportEvents.values.isNotEmpty &&
        newsportEvents.values.first != null) {
      final event = SportEvent.fromMap(
          newsportEvents.values.first as Map<String, dynamic>);
      final eventDate =
          formattedDate.format(event.eventDateOfMatch ?? DateTime.now());
      final selectedDate = formattedDate
          .format(DateTime.now().add(Duration(days: widget.selectedDate)));
      if (eventDate != selectedDate) {
        return;
      }
      if (event.eventTournament?.tournamentUId != widget.tournamentId) {
        return;
      }
    } else {
      return;
    }

    setState(() {
      sportEvents =
          encodedResponse['data']['sportEvents'] as Map<String, dynamic>;
      eventOdds = encodedResponse['data']['eventOdds'] as Map<String, dynamic>;
      eventOddFields =
          encodedResponse['data']['eventOddFields'] as Map<String, dynamic>;
    });
  }

  onMatches() {
    if (tournamentId == 0) {
      return;
    }
    homeNotifier.hubConnection
        .on('OnSportEventsByTournamentDayFromCache', onEvents);
  }

  getMatches() {
    final day = widget.selectedDate;
    debugPrint(
        "get matches for $tournamentId ${widget.feed} ${widget.sport} $day");
    Map<String, dynamic> map = {
      'Data': {
        'Feed': {
          'FeedId': widget.feed,
        },
        'Sport': {
          'SportId': widget.sport,
        },
        'Day': day,
        'TournamentUId': widget.tournamentId,
        'BetTypeId': homeNotifier.selectedBetType?.betTypeId ?? 1,
        'IsLastMin': false,
      },
    };
    if (homeNotifier.league!.liveTopLeaguesTabId == 1 && widget.feed == 6) {
      map['Data'].addEntries([const MapEntry('IsTopMatch', true)]);
    }
    homeNotifier.hubConnection.invoke(
      'GetSportEventsByTournamentDayFromCache',
      args: [
        map,
      ],
    ).then((value) {
      debugPrint('GetSportEventsByTournamentDayFromCache ${value.toString()}');
    }).catchError((onError) {
      debugPrint(
          'GetSportEventsByTournamentDayFromCache error ${onError.toString()}');
    });
  }

  @override
  void initState() {
    homeNotifier = Provider.of<HomeNotifier>(context, listen: false);

    tournamentId = widget.tournamentId;
    debugPrint("###### init league matches #######");
    super.initState();
  }

  @override
  void dispose() {
    debugPrint("###### dispose league matches #######");
    homeNotifier.hubConnection
        .off('OnSportEventsByTournamentDayFromCache', method: onEvents);
    sportEvents = {};
    eventOddFields = {};
    eventOdds = {};
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    debugPrint('league_matches didChangeDependencies');
    if (widget.isExpanded!) {
      if (mounted) {
        setState(() {
          onMatches();
          getMatches();
        });
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    bool isDarkTheme = (themeNotifier.getTheme() == AppThemes().darkTheme);
    
    ThemeData theme=isDarkTheme?AppThemes().darkTheme:AppThemes().lightTheme;
    final betType = homeNotifier.selectedBetType?.betTypeId ?? 1;
    final specialField =
        homeNotifier.selectedBetType?.defaultSpecialField ?? "-1";
    return Container(
      color: isDarkTheme
          ? theme.primaryColorLight
          : theme.primaryColor,
      child: Column(children: [
        ...sportEvents.values.map((e) {
          final sportEvent = SportEvent.fromMap(e);
          return (widget.isExpanded ?? false)
              ? ChangeNotifierProvider(
                  lazy: false,
                  create: (_) => MatchNotifier(
                      homeNotifier.hubConnection,
                      sportEvent,
                      eventOddFields,
                      sportEvent.eventId,
                      sportEvent.feed!.feedId!,
                      sportEvent.sport!.sportId!,
                      homeNotifier.selectedBetType?.betTypeId ?? 1,
                      false,
                      eventOdds,
                      homeNotifier: homeNotifier,
                      specialBetTypeId:
                          homeNotifier.selectedBetType?.oddSpecialField ??
                              '-1'),
                  child: Consumer<MatchNotifier>(
                    builder: (context, value, child) {
                      value.homeEventOddFields = eventOddFields[
                              '${sportEvent.feed!.feedId!}_${sportEvent.sport!.sportId}_${sportEvent.eventId}_${betType}_$specialField'] ??
                          {};
                      value.homeEventOdds = eventOddFields[
                              '${sportEvent.feed!.feedId!}_${sportEvent.sport!.sportId}_${sportEvent.eventId}_${betType}_$specialField'] ??
                          {};
                      return
                          //value.homeEventOddFields.isEmpty
                          // ? const SizedBox()
                          // :
                          HomePageMatchWidget(
                        value.homeSportEvent,
                        value.homeEventOddFields,
                        homeNotifier.selectedBetType?.betTypeId ?? 1,
                        value.homeEventOdds,
                        false,
                      );
                    },
                  ),
                )
              : const SizedBox();
        }).toList(),
        sportEvents.values.isEmpty
            ? Container(
                color: theme.primaryColorDark,
                child: const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                  ),
                ),
              )
            : const SizedBox(),
      ]),
    );
  }
}
