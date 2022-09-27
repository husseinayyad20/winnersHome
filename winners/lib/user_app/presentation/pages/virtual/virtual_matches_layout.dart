import 'dart:convert';
import 'package:archive/archive.dart';
import 'package:winners/user_app/core/constants/theme.dart';
import 'package:winners/user_app/presentation/notifiers/general_configuration_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/home_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/match_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/selected_league_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/theme_notifier.dart';
import 'package:winners/user_app/presentation/pages/home/widgets/match.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

class VirtualDailyLayout extends StatefulWidget {
  const VirtualDailyLayout({Key? key}) : super(key: key);

  @override
  State<VirtualDailyLayout> createState() {
    return _VirtualDailyLayoutState();
  }
}

class _VirtualDailyLayoutState extends State<VirtualDailyLayout> {
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
   

    // final tournamentInDay =
    //     homeNotifier.topBetSportEvent?.data?.tournamentsByDayList ?? [];
    final tournamentInDay =
        homeNotifier.virtualBetSportEventEntity?.data?.sportEvents;
    tournamentInDay?.sort(
        ((a, b) => a.searchDisplayOrder!.compareTo(b.searchDisplayOrder!)));
    if (tournamentInDay?.isEmpty ?? false) {
      if (homeNotifier.leaguesTabs.length > 1) {
        Future.delayed(const Duration(milliseconds: 500), () {
          final configNotifier =
              Provider.of<GeneralConfigurationNotifier>(context, listen: false);
          homeNotifier.setLeague(homeNotifier.leaguesTabs[1].tab!);
          configNotifier.setLeaguesTab(homeNotifier.leaguesTabs[1].tab!);
          homeNotifier.invokeWithDate();
        });
      }

      return Container();
    }

     final themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);
    bool isDarkTheme = (themeNotifier.getTheme() == AppThemes().darkTheme);
    ThemeData theme=isDarkTheme?AppThemes().darkTheme:AppThemes().lightTheme;
    // return SizedBox();
    return ChangeNotifierProvider(
      create: (_) {
        return SelectedLeagueNotifier(homeNotifier);
      },
      child: Container(
        color: isDarkTheme
            ? theme.primaryColorLight
            : theme.primaryColor,
        child:
            homeNotifier.virtualBetSportEventEntity?.data?.sportEvents != null
                ? ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxHeight: 300, minHeight: 60),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ...homeNotifier
                              .virtualBetSportEventEntity!.data!.sportEvents!
                              .map((sportEvent) {
                            return ChangeNotifierProvider(
                              lazy: true,
                              create: (_) => MatchNotifier(
                                homeNotifier.hubConnection,
                                sportEvent,
                                homeNotifier.virtualEventOddFields[
                                    '${sportEvent.feed!.feedId!}_${sportEvent.sport!.sportId}_${sportEvent.eventId}_1_-1'],
                                sportEvent.eventId,
                                sportEvent.feed!.feedId!,
                                sportEvent.sport!.sportId!,
                                homeNotifier.selectedBetType?.betTypeId ?? 1,
                                false,
                                homeNotifier.virtualEventOddFields,
                                specialBetTypeId: -1,
                              ),
                              child: Consumer<MatchNotifier>(
                                builder: (context, value, child) {
                                  return value.homeEventOddFields.isEmpty
                                      ? const SizedBox()
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: HomePageMatchWidget(
                                            value.homeSportEvent,
                                            value.homeEventOddFields,
                                            homeNotifier.selectedVirtualBetType
                                                    ?.betTypeId ??
                                                1,
                                            value.homeEventOdds,
                                            // Is Virtual flag
                                            true,
                                          ),
                                        );
                                },
                              ),
                            );
                          }).toList(),
                          homeNotifier.virtualBetSportEventEntity!.data!
                                  .sportEvents!.isEmpty
                              ? Container(
                                  color: theme.primaryColorDark,
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  )
                // For match days with no events
                : const SizedBox(),
      ),
    );
  }
}
