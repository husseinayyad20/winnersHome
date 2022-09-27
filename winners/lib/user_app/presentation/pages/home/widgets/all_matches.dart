import 'package:winners/user_app/core/constants/extensions/date_extensions.dart';
import 'package:winners/user_app/core/constants/theme.dart';

import 'package:winners/user_app/data/models/get_top_bet_sport_event_response_model/category_by_date/category_by_date.dart';
import 'package:winners/user_app/presentation/notifiers/general_configuration_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/home_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/selected_league_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/theme_notifier.dart';
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

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(
    numberOfItems,
    (int index) {
      final date = DateTime.now().add(Duration(days: index));
      return Item(
        headerValue: date,
        expandedValue: 'This is item number $index',
      );
    },
  );
}

class AllMatchesLayout extends StatefulWidget {
  const AllMatchesLayout({Key? key}) : super(key: key);

  @override
  State<AllMatchesLayout> createState() {
    return _AllMatchesLayoutState();
  }
}

class _AllMatchesLayoutState extends State<AllMatchesLayout> {
  @override
  Widget build(BuildContext context) {
    final homeNotifier = Provider.of<HomeNotifier>(context, listen: true);
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);
    bool isDarkTheme = (themeNotifier.getTheme() == AppThemes().darkTheme);
  ThemeData theme=isDarkTheme?AppThemes().darkTheme:AppThemes().lightTheme;
    var format = DateFormat('EEEE, d MMMM');
    var rawDate = DateTime.now().add(Duration(days: homeNotifier.selectedDay));
    var date = format.format(rawDate);
    if (rawDate.isToday) {
      var split = date.split(',');
      split.first = 'Today';
      date = split.toString().replaceAll('[', '').replaceAll(']', '');
    }
    return Column(
      children: [
        ExpansionTile(
          trailing: const SizedBox(),
          initiallyExpanded: true,
          //backgroundColor: Colors.amber,
          backgroundColor: isDarkTheme
              ? theme.primaryColor
              : theme.dividerColor.withOpacity(0.2),
          title: IgnorePointer(
            /// Disables the expansion and collapse of the [ExpansionTile Widget]
            ignoring: true,
            child: ListTile(
                title: Text(
                  date,
                  style: GoogleFonts.oswald(
                      fontSize: 18,
                      color: theme.toggleableActiveColor),
                ),
                tileColor: theme.primaryColor.withOpacity(0.2)),
          ), //themeDta.primaryColor,

          children: [
            _buildPanel(context, homeNotifier,theme),
          ],
        ),
        const SizedBox(
          height: 150,
        )
      ],
    );
  }

  // child: _buildPanel(context, homeNotifier),

  Widget _buildPanel(BuildContext context, HomeNotifier homeNotifier, ThemeData theme) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);

    bool isDarkTheme = (themeNotifier.getTheme() == AppThemes().darkTheme);

    final categories =
        homeNotifier.topBetSportEvent?.data?.categoriesByDateList ?? [];
    final configNotifier =
        Provider.of<GeneralConfigurationNotifier>(context, listen: false);

    return categories.isNotEmpty
        ? ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              for (var element in categories) {
                element.isExpanded = false;
              }
              setState(() {
                categories[index].isExpanded = !isExpanded;
                // setState(() {
                //   catgs[index].isExpanded = true;
                //   if (!isExpanded) {
                //     // value.initWithTournament(catgs.first.tournamentsByDays![index]);
                //     categories[index].isExpanded = true;
                //     value.joinGroup();
                //   } else {
                //     categories[index].isExpanded = false;
                //     // value.partGroup();
                //   }
                // });
              });
            },
            children: categories
                .map(
                  (e) => ExpansionPanel(
                    backgroundColor: isDarkTheme
                        ? theme.primaryColorLight
                        : theme.primaryColor,
                    canTapOnHeader: true,
                    // body: LeagueLayout(categories),
                    body: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ChangeNotifierProvider(
                            create: (_) => SelectedLeagueNotifier(homeNotifier),
                            child: LeagueLayout(
                                e, DateTime.now().add(const Duration(days: 1))),
                          ),
                        ],
                      ),
                    ),
                    isExpanded: e.isExpanded,

                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Row(
                          children: [
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
                              width: 15,
                            ),
                            Text(
                              '${e.categoryName!}        ${e.eventsCount}',
                              style: GoogleFonts.oswald(
                                fontSize: 18,
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
                .toList())
        : const SizedBox(
            height: 100,
          );
  }
}

List<String> opened = [];

class LeagueLayout extends StatefulWidget {
  final CategoryByDate tournaments;
  final DateTime tournomantDay;
  final bool? isLive;
  const LeagueLayout(
    this.tournaments,
    this.tournomantDay, {
    Key? key,
    this.isLive,
  }) : super(key: key);

  @override
  State<LeagueLayout> createState() {
    return _LeagueLayoutState();
  }
}

class _LeagueLayoutState extends State<LeagueLayout> {
  late CategoryByDate catgs;
  List<int> opened = [];
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
      // child: _builLeaguedPanel(context, widget.tournaments),
    );
  }

  Widget _buildCountry(BuildContext context, bool isDarkTheme, ThemeData theme) {
    final homenoti = Provider.of<HomeNotifier>(context, listen: true);
    final configNotifier =
        Provider.of<GeneralConfigurationNotifier>(context, listen: false);
    final value = Provider.of<SelectedLeagueNotifier>(context, listen: true);
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
              opened.add(catgs.sportTournaments![index].tournamentUId ?? 0);
            } else {
              catgs.isExpanded = false;
              value.partGroup();
              opened.remove(catgs.sportTournaments![index].tournamentUId ?? 0);
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
                  homenoti.selectedDay,
                  //fixthis
                  //widget.tournomantDay,
                  homenoti.feedIndex,
                  homenoti.selectedSport.sportId!,
                  isExpanded: e.isExpanded,
                )
              : Container(),
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
                      widget.isLive ?? false
                          ? '${e.tournamentDisplayName}'
                          : '${e.sportCategory!.categoryDisplayName!} / ${e.tournamentDisplayName!}',
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
