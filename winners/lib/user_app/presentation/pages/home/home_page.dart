import 'package:winners/user_app/core/constants/assets.dart';
import 'package:winners/user_app/core/constants/extensions/date_extensions.dart';
import 'package:winners/user_app/core/constants/extensions/widget_extensions.dart';
import 'package:winners/user_app/core/constants/theme.dart';
import 'package:winners/user_app/presentation/pages/spin_&_swin/spin_&_win.dart';

import 'package:winners/user_app/presentation/pages/virtual/virtual_matches_page.dart';
import 'package:winners/user_app/presentation/pages/virtual/virtual_page.dart';

import 'package:winners/user_app/data/models/leagues_tabs/sport_top_leagues_tab.dart';

import 'package:winners/user_app/presentation/notifiers/bet_slip/bet_slip_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/general_configuration_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/home_notifier.dart';

import 'package:winners/user_app/presentation/notifiers/selected_match_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/theme_notifier.dart';
import 'package:winners/user_app/presentation/pages/home/home_match_details_page.dart';
import 'package:winners/user_app/presentation/pages/home/widgets/all_countries.dart';
import 'package:winners/user_app/presentation/pages/home/widgets/all_matches.dart';
import 'package:winners/user_app/presentation/pages/home/widgets/daily_layout.dart';
import 'package:winners/user_app/presentation/resources/fonts_manager.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with
        TickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<HomePage>,
        WidgetsBindingObserver {
  @override
  bool get wantKeepAlive => true;
  late HomeNotifier homeNotifier;
  late GeneralConfigurationNotifier configNotifier;

  late BetSlipNotifier _betSlipNotifier;
  TabController? _tabController;
  ThemeNotifier? _themeNotifier;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    initHub();
    super.initState();
  }

  initHub() {
    configNotifier = Provider.of<GeneralConfigurationNotifier>(
      context,
      listen: false,
    );
    homeNotifier = Provider.of<HomeNotifier>(
      context,
      listen: false,
    );
    _betSlipNotifier = Provider.of<BetSlipNotifier>(context, listen: false);
    configNotifier.executeGetGeneralConfigurations().then((value) {
      homeNotifier.startHub(configNotifier.config!.data!.feedSr!);
      configNotifier.executeGetCountriesFlags();
      configNotifier.executeGetTeamsIcons();
      configNotifier.executeGetCurrencies();
      configNotifier.executeGetSportTypeIcon();
      configNotifier.executeGetLeaguesTabs(homeNotifier);
      setState(() {});
    });
    configNotifier.executeGetBetSlipConfiguration().whenComplete(() {
      _betSlipNotifier.setBetSlipConfigurationIsLoad(true);
      _betSlipNotifier.setBetSlipConfigurationEntity(
        configNotifier.betSlipConfigurationEntity,
      );
    }).catchError((error) {
      _betSlipNotifier.setBetSlipConfigurationIsLoad(false);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        initHub();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    homeNotifier.setConfigNotifier(configNotifier);

    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);
    bool _isDarkTheme = (themeNotifier == AppThemes().darkTheme);
    bool isMatchSelected = homeNotifier.matchNotifier != null;
    ThemeData theme =
        _isDarkTheme ? AppThemes().darkTheme : AppThemes().lightTheme;
    return configNotifier.config == null
        ? SizedBox()
        : Theme(
            data: theme,
            child: Stack(
              children: [
                _homePageScaffold(
                    _isDarkTheme
                        ? AppThemes().darkTheme
                        : AppThemes().lightTheme,
                    context),
                isMatchSelected
                    ? ChangeNotifierProvider(
                        lazy: false,
                        create: (_) {
                          return SelectedMatchNotifier(
                              homeNotifier, homeNotifier.selectedSportEvent!);
                        },
                        child: HomeMatchDetailsPage(
                          matchNotifier: homeNotifier.matchNotifier!,
                        ),
                      )
                    : const SizedBox(),
                homeNotifier.showVirtualSportType &&
                        !homeNotifier.showVirtualMatches
                    ? const VirtualPage()
                    : const SizedBox(),
                homeNotifier.showVirtualMatches &&
                        homeNotifier.showVirtualSportType
                    ? const VirtualMatchesPage(title: 'VFLM')
                    : const SizedBox()
              ],
            ),
          );
  }

  Widget _homePageScaffold(
    ThemeData themeNotifier,
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: themeNotifier.primaryColor,
      body: SafeArea(
        bottom: false,
        child: NotificationListener<ScrollNotification>(
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverToBoxAdapter(
                  child: _header(
                context,
                themeNotifier,
              )),
              SliverPersistentHeader(
                pinned: true,
                delegate: SectionHeaderDelegate(
                    _mainMenu(
                      context,
                      themeNotifier,
                    ),
                    themeNotifier),
              ),
              SliverToBoxAdapter(
                child: _sportsMenu(
                  context,
                  themeNotifier,
                  homeNotifier,
                ),
              ),
              homeNotifier.feedIndex != 5
                  ? SliverToBoxAdapter(
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 8,
                        ),
                        child: Consumer<GeneralConfigurationNotifier>(
                          builder: (context, config, child) {
                            List<LeaguesTab> leaguesTabs = (config
                                        .leaguesTabsEntity
                                        ?.sportTopLeaguesTab ==
                                    null)
                                ? []
                                : config.leaguesTabsEntity!.sportTopLeaguesTab!;
                            List<LeaguesTabItem> tabsList = [];
                            Map<String, List<LeaguesTab>> tabsMap = {};
                            for (final tab in leaguesTabs) {
                              if (tabsMap.containsKey(
                                  tab.liveTopLeaguesTabId.toString())) {
                                tabsMap[tab.liveTopLeaguesTabId.toString()]!
                                    .add(tab);
                              } else {
                                tabsMap[tab.liveTopLeaguesTabId.toString()] = [
                                  tab
                                ];
                              }
                            }
                            for (final val in tabsMap.values) {
                              final disabledTab = val
                                  .where((element) => element.disable == true)
                                  .toList()
                                  .first;
                              final enabled = val
                                  .where((element) => element.disable == false)
                                  .toList()
                                  .first;
                              LeaguesTabItem newItem = LeaguesTabItem(
                                  disabledTab.preMatchTopLeaguesTabId,
                                  disabledTab.sportTopLeaguesTabName,
                                  enabled.sportTopLeaguesTabName,
                                  enabled);
                              tabsList.add(newItem);
                            }
                            List<LeaguesTabItem> shortedList = [];

                            if (tabsList.isNotEmpty) {
                              shortedList.add(tabsList.firstWhere((element) =>
                                  element.tab!.liveTopLeaguesTabId! == 1));
                              shortedList.add(tabsList.firstWhere((element) =>
                                  element.tab!.liveTopLeaguesTabId! == 3));
                              shortedList.add(tabsList.firstWhere((element) =>
                                  element.tab!.liveTopLeaguesTabId! == 4));
                              shortedList.add(tabsList.firstWhere((element) =>
                                  element.tab!.liveTopLeaguesTabId! == 2));
                              shortedList.toSet().toList();
                            }
                            homeNotifier.setLeaguesTabs(shortedList);

                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: shortedList.length,
                              itemBuilder: (context, indexPath) {
                                final item = shortedList[indexPath];

                                return Container(
                                  height: 100,
                                  width: 100,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: themeNotifier.primaryColorDark,
                                    // color: Colors.red,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      if (item.tab!.liveTopLeaguesTabId == 2) {
                                      } else {
                                        configNotifier.setLeaguesTab(item.tab!);
                                        homeNotifier.league = item.tab!;
                                        homeNotifier.invokeWithDate();
                                      }
                                    },
                                    child: Center(
                                      child: SvgPicture.network(
                                        configNotifier.selectedLeagueTab!
                                                    .preMatchTopLeaguesTabId ==
                                                item.id
                                            ? item.enabled!
                                            : item.disabled!,
                                        fit: BoxFit.contain,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    )
                  : const SliverToBoxAdapter(
                      child: AllCountriesLayout(),
                    ),
              homeNotifier.feedIndex != 5
                  ? SliverPersistentHeader(
                      pinned: true,
                      delegate: SectionHeaderDelegate(
                          _shortBets(homeNotifier, themeNotifier),
                          themeNotifier),
                    )
                  : SliverPersistentHeader(
                      delegate: SectionHeaderDelegate(
                          const SizedBox(), themeNotifier),
                    ),
              SliverToBoxAdapter(
                child: homeNotifier.league?.liveTopLeaguesTabId == 3 &&
                        homeNotifier.feedIndex == 6
                    ? Container(
                        height: 46,
                        color: themeNotifier.primaryColorLight,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            // 'Last Min',
                            DateTime(2050),
                            DateTime.now(),
                            DateTime.now().add(const Duration(days: 1)),
                            DateTime.now().add(const Duration(days: 2)),
                            DateTime.now().add(const Duration(days: 3)),
                            DateTime.now().add(const Duration(days: 4)),
                            DateTime.now().add(const Duration(days: 5)),
                            DateTime.now().add(const Duration(days: 6)),
                            DateTime.now().add(const Duration(days: 7)),
                          ].map((e) {
                            var format = DateFormat('E');
                            var rawDate = e;
                            var date = format.format(rawDate);
                            if (rawDate.isToday) {
                              var split = date.split(',');
                              split.first = 'Today';
                              date = split
                                  .toString()
                                  .replaceAll('[', '')
                                  .replaceAll(']', '');
                            }
                            final diff = e.differenceInDays(DateTime.now());
                            return GestureDetector(
                              onTap: () {
                                homeNotifier.setSelectedDay(diff);
                                homeNotifier.invokeWithDate();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  e.year == 2050 ? 'Last Min' : date,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      // fontSize: isSelected ? 20 : 18,
                                      fontSize: 16,
                                      fontWeight: FontWeightManager.medium,
                                      // color:
                                      //     themeNotifier.toggleableActiveColor,
                                      color: (homeNotifier.selectedDay == diff)
                                          ? themeNotifier.toggleableActiveColor
                                          : themeNotifier.dividerColor),
                                ).center(),
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    : const SizedBox(),
              ),
              SliverToBoxAdapter(
                child: homeNotifier.league?.liveTopLeaguesTabId == 4 &&
                        homeNotifier.feedIndex == 6
                    ? const AllCountriesLayout()
                    : const SizedBox(),
              ),
              SliverToBoxAdapter(
                child: homeNotifier.league?.liveTopLeaguesTabId == 3 &&
                        homeNotifier.feedIndex == 6
                    ? const AllMatchesLayout()
                    : const SizedBox(),
              ),
              homeNotifier.feedIndex != 1
                  ? SliverToBoxAdapter(
                      child: homeNotifier.league?.liveTopLeaguesTabId == 1 &&
                              homeNotifier.feedIndex == 6
                          ? const DailyLayout()
                          : const SizedBox(),
                    )
                  : const SliverToBoxAdapter(
                      child: SizedBox(),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget _shortBets(HomeNotifier homeNotifier, ThemeData themeData) {
    homeNotifier.betTypes.sort((a, b) {
      return a.betTypeId!.compareTo(b.betTypeId!);
    });
    return SizedBox(
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        // itemCount: sortedList.length,
        itemCount: homeNotifier.betTypes.length,
        itemBuilder: (BuildContext context, int indexPath) {
          final bet = homeNotifier.betTypes[indexPath];
          final bool isSelected =
              bet.betTypeId == (homeNotifier.selectedBetType?.betTypeId ?? 1);
          return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 4,
            ),
            child: InkWell(
              onTap: () {
                homeNotifier.setSelectedBetType(bet);
                //homeNotifier.invokeWithDate();
              },
              splashColor: Colors.transparent,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                decoration: BoxDecoration(
                    color: isSelected
                        // ignore: deprecated_member_use
                        ? themeData.accentColor
                        : themeData.primaryColorLight,
                    borderRadius: BorderRadius.circular(17)),
                child: Center(
                  child: Text(
                    bet.betTypeDisplayName! +
                        ' ' +
                        (bet.defaultSpecialField ?? ''),
                    style: GoogleFonts.oswald(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: isSelected ? Colors.white : themeData.dividerColor,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _header(
    BuildContext context,
    ThemeData themeData,
  ) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    var generalConfigurationNotifier =
        Provider.of<GeneralConfigurationNotifier>(context, listen: false);
    bool shouldShowLoginRegister =
        generalConfigurationNotifier.config!.data!.accessToSignInAndRegister ==
            1;
    return Consumer(
      builder: (context, value, child) {
        return Row(
          children: [
            SvgPicture.asset(
              Assets.logo,
              width: 140,
            ).padding(
              padding: const EdgeInsets.only(
                bottom: 8,
              ),
            ),
            const Spacer(),
          ],
        );
      },
    );
  }

  Widget _mainMenu(BuildContext context, ThemeData themeData) {
    final notifier = Provider.of<HomeNotifier>(context, listen: true);
    final headerTabs = notifier.header?.data?.headerTabs ?? [];
    return Container(
        width: double.infinity,
        height: 60,
        color: themeData.primaryColorLight,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            // mainAxisAlignm/ent: MainAxisAlignment.spaceAround,
            scrollDirection: Axis.horizontal,
            children: headerTabs
                //.where((element) => element.headerTabsId != 5)
                .map((e) {
              final bool isSelected =
                  6 - headerTabs.indexOf(e) == notifier.feedIndex;
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: InkWell(
                  child: Text(
                    e.headerTabsName!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.oswald(
                      fontSize: isSelected ? 20 : 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? themeData.toggleableActiveColor
                          : themeData.dividerColor,
                    ),
                  ).center(),
                  onTap: () {
                    // check if header tap id is 3 show slots page
                    debugPrint(e.headerTabsId.toString());
                    if (e.headerTabsId == 2) {
                      /// Live feed
                      notifier.getSportTypes(feedId: 5);
                      notifier.setFeedId(6 - headerTabs.indexOf(e));
                      notifier.setSelectedBetType(notifier.betTypes.first);
                      notifier.setVirtualFeedId(6 - headerTabs.indexOf(e));
                      notifier.invokeWithDate(sportId: 1);
                    } else if (e.headerTabsId == 5) {
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const SpinAndWin()),
                        ),
                      );
                    } else if (e.headerTabsId == 4) {
                      final homeNotifier = Provider.of<HomeNotifier>(
                        context,
                        listen: false,
                      );
                      homeNotifier.getSportTypes(feedId: 7);
                      notifier.setShowVirtualSportType(true);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: ((context) => const VirtualPage()),
                      //   ),
                      // );
                    } else {
                      /// Mark: Check with Kadan
                      /// line below was notifier.setSportTypes(null);
                      // notifier.setSportTypes(null);
                      notifier.setFeedId(6 - headerTabs.indexOf(e));
                      notifier.setVirtualFeedId(6 - headerTabs.indexOf(e));
                      notifier.getSportTypes(feedId: 6 - headerTabs.indexOf(e));
                      notifier.invokeWithDate();
                    }
                  },
                ),
              );
            }).toList(),
          ),
        ));
  }

  // indicates a change in the count of sports types, which
  // leads to the re-creation of the _tabController below
  int lastLengthOfSportsTypes = 0;
  Widget _sportsMenu(
    BuildContext context,
    ThemeData themeData,
    HomeNotifier homeNotifier,
  ) {
    var list = homeNotifier.sportTypes?.data ?? [];
    bool lengthChanged = list.length != lastLengthOfSportsTypes;
    bool listNotEmpty = list.isNotEmpty;
    if (lengthChanged && listNotEmpty) {
      _tabController = TabController(length: list.length, vsync: this);
    }
    // if (_tabController == null && list.isNotEmpty) {
    //   _tabController = TabController(length: list.length, vsync: this);
    // }
    if (list.isNotEmpty) {
      lastLengthOfSportsTypes = list.length;
      return homeNotifier.noMatchesErrorMessage!.isNotEmpty
          ? const SizedBox()
          : Container(
              width: double.infinity,
              height: 50,
              color: themeData.primaryColorLight,
              child: TabBar(
                onTap: (newIndex) {
                  _tabController!.animateTo(newIndex);
                  _tabController!.notifyListeners();
                  homeNotifier.setSelectedSport(list[newIndex].sport!);
                  homeNotifier.invokeWithDate();
                },
                isScrollable: true,
                controller: _tabController,
                tabs: list
                    .map(
                      (item) => Tab(
                        iconMargin: EdgeInsets.zero,
                        child: InkWell(
                          onTap: () {
                            _tabController!.animateTo(list.indexOf(item));
                            _tabController!.notifyListeners();
                            homeNotifier.setSelectedSport(item.sport!);
                            homeNotifier.invokeWithDate();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: homeNotifier.selectedSport == item
                                      // ignore: deprecated_member_use
                                      ? themeData.accentColor
                                      : Colors.transparent,
                                  width: 2.5,
                                ),
                              ),
                            ),
                            child: configNotifier.sportTypeIconEntity == null
                                ? SizedBox()
                                : SvgPicture.network(
                                    configNotifier.sportTypeIconEntity!.data!
                                        .sportTypesIcons!
                                        .firstWhere(
                                          (element) =>
                                              element.sportTypesIconsId! ==
                                              item.sport!.sportId,
                                          orElse: () => configNotifier
                                              .sportTypeIconEntity!
                                              .data!
                                              .sportTypesIcons!
                                              .first,
                                        )
                                        .sportTypesIconsName!,
                                    allowDrawingOutsideViewBox: false,
                                    width: 56,
                                    height: 24,
                                  ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              // ListView.builder(
              //   scrollDirection: Axis.horizontal,
              //   itemCount: list?.length ?? 0,
              //   itemBuilder: (context, indexPath) {
              //     final item = homeNotifier.sportTypes.data![indexPath].sport!;
              //     // return;
              //     return Padding(
              //       padding: const EdgeInsets.all(16),
              //       child: InkWell(
              //         onTap: () {
              //           homeNotifier.setSelectedSport(item);
              //           homeNotifier.invokeWithDate();
              //         },
              //         child: Container(
              //           decoration: BoxDecoration(
              //             border: Border(
              //               bottom: BorderSide(
              //                 color: homeNotifier.selectedSport == item
              //                     // ignore: deprecated_member_use
              //                     ? themeData.accentColor
              //                     : Colors.transparent,
              //                 width: 2.5,
              //               ),
              //             ),
              //           ),
              //           child: Image.network(
              //             configNotifier.sportTypeIconEntity!.data!.sportTypesIcons!
              //                 .firstWhere(
              //                   (element) => element.sportTypesIconsId! == item.sportId,
              //                   orElse: () => configNotifier
              //                       .sportTypeIconEntity!.data!.sportTypesIcons!.first,
              //                 )
              //                 .sportTypesIconsName!,
              //             width: 100,
              //             height: 100,
              //           ),
              //         ),
              //       ),
              //     );
              //   },
              // ),
            );
    }
    return const SizedBox();
  }
}

class SectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final ThemeData themeNotifier;

  SectionHeaderDelegate(this.child, this.themeNotifier);

  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: themeNotifier.primaryColor,
      alignment: Alignment.center,
      child: child,
    );
  }

  @override
  double get maxExtent => 65;

  @override
  double get minExtent => 65;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class LeaguesTabItem {
  int? id;
  String? disabled;
  String? enabled;

  LeaguesTab? tab;

  LeaguesTabItem(idN, disabledN, enabledN, tabN) {
    id = idN;
    disabled = disabledN;
    enabled = enabledN;
    tab = tabN;
  }
}
