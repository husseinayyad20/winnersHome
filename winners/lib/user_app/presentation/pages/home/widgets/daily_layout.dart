import 'dart:convert';
import 'dart:math';
import 'package:archive/archive.dart';
import 'package:winners/user_app/core/constants/theme.dart';
import 'package:winners/user_app/data/models/get_top_bet_sport_event_response_model/tournament_by_day/sport_top_league.dart';
import 'package:winners/user_app/data/models/get_top_bet_sport_event_response_model/tournament_by_day/tournament_by_day.dart';
import 'package:winners/user_app/presentation/notifiers/home_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/selected_league_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/theme_notifier.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../notifiers/general_configuration_notifier.dart';
import 'league_matches.dart';

String decode(String data) {
  final str = base64.decode(data);
  final deflated = Inflate(str);
  final decodedString = String.fromCharCodes(deflated.getBytes());
  return decodedString;
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  DateTime headerValue;
  bool isExpanded;
}

class DailyLayout extends StatefulWidget {
  const DailyLayout({Key? key}) : super(key: key);

  @override
  State<DailyLayout> createState() {
    return _DailyLayoutState();
  }
}

class _DailyLayoutState extends State<DailyLayout> {
  bool firstRun = true;
  List<int> expandedDates = [];
  @override
  Widget build(BuildContext context) {
    final homeNotifier = Provider.of<HomeNotifier>(context, listen: true);
    return Container(
      child: _buildPanel(context, homeNotifier),
    );
  }

  Widget _buildPanel(BuildContext context, HomeNotifier homeNotifier) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);
    bool isDarkTheme = (themeNotifier.getTheme() == AppThemes().darkTheme);
    ThemeData theme =
        isDarkTheme ? AppThemes().darkTheme : AppThemes().lightTheme;
    final tournamentInDay =
        homeNotifier.topBetSportEvent?.data?.tournamentsByDayList ?? [];
    if (homeNotifier.topBetSportEvent?.data?.tournamentsByDayList != null &&
        tournamentInDay.isEmpty) {
      if (homeNotifier.leaguesTabs.length > 1) {
        Future.delayed(const Duration(milliseconds: 500), () {
          final configNotifier =
              Provider.of<GeneralConfigurationNotifier>(context, listen: false);
          final index =
              homeNotifier.leaguesTabs.indexWhere((element) => element.id == 4);
          final tabIndex = max(index, 1);
          homeNotifier.setLeague(homeNotifier.leaguesTabs[tabIndex].tab!);
          configNotifier.setLeaguesTab(homeNotifier.leaguesTabs[tabIndex].tab!);
          homeNotifier.invokeWithDate();
        });
      }
      return Container();
    }

    return ChangeNotifierProvider(
      create: (_) {
        return SelectedLeagueNotifier(homeNotifier);
      },
      child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          if (!isExpanded) {
            homeNotifier.selectedDay = index;
          }
          final openindex = tournamentInDay[index].day ?? 0;
          setState(() {
            if (expandedDates.isEmpty && firstRun) {
              expandedDates.add(openindex);
            }
            if (expandedDates.contains(openindex)) {
              expandedDates.remove(openindex);
            } else {
              expandedDates.add(openindex);
            }
            firstRun = false;
          });
        },
        children: tournamentInDay.map<ExpansionPanel>((TournamentByDay item) {
          var format = DateFormat('EEEE, d MMMM');
          var rawDate = item.day;
          final datestr = DateTime.now().add(Duration(days: rawDate ?? 0));

          var date = format.format(datestr);
          if (rawDate == 0) {
            var split = date.split(',');
            split.first = 'Today';
            date = split.toString().replaceAll('[', '').replaceAll(']', '');
          } else if (rawDate == 1) {
            var split = date.split(',');
            split.first = 'Tomorrow';
            date = split.toString().replaceAll('[', '').replaceAll(']', '');
          }

          final tournamentInDayList = item.sportTournaments ?? [];
          return ExpansionPanel(
            backgroundColor:
                isDarkTheme ? theme.primaryColorLight : theme.primaryColor,
            canTapOnHeader: true,

            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                dense: true,
                title: Text(
                  date,
                  style: GoogleFonts.oswald(
                      fontSize: 18,
                      color: isDarkTheme ? Colors.white : Colors.black),
                ),
                tileColor: isDarkTheme
                    ? theme.primaryColorLight
                    : theme.primaryColor, //themeData.primaryColor,
              );
            },
            body: tournamentInDayList.isEmpty
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LeagueLayout(item),
                  ),
            isExpanded: expandedDates.isEmpty && firstRun
                ? tournamentInDay.first == item
                    ? true
                    : false
                : expandedDates.contains(item.day),
            // isExpanded: expandedDates.isEmpty
            // ? tournamentInDay.first == item
            // ? true
            // : false
            // : expandedDates.contains(item.day),
          );
        }).toList(),
      ),
    );
  }
}

List<int> opened = [];

class LeagueLayout extends StatefulWidget {
  final TournamentByDay tournaments;
  const LeagueLayout(this.tournaments, {Key? key}) : super(key: key);

  @override
  State<LeagueLayout> createState() {
    return _LeagueLayoutState();
  }
}

class _LeagueLayoutState extends State<LeagueLayout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    debugPrint("dispose league layout ${widget.tournaments.day}");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _builLeaguedPanel(
        context,
        widget.tournaments,
      ),
    );
  }

  bool once = true;
  Widget _builLeaguedPanel(BuildContext context, TournamentByDay tournament) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);

    bool isDarkTheme = (themeNotifier.getTheme() == AppThemes().darkTheme);

    ThemeData theme =
        isDarkTheme ? AppThemes().darkTheme : AppThemes().lightTheme;

    final homenoti = Provider.of<HomeNotifier>(context, listen: false);
    final value = Provider.of<SelectedLeagueNotifier>(context, listen: true);
    final configNotifier =
        Provider.of<GeneralConfigurationNotifier>(context, listen: false);
    if (tournament.isExpanded && once) {
      value.initWithTournament(tournament.sportTournaments!.first);
      tournament.sportTournaments?.first.isExpanded = true;
      value.joinGroup();
      opened.add(tournament.sportTournaments!.first.tournamentUId!);
    }
    return ExpansionPanelList(
      dividerColor: Colors.transparent,
      
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          tournament.isExpanded = !isExpanded;
          if (!isExpanded) {
            value.initWithTournament(tournament.sportTournaments![index]);
            tournament.sportTournaments?[index].isExpanded = true;
            value.joinGroup();
            opened.add(tournament.sportTournaments![index].tournamentUId!);
            once = false;
          } else {
            tournament.sportTournaments?[index].isExpanded = false;
            value.partGroup();
            opened.remove(tournament.sportTournaments![index].tournamentUId!);
            once = false;
          }
        });
      },
      children: tournament.sportTournaments!
          .map<ExpansionPanel>((SportTopLeague item) {
        return ExpansionPanel(
          canTapOnHeader: true,

          backgroundColor: isDarkTheme
              ? theme.bottomNavigationBarTheme.backgroundColor
              : theme.dividerColor,

          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              dense: true,
              title: Row(
                children: [
                  const Icon(
                    Icons.star,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  configNotifier.getContriesFlags != null
                      ? FancyShimmerImage(
                          imageUrl: configNotifier
                              .getContriesFlags!.data!.countryFlagImages!
                              .firstWhere(
                                  (element) =>
                                      element.sportCategoryId ==
                                      item.sportCategory?.sportCategoryId,
                                  orElse: () => configNotifier.getContriesFlags!
                                      .data!.countryFlagImages!
                                      .firstWhere((element) =>
                                          element.countryName ==
                                          'International'))
                              .countryFlagImagesName!,
                          width: 25,
                          height: 18,
                        )
                      : const SizedBox(),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      (item.sportCategory?.categoryDisplayName ?? '') +
                          '/' +
                          item.tournamentDisplayName.toString(),
                      style: GoogleFonts.oswald(
                          fontSize: 18,
                          color: isDarkTheme ? Colors.white : Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              tileColor: isDarkTheme
                  ? theme.bottomNavigationBarTheme.backgroundColor
                  : theme.dividerColor,
            );
          },
          isExpanded: item.isExpanded ?? false,

          //this item should hold the data
          body:
              // statful widget - hold all data related to this league
              opened.contains(item.tournamentUId)
                  ? LeagueMatches(
                      item.tournamentUId!,
                      widget.tournaments.day ?? 0,
                      homenoti.feedIndex,
                      homenoti.selectedSport.sportId!,
                      isExpanded: true,
                    )
                  : Container(),
        );
      }).toList(),
    );
  }
}
