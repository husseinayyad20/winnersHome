import 'package:winners/user_app/core/constants/theme.dart';
import 'package:winners/user_app/data/models/get_top_bet_sport_event_response_model/category_by_date/category_by_date.dart';
import 'package:winners/user_app/presentation/notifiers/general_configuration_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/home_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/selected_league_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/theme_notifier.dart';
import 'package:winners/user_app/presentation/pages/home/widgets/league_matches.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'all_matches.dart';

class LiveGames extends StatefulWidget {
  const LiveGames({Key? key}) : super(key: key);

  @override
  State<LiveGames> createState() => _LiveGamesState();
}

class _LiveGamesState extends State<LiveGames> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);
    bool isDarkTheme = (themeNotifier.getTheme() == AppThemes().darkTheme);
 
    ThemeData theme=isDarkTheme?AppThemes().darkTheme:AppThemes().lightTheme;
    var format = DateFormat('E');
    var rawDate = DateTime.now();
    var date = format.format(rawDate);
    var split = date.split(',');
    split.first = 'Today';
    date = split.toString().replaceAll('[', '').replaceAll(']', '');
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        ExpansionTile(
          trailing: const SizedBox(),
          initiallyExpanded: true,
          backgroundColor: isDarkTheme
              ? theme.primaryColor
              : theme.dividerColor.withOpacity(0.2),
          title: IgnorePointer(
            ignoring: true,
            child: ListTile(
                title: Text(
                  // DateTime.now().toString().split(" ")[0],
                  date,
                  style: GoogleFonts.oswald(
                      fontSize: 18,
                      color: theme.toggleableActiveColor),
                ),
                tileColor: theme.primaryColor.withOpacity(0.2)),
          ),
          children: [
            _matchDetails(context),
          ],
        ),
        const SizedBox(
          height: 150,
        )
      ],
    );
  }

  Widget _matchDetails(BuildContext context) {
    final homeNotifier = Provider.of<HomeNotifier>(context, listen: true);
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);
    bool isDarkTheme = (themeNotifier.getTheme() == AppThemes().darkTheme);
 
    ThemeData theme=isDarkTheme?AppThemes().darkTheme:AppThemes().lightTheme;
    final categories =
        homeNotifier.topBetSportEvent?.data?.categoriesByDateList ?? [];
    final configNotifier =
        Provider.of<GeneralConfigurationNotifier>(context, listen: false);

    return homeNotifier.noMatchesErrorMessage!.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(homeNotifier.noMatchesErrorMessage!),
          )
        : ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              for (var element in categories) {
                element.isExpanded = false;
              }
              setState(() {
                categories[index].isExpanded = !isExpanded;
              });
            },
            children: categories
                .map(
                  (e) => ExpansionPanel(
                    backgroundColor: isDarkTheme
                        ? theme.primaryColorLight
                        : theme.primaryColor,
                    canTapOnHeader: true,
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ChangeNotifierProvider(
                          create: (_) => SelectedLeagueNotifier(homeNotifier),
                          child: LeagueLayout(
                            e,
                            DateTime.now().add(const Duration(days: 1)),
                            isLive: true,
                          ),
                        ),
                      ],
                    ),
                    // body: LeagueMatches(
                    //   e.categoryUId!,
                    //   DateTime.now(),
                    //   6,
                    //   homeNotifier.selectedSport.sportId!,
                    //   isExpanded: !e.isExpanded,
                    // ),
                    // body: Text("${categories.first.categoryName}??name"),
                    isExpanded: e.isExpanded,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Row(
                          children: [
                            const Icon(Icons.star),
                            const SizedBox(
                              width: 8,
                            ),
                            configNotifier.getContriesFlags != null
                                ? FancyShimmerImage(
                                    imageUrl: configNotifier.getContriesFlags!
                                        .data!.countryFlagImages!
                                        .firstWhere(
                                            (element) =>
                                                element.countryName ==
                                                e.categoryName,
                                            orElse: () => configNotifier
                                                .getContriesFlags!
                                                .data!
                                                .countryFlagImages!
                                                .first)
                                        .countryFlagImagesName!,
                                    //     .firstWhere((element) {
                                    //  debugPrint(
                                    //       '${element.countryName} -- ${e.categoryName}');
                                    //   return element.countryName == e.categoryName;
                                    // })
                                    width: 22,
                                    height: 15,
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                '${e.categoryName!} / ${e.sportTournaments!.first.tournamentDisplayName!}',
                                style: GoogleFonts.oswald(
                                  fontSize: 18,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        tileColor: isDarkTheme
                            ? theme.primaryColorLight
                            : theme.primaryColor,
                      );
                    },
                  ),
                )
                .toList(),
          );
  }
}

class LiveMatchLayout extends StatefulWidget {
  final CategoryByDate tournaments;
  final DateTime tournomantDay;
  const LiveMatchLayout(this.tournaments, this.tournomantDay, {Key? key})
      : super(key: key);

  @override
  State<LiveMatchLayout> createState() {
    return _LiveMatchState();
  }
}

class _LiveMatchState extends State<LiveMatchLayout> {
  late CategoryByDate catgs;
  @override
  void initState() {
    super.initState();
    setState(() {
      catgs = widget.tournaments;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);
    bool isDarkTheme = (themeNotifier.getTheme() == AppThemes().darkTheme);
    return Container(
      child: _buildCountry(context, isDarkTheme),
      // child: _builLeaguedPanel(context, widget.tournaments),
    );
  }

  Widget _buildCountry(BuildContext context, bool isDarkTheme) {
    final homenoti = Provider.of<HomeNotifier>(context, listen: true);
    final configNotifier =
        Provider.of<GeneralConfigurationNotifier>(context, listen: false);
    final value = Provider.of<SelectedLeagueNotifier>(context, listen: true);
  
  
    ThemeData theme=isDarkTheme?AppThemes().darkTheme:AppThemes().lightTheme;
    return ExpansionPanelList(
      dividerColor: Colors.transparent,
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: (index, isExpanded) {
        setState(() {
          catgs.isExpanded = !isExpanded;
          setState(() {
            catgs.sportTournaments![index].isExpanded = !isExpanded;
            if (!isExpanded) {
              value.initWithTournament(catgs.sportTournaments![index]);
              catgs.isExpanded = true;
              value.joinGroup();
            } else {
              catgs.isExpanded = false;
              value.partGroup();
            }
          });
        });
      },
      children: catgs.sportTournaments!.map((e) {
        return ExpansionPanel(
          backgroundColor: isDarkTheme
              ? theme.bottomNavigationBarTheme.backgroundColor
              : theme.primaryColorLight,
          body: LeagueMatches(
            e.tournamentUId!,
            0,
            //widget.tournomantDay,
            6,
            homenoti.selectedSport.sportId!,
            isExpanded: !e.isExpanded,
          ),
          isExpanded: e.isExpanded,
          headerBuilder: (context, isExpanded) {
            return ListTile(
              title: Row(
                children: [
                  const Icon(Icons.star),
                  const SizedBox(
                    width: 8,
                  ),
                  configNotifier.getContriesFlags != null
                      ? FancyShimmerImage(
                          imageUrl: configNotifier
                              .getContriesFlags!.data!.countryFlagImages!
                              .firstWhere(
                                  (element) =>
                                      element.countryName ==
                                      e.sportCategory!.categoryDisplayName!,
                                  orElse: () => configNotifier.getContriesFlags!
                                      .data!.countryFlagImages!.first)
                              .countryFlagImagesName!,
                          //     .firstWhere((element) {
                          //  debugPrint(
                          //       '${element.countryName} -- ${e.categoryName}');
                          //   return element.countryName == e.categoryName;
                          // })
                          width: 18,
                          height: 12,
                        )
                      : const SizedBox(),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      // catgs.categoryName!,
                      '${e.sportCategory!.categoryDisplayName!} / ${e.tournamentDisplayName!}',
                      // homenoti.topBetSportEvent!.data!.categoriesByBetTypeList!
                      //     .first.categoryName!,
                      style: GoogleFonts.oswald(
                        fontSize: 18,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              tileColor: isDarkTheme
                  ? theme.bottomNavigationBarTheme.backgroundColor
                  : theme.primaryColorLight,
            );
          },
        );
      }).toList(),
    );
  }
}
