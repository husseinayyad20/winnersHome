import 'package:winners/user_app/core/constants/theme.dart';
import 'package:winners/user_app/data/models/get_top_bet_sport_event_response_model/tournament_by_day/tournament_by_day.dart';

import 'package:winners/user_app/presentation/notifiers/general_configuration_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/home_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/selected_league_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/theme_notifier.dart';
import 'package:winners/user_app/presentation/resources/fonts_manager.dart';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'league_matches.dart';

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

class AllCountriesLayout extends StatefulWidget {
  const AllCountriesLayout({Key? key}) : super(key: key);

  @override
  State<AllCountriesLayout> createState() {
    return _AllCountriesLayoutState();
  }
}

class _AllCountriesLayoutState extends State<AllCountriesLayout> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);
    bool isDarkTheme = (themeNotifier.getTheme() == AppThemes().darkTheme);
    final homeNotifier = Provider.of<HomeNotifier>(context, listen: true);
    return Container(
      child: _buildPanel(context, homeNotifier, isDarkTheme),
    );
  }

  Widget _buildPanel(
      BuildContext context, HomeNotifier homeNotifier, bool isDarkTheme) {
    final categories =
        homeNotifier.topBetSportEvent?.data?.categoriesByBetTypeList! ?? [];
        ThemeData theme=isDarkTheme?AppThemes().darkTheme:AppThemes().lightTheme;
    final configNotifier =
        Provider.of<GeneralConfigurationNotifier>(context, listen: false);
    return categories.isEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 10),
            child: Text(
              homeNotifier.noMatchesErrorMessage!,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16,
              ),
            ),
          )
        : ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                categories[index].isExpanded = !isExpanded;
                setState(() {
                  // catgs[index].isExpanded = true;
                  if (!isExpanded) {
                    // value.initWithTournament(catgs.first.tournamentsByDays![index]);

                    categories[index].isExpanded = true;

                    // value.joinGroup();
                  } else {
                    categories[index].isExpanded = false;

                    // value.partGroup();
                  }
                });
              });
            },
            children: categories
                .map(
                  (country) => ExpansionPanel(
                    backgroundColor: theme.primaryColor,
                    canTapOnHeader: true,
                    // body: LeagueLayout(categories),
                    body: Column(
                      children: country.tournamentsByDays!
                          .map((TournamentByDay item) {
                        var format = DateFormat('EEEE, d MMMM');
                        var rawDate = item.day;
                        final datestr =
                            DateTime.now().add(Duration(days: rawDate ?? 0));

                        var date = format.format(datestr);
                        if (rawDate == 0) {
                          var split = date.split(',');
                          split.first = 'Today';
                          date = split
                              .toString()
                              .replaceAll('[', '')
                              .replaceAll(']', '');
                        } else if (rawDate == 1) {
                          var split = date.split(',');
                          split.first = 'Tomorrow';
                          date = split
                              .toString()
                              .replaceAll('[', '')
                              .replaceAll(']', '');
                        }
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      date,
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.poppins(
                                        fontSize: FontSize.s16,
                                        fontWeight: FontWeightManager.medium,
                                      ),
                                    ),
                                  ),
                                  ChangeNotifierProvider(
                                      lazy: true,
                                      create: (_) =>
                                          SelectedLeagueNotifier(homeNotifier),
                                      child:
                                          (LeagueLayout(item, rawDate ?? 0))),
                                ]));
                      }).toList(),
                    ),
                    isExpanded: country.isExpanded,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        dense: true,
                        title: Row(
                          children: [
                            configNotifier.getContriesFlags != null
                                ? FancyShimmerImage(
                                    cacheKey: configNotifier.getContriesFlags!
                                        .data!.countryFlagImages!
                                        .firstWhere(
                                            (element) =>
                                                element.countryName ==
                                                country.categoryName!,
                                            orElse: () => configNotifier
                                                .getContriesFlags!
                                                .data!
                                                .countryFlagImages!
                                                .first)
                                        .countryFlagImagesName!,
                                    imageUrl: configNotifier.getContriesFlags!
                                        .data!.countryFlagImages!
                                        .firstWhere(
                                            (element) =>
                                                element.countryName ==
                                                country.categoryName!,
                                            orElse: () => configNotifier
                                                .getContriesFlags!
                                                .data!
                                                .countryFlagImages!
                                                .first)
                                        .countryFlagImagesName!,
                                    width: 22,
                                    height: 15,
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              country.categoryName!,
                              style: GoogleFonts.oswald(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        tileColor: theme.primaryColor,
                      );
                    },
                  ),
                )
                .toList(),
          );
  }
}

List<int> opened = [];
int? openedDate = 0;

class LeagueLayout extends StatefulWidget {
  final TournamentByDay tournaments;

  final int tournomantDay;
  const LeagueLayout(this.tournaments, this.tournomantDay, {Key? key})
      : super(key: key);

  @override
  State<LeagueLayout> createState() {
    return _LeagueLayoutState();
  }
}

class _LeagueLayoutState extends State<LeagueLayout> {
  late TournamentByDay catgs;
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
    ThemeData theme=isDarkTheme?AppThemes().darkTheme:AppThemes().lightTheme;
    return Container(
      child: _buildCountry(context, isDarkTheme,theme),
    );
  }

  Widget _buildCountry(BuildContext context, bool isDarkTheme, ThemeData theme) {
    final homenoti = Provider.of<HomeNotifier>(context, listen: true);
    final configNotifier =
        Provider.of<GeneralConfigurationNotifier>(context, listen: false);
    final value = Provider.of<SelectedLeagueNotifier>(context, listen: true);
    return ExpansionPanelList(
      dividerColor: Colors.transparent,
      expansionCallback: (index, isExpanded) {
        setState(() {
          catgs.isExpanded = !isExpanded;
          setState(() {
            if (!isExpanded) {
              catgs.sportTournaments?[index].isExpanded = true;
              // value.initWithTournament(
              //     catgs.tournamentsByDays!.first.sportTournaments![index]);
              catgs.isExpanded = true;
              value.joinGroup();
              opened.add(catgs.sportTournaments?[index].tournamentUId ?? 0);
            } else {
              catgs.sportTournaments![index].isExpanded = false;
              catgs.isExpanded = false;
              value.partGroup();
              opened.remove(catgs.sportTournaments?[index].tournamentUId ?? 0);
            }
          });
        });
      },
      children: catgs.sportTournaments!.map((e) {
        return ExpansionPanel(
          backgroundColor: isDarkTheme
              ? theme.bottomNavigationBarTheme.backgroundColor
              : theme.primaryColorLight,
          body: opened.contains(e.tournamentUId)
              ? LeagueMatches(
                  e.tournamentUId!,
                  widget.tournomantDay,
                  homenoti.feedIndex,
                  homenoti.selectedSport.sportId!,
                  isExpanded: true,
                )
              : Container(),
          isExpanded: e.isExpanded!,
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
                                      e.sportCategory?.categoryDisplayName,
                                  orElse: () => configNotifier.getContriesFlags!
                                      .data!.countryFlagImages!.first)
                              .countryFlagImagesName!,
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
                      e.tournamentDisplayName!,
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
