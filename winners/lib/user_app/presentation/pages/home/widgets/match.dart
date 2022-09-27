import 'package:winners/user_app/core/constants/strings.dart';
import 'package:winners/user_app/core/constants/theme.dart';
import 'package:winners/user_app/core/hex_color.dart';

import 'package:winners/user_app/data/models/bet_slip/bet_slip_item/bet_slip_item.dart';
import 'package:winners/user_app/data/models/get_top_bet_sport_event_response_model/sport_event.dart';
import 'package:winners/user_app/presentation/notifiers/bet_slip/bet_slip_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/general_configuration_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/home_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/match_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/theme_notifier.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import 'timer_widget.dart';

class HomePageMatchWidget extends StatefulWidget {
  final SportEvent? event;
  final int selectedbetType;
  final Map<String, dynamic> oddFields;
  final Map<String, dynamic> odds;
  final bool isVirtual;
  @override
  const HomePageMatchWidget(this.event, this.oddFields, this.selectedbetType,
      this.odds, this.isVirtual,
      {Key? key})
      : super(key: key);
  @override
  _HomePageMatchWidgetState createState() => _HomePageMatchWidgetState();
}

class _HomePageMatchWidgetState extends State<HomePageMatchWidget> {
  String? joinedGroup;
  late HomeNotifier homeNotifier;
  Widget getBetType() {
    if (widget.selectedbetType == 3) {
      return OverUnderBet(widget.odds);
    } else {
      return MatchBetType(widget.odds);
    }
  }

  @override
  void didChangeDependencies() {
    // listenToMatchEvents(homeNotifier);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    if (joinedGroup != null) {
      homeNotifier.invokeGroup('PartGroup', [
        joinedGroup!,
      ]);
      joinedGroup = null;
    }

    super.dispose();
  }

  listenToMatchEvents(HomeNotifier homeNotifier) {
    var feedId = 6;
    if (widget.isVirtual) {
      feedId = homeNotifier.virtualFeedId!;
    } else {
      feedId = homeNotifier.feedIndex;
    }
    final sportId = homeNotifier.selectedSport.sportId ?? 1;
    final groupName =
        'F${feedId}S${sportId}E' + widget.event!.eventId!.toString();
    joinedGroup = groupName;
    homeNotifier.invokeGroup('JoinGroup', [
      groupName,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final configNotifier =
        Provider.of<GeneralConfigurationNotifier>(context, listen: false);
    homeNotifier = Provider.of<HomeNotifier>(context, listen: true);
    final matchNotifier = Provider.of<MatchNotifier>(context, listen: true);
     final themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);
    bool isDarkTheme = (themeNotifier.getTheme() == AppThemes().darkTheme);
    ThemeData theme=isDarkTheme?AppThemes().darkTheme:AppThemes().lightTheme;
    listenToMatchEvents(homeNotifier);
    return ListTile(
      onTap: () {
        homeNotifier.setStaticIconSelected(
          false,
        );
        if (widget.isVirtual) {
          homeNotifier.setVirtualMatch(widget.oddFields);
          homeNotifier.setVirtualOdds(widget.odds);
          homeNotifier.setVirtualSportEvent(widget.event!, 'Country');
          homeNotifier.setVirtualMatchNotifier(matchNotifier);
        } else {
          homeNotifier.setMatch(widget.oddFields);
          homeNotifier.setOdds(widget.odds);
          homeNotifier.setSportEvent(widget.event!, 'Country');
          homeNotifier.setMatchNotifier(matchNotifier);
        }
      },
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.isVirtual
                    ? widget.event!.virtualSeasonName! +
                        " Day: " +
                        widget.event!.virtualDayName
                    : 'ID : ${widget.event!.eventBetLineNo}',
                style: theme
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.grey),
              ),
              Text(
                '+${widget.event!.eventBetTypesCount}',
                style: theme
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          (matchNotifier.eventScore?.score != null)
              ? Row(
                  children: [
                    if (matchNotifier.sportEvent.isStarted ?? false)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(
                          Strings.live,
                          textAlign: TextAlign.center,
                          style: theme
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Builder(builder: (context) {
                        final time = matchNotifier.eventScore?.eventTime ??
                            matchNotifier.sportEvent.eventScore?.eventTime;
                        return TimeWidget(time ?? 0);
                      }),
                    ),
                    const Spacer(),
                    Text(
                      '${matchNotifier.eventScore?.eventStatusDisplayName}',
                      style: theme
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.grey),
                    ),
                  ],
                )
              : Text(
                  '${widget.event!.eventDateOfMatchFormated}',
                  style: theme
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.grey),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        homeNotifier.feedIndex == 1
                            ? const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                child: Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 20,
                                ),
                              )
                            : const SizedBox(),
                        !widget.isVirtual && !(widget.event!.feed!.feedId == 5)
                            ? Container(
                                width: 25,
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: theme.shadowColor,
                                ),
                                child: Center(
                                  child: Text(
                                    widget.event!.homeTeamRank.toString() == '0'
                                        ? '-'
                                        : widget.event!.homeTeamRank.toString(),
                                    style: theme
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          color: Colors.black.withOpacity(0.6),
                                        ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(
                          width: 5,
                        ),
                        (configNotifier.teamsIcons?.teamsIcons ?? [])
                                .where((element) =>
                                    element.teamId ==
                                    widget.event!.eventHomeTeamId)
                                .isNotEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, right: 4),
                                child: FancyShimmerImage(
                                  imageUrl:
                                      (configNotifier.teamsIcons?.teamsIcons ??
                                              [])
                                          .firstWhere((element) =>
                                              element.teamId ==
                                              widget.event!.eventHomeTeamId)
                                          .mediumPath!,
                                  width: 20,
                                  height: 20,
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, right: 4),
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: HexColor(
                                    widget.event!.eventHomeTeamColor ??
                                        'AEB4BF',
                                  ),

                                  /// Home Team name initials (Real Madrid => RM)
                                  child: Text(
                                    widget.event!.eventHomeTeamName!
                                            .split(' ')
                                            .first
                                            .substring(0, 1) +
                                        widget.event!.eventHomeTeamName!
                                            .split(' ')
                                            .last
                                            .substring(0, 1),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                            width: 100,
                            child: Text(widget.event!.eventHomeTeamName!,style: TextStyle(
                                  color: isDarkTheme?Colors.white:Colors.black
                            ),)),
                        homeNotifier.feedIndex == 1
                            ? const Text("0")
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        homeNotifier.feedIndex == 1
                            ? const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                child: Icon(
                                  Icons.star,
                                  size: 20,
                                ),
                              )
                            : const SizedBox(),
                        !widget.isVirtual && !(widget.event!.feed!.feedId == 5)
                            ? Container(
                                width: 25,
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: theme.shadowColor,
                                ),
                                child: Center(
                                    child: Text(
                                        widget.event!.awayTeamRank.toString() ==
                                                '0'
                                            ? '-'
                                            : widget.event!.awayTeamRank
                                                .toString(),
                                        style: theme
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                                color: Colors.black
                                                    .withOpacity(0.6)))),
                              )
                            : const SizedBox(),
                        const SizedBox(
                          width: 5,
                        ),
                        (configNotifier.teamsIcons?.teamsIcons ?? [])
                                .where((element) =>
                                    element.teamId ==
                                    widget.event!.eventAwayTeamId)
                                .isNotEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, right: 4),
                                child: FancyShimmerImage(
                                  imageUrl:
                                      (configNotifier.teamsIcons?.teamsIcons ??
                                              [])
                                          .firstWhere((element) =>
                                              element.teamId ==
                                              widget.event!.eventAwayTeamId)
                                          .mediumPath!,
                                  width: 20,
                                  height: 20,
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, right: 4),
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: HexColor(
                                    widget.event!.eventAwayTeamColor ??
                                        'AEB4BF',
                                  ),

                                  /// Home Team name initials (Real Madrid => RM)
                                  child: Text(
                                    widget.event!.eventAwayTeamName!
                                            .split(' ')
                                            .first
                                            .substring(0, 1) +
                                        widget.event!.eventAwayTeamName!
                                            .split(' ')
                                            .last
                                            .substring(0, 1),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 90,
                          child: Text(
                            widget.event!.eventAwayTeamName!,
                            style: TextStyle(
                                  color: isDarkTheme?Colors.white:Colors.black
                            ),
                          ),
                        ),
                        homeNotifier.feedIndex == 1
                            ? const Text("0")
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
              Builder(builder: (context) {
                if (matchNotifier.eventScore?.score != null) {
                  final scores =
                      matchNotifier.eventScore!.score.toString().split(":");
                  return Column(
                    children: [
                      Text(scores[0]),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(scores[1]),
                    ],
                  );
                } else {
                  return Container();
                }
              }),
              getBetType(),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 5,
            ),
            height: 1,
            color: Colors.grey.withOpacity(0.5),
          )
        ],
      ),
    );
  }
}

class MatchBetType extends StatefulWidget {
  final Map<String, dynamic> eventOdds;
  final bool? isVirtual;
  @override
  const MatchBetType(this.eventOdds, {this.isVirtual, Key? key})
      : super(key: key);
  @override
  _MatchBetTypeState createState() => _MatchBetTypeState();
}

class _MatchBetTypeState extends State<MatchBetType> {
  @override
  Widget build(BuildContext context) {
     final themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);
    bool isDarkTheme = (themeNotifier.getTheme() == AppThemes().darkTheme);
    ThemeData theme=isDarkTheme?AppThemes().darkTheme:AppThemes().lightTheme;
    final values = widget.eventOdds.values.toList();
    // if (values.length < 2) {
    //   return Container();
    // }
    final homeTeam = values.firstWhereOrNull((element) {
      if (element is! Map) {
        return false;
      }
      return element["oddField"]?.toLowerCase() == '1';
    });

    final awayTeam = values.firstWhereOrNull((element) {
      if (element is! Map) {
        return false;
      }
      return element["oddField"]?.toLowerCase() == '2';
    });

    final draw = values.firstWhereOrNull((element) {
      if (element is! Map) {
        return false;
      }
      return element["oddField"]?.toLowerCase() == 'x';
    });

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          homeTeam != null
              ? OddBox(
                  homeTeam,
                  // isVirtual: widget.isVirtual
                )
              : Container(
                  key: UniqueKey(),
                  height: 50,
                  width: 55,
                  decoration:
                      BoxDecoration(color: theme.primaryColor),
                  child: const Icon(Icons.lock)),
          const SizedBox(
            width: 4,
          ),
          draw != null
              ? OddBox(
                  draw,
                )
              : Container(
                  key: UniqueKey(),
                  height: 50,
                  width: 55,
                  decoration:
                      BoxDecoration(color: theme.primaryColor),
                  child: const Icon(Icons.lock)),
          const SizedBox(
            width: 4,
          ),
          awayTeam != null
              ? OddBox(
                  awayTeam,
                )
              : Container(
                  key: UniqueKey(),
                  height: 50,
                  width: 55,
                  decoration:
                      BoxDecoration(color: theme.primaryColor),
                  child: const Icon(Icons.lock)),
        ]);
  }
}

class OddBox extends StatefulWidget {
  final Map<String, dynamic> odd;

  @override
  const OddBox(this.odd, {Key? key}) : super(key: key);
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
 final themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);
    bool isDarkTheme = (themeNotifier.getTheme() == AppThemes().darkTheme);
    ThemeData theme=isDarkTheme?AppThemes().darkTheme:AppThemes().lightTheme;
    final feedId = homeNotifier.virtualFeedId?.toString() ??
        homeNotifier.feedIndex.toString();
    final sportId = homeNotifier.selectedSport.sportId.toString();
    final betLine = widget.odd["activeOddFieldId"].toString();
    final uniqueId = feedId + '_' + sportId + '_' + betLine;
    final liveUniqueId = '5' '_' + sportId + '_' + betLine;

    final betslipNotifier = Provider.of<BetSlipNotifier>(context, listen: true);
    final matchNotifier = Provider.of<MatchNotifier>(context, listen: true);
    final alreadyExist = betslipNotifier.isBetExist(id: uniqueId) ||
        betslipNotifier.isBetExist(id: liveUniqueId);
    final oddMap = context
        .watch<MatchNotifier>()
        .homeEventOddFields[widget.odd["activeOddFieldId"].toString()];
    if (oddMap == null) {
      // if odd deleted or currupted
      return Container();
    }
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
            decoration: BoxDecoration(color: theme.primaryColor),
            child: const Icon(Icons.lock))
        : GestureDetector(
            onTap: () {
              final homeTeam = matchNotifier.sportEvent.eventHomeTeamName;
              final awayTeam = matchNotifier.sportEvent.eventAwayTeamName;
              final homeTeamId = matchNotifier.sportEvent.eventHomeTeamId;
              final awayTeamId = matchNotifier.sportEvent.eventAwayTeamId;
              final betSlip = BetSlipItem.fromMap(widget.odd);
              betSlip.homeTeamName = homeTeam;
              betSlip.awayTeamName = awayTeam;
              betSlip.homeTeamId = homeTeamId;
              betSlip.awayTeamId = awayTeamId;

              betSlip.season = matchNotifier.sportEvent.virtualSeasonName;
              betSlip.day = matchNotifier.sportEvent.virtualDayName;

              alreadyExist
                  ? betslipNotifier.removeBet(id: uniqueId)
                  : betslipNotifier.addBet(betSlipItem: betSlip);

              // homeNotifier.setVirtualFeedId(matchNotifier.feedId);
            },
            child: Column(
              children: [
                Text(
                  widget.odd["oddField"],
                  style: theme
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.grey),
                ),
                Container(
                  key: UniqueKey(),
                  height: 50,
                  width: 55,
                  decoration: BoxDecoration(
                      color: alreadyExist
                          ? theme.highlightColor
                          : theme.cardColor),
                  child: Stack(
                    alignment: (oddMap["oddValueStatus"] ?? 0) == 1
                        ? Alignment.topCenter
                        : Alignment.bottomCenter,
                    fit: StackFit.loose,
                    children: [
                      Center(
                        child: (matchNotifier.sportEvent.virtualSeasonName ??
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
                      if (hasNew)
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
      return (isup == 1 ? Colors.green : Colors.red);
    }
  }
}

class BlinkingLine extends StatefulWidget {
  final Color color;
  @override
  const BlinkingLine(this.color, {Key? key}) : super(key: key);
  @override
  _BlinkingLineState createState() => _BlinkingLineState();
}

class _BlinkingLineState extends State<BlinkingLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  var count = 0;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        count += 1;
        if (count > 2) {
          setState(() {
            _animationController.stop();
            _animationController.animateTo(0.0);
          });
        } else {
          _animationController.forward(from: 0.0);
        }
      }
    });
    _animationController.forward(from: 0.0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return FadeTransition(
        opacity: _animationController,
        child: Container(
          color: widget.color,
          height: 2,
          width: double.infinity,
        ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class OverUnderBet extends StatefulWidget {
  final Map<String, dynamic> eventOdds;
  @override
  const OverUnderBet(this.eventOdds, {Key? key}) : super(key: key);
  @override
  _OverUnderBetState createState() => _OverUnderBetState();
}

class _OverUnderBetState extends State<OverUnderBet> {
  @override
  Widget build(BuildContext context) {
     final themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);
    bool isDarkTheme = (themeNotifier.getTheme() == AppThemes().darkTheme);
    ThemeData theme=isDarkTheme?AppThemes().darkTheme:AppThemes().lightTheme;
    final values = widget.eventOdds.values.toList();
    // if (values.length < 2) {
    //   return Container();
    // }
    final homeTeam = values.firstWhereOrNull(
        (element) => element["oddField"]?.toLowerCase() == 'u');

    final awayTeam = values.firstWhereOrNull(
        (element) => element["oddField"]?.toLowerCase() == 'o');

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          awayTeam != null
              ? OddBox(
                  awayTeam,
                )
              : Container(
                  key: UniqueKey(),
                  height: 50,
                  width: 55,
                  decoration:
                      BoxDecoration(color: theme.primaryColor),
                  child: const Icon(Icons.lock)),
          const SizedBox(
            width: 4,
          ),
          homeTeam != null
              ? OddBox(
                  homeTeam,
                )
              : Container(
                  key: UniqueKey(),
                  height: 50,
                  width: 55,
                  decoration:
                      BoxDecoration(color: theme.primaryColor),
                  child: const Icon(Icons.lock)),
        ]);
  }
}
