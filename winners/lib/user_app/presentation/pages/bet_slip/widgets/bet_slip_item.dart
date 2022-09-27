
import 'package:winners/user_app/core/constants/app_config.dart';
import 'package:winners/user_app/core/constants/assets.dart';
import 'package:winners/user_app/core/constants/extensions/widget_extensions.dart';
import 'package:winners/user_app/core/constants/strings.dart';
import 'package:winners/user_app/core/constants/theme.dart';
import 'package:winners/user_app/core/widgets/triangle_clipper/triangle_clipper.dart';

import 'package:winners/user_app/presentation/notifiers/bet_slip/bet_slip_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/general_configuration_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/theme_notifier.dart';
import 'package:winners/user_app/presentation/resources/color_manager.dart';
import 'package:winners/user_app/presentation/resources/fonts_manager.dart';
import 'package:winners/user_app/presentation/resources/styles_manager.dart';
import 'package:winners/user_app/presentation/resources/values_manager.dart';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BetSlipItem extends StatefulWidget {
  const BetSlipItem({
    Key? key,
    required this.isMultiple,
    // required this.data,
    required this.index,
    // required this.dataList
  }) : super(key: key);
  final bool isMultiple;
  //final Data data;
  // final List<Data> dataList;
  final int index;

  @override
  _BetSlipItemState createState() => _BetSlipItemState();
}

class _BetSlipItemState extends State<BetSlipItem> {
  late ThemeNotifier _themeNotifier;
  late double _width;
  late bool _isDarkTheme;
  late BetSlipNotifier _betSlipNotifier;

  late GeneralConfigurationNotifier _generalConfigurationNotifier;

  late int amount;
  late int _betSlipChangeLD, _betSlipChangeUSD;
  final _controller = TextEditingController();

  @override
  void initState() {
    _generalConfigurationNotifier =
        Provider.of<GeneralConfigurationNotifier>(context, listen: false);
    _betSlipChangeLD = _generalConfigurationNotifier
        .betSlipConfigurationEntity.data!.betSlipConstants!.betSlipChangeLD!;
    _betSlipChangeUSD = _generalConfigurationNotifier
        .betSlipConfigurationEntity.data!.betSlipConstants!.betSlipChangeUSD!;
    _betSlipNotifier = Provider.of<BetSlipNotifier>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);

    _isDarkTheme = (_themeNotifier.getTheme() == AppThemes().darkTheme);
    return Consumer<BetSlipNotifier>(
      builder: (context, provider, child) {
        return provider.showData
            ? SizedBox(
                // decoration: BoxDecoration(
                //   color: _themeNotifier.getTheme().primaryColorDark,
                // ),
                width: _width,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: widget.isMultiple
                              ? provider
                                          .errorsMsg[widget.index]
                                              ["maxPossibleWinningForMultiple"]
                                          .isNotEmpty ||
                                      provider
                                          .errorsMsg[widget.index]
                                              ["combinedError"]
                                          .isNotEmpty ||
                                      provider
                                          .errorsMsg[widget.index]["oddChange"]
                                          .isNotEmpty
                                  ? Border.all(color: ColorManager.red)
                                  : null
                              : provider
                                          .errorsMsg[widget.index]
                                              ["maxPossibleWinning"]
                                          .isNotEmpty ||
                                      provider
                                          .errorsMsg[widget.index]["oddChange"]
                                          .isNotEmpty ||
                                      (provider
                                              .placeBetSingleErrorsMsg[
                                                  widget.index]
                                              .isNotEmpty &&
                                          !widget.isMultiple)
                                  ? Border.all(color: ColorManager.red)
                                  : null),
                      margin: const EdgeInsets.only(
                          right: AppMargin.m12,
                          left: AppMargin.m12,
                          top: AppMargin.m12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _teams(provider),
                          if (widget.isMultiple != true)
                            Column(
                              children: [
                                _numberAction(widget.index, provider),
                                _possibleWinnings(provider),
                              ],
                            ),
                          const SizedBox(
                            height: AppSize.s8,
                          ),
                          Divider(
                            color: _isDarkTheme
                                ? ColorManager.white
                                : ColorManager.gray,
                          ).padding(
                              padding: const EdgeInsets.only(
                                  left: AppPadding.p12, right: AppPadding.p12))
                        ],
                      ),
                    ),
                    if (widget.isMultiple
                        ? provider
                                .errorsMsg[widget.index]
                                    ["maxPossibleWinningForMultiple"]
                                .isNotEmpty ||
                            provider.errorsMsg[widget.index]["combinedError"]
                                .isNotEmpty ||
                            provider.errorsMsg[widget.index]["combinedError"]
                                .isNotEmpty ||
                            provider
                                .errorsMsg[widget.index]["oddChange"].isNotEmpty
                        : provider.errorsMsg[widget.index]["maxPossibleWinning"]
                                .isNotEmpty ||
                            provider.errorsMsg[widget.index]["combinedError"]
                                .isNotEmpty ||
                            (provider.placeBetSingleErrorsMsg[widget.index]
                                    .isNotEmpty &&
                                !widget.isMultiple) ||
                            provider.errorsMsg[widget.index]["oddChange"]
                                .isNotEmpty)
                      Stack(
                        children: [
                          Container(
                            color: ColorManager.red,
                            margin: const EdgeInsets.only(
                                right: AppMargin.m12,
                                left: AppMargin.m12,
                                top: AppMargin.m12),
                            child: Column(
                              children: [
                                if (widget.isMultiple &&
                                    provider
                                        .errorsMsg[widget.index]
                                            ["maxPossibleWinningForMultiple"]
                                        .isNotEmpty)
                                  Text(
                                          provider.errorsMsg[widget.index]
                                              ["maxPossibleWinningForMultiple"],
                                          style: TextStyle(
                                              color: ColorManager.white,
                                              fontSize: FontSize.s12))
                                      .center()
                                      .padding(
                                          padding: const EdgeInsets.all(
                                              AppPadding.p8)),
                                if (widget.isMultiple &&
                                    provider
                                        .errorsMsg[widget.index]
                                            ["combinedError"]
                                        .isNotEmpty)
                                  Text(
                                          provider.errorsMsg[widget.index]
                                              ["combinedError"],
                                          style: TextStyle(
                                              color: ColorManager.white,
                                              fontSize: FontSize.s12))
                                      .center()
                                      .padding(
                                          padding: const EdgeInsets.all(
                                              AppPadding.p8)),
                                if (provider
                                    .errorsMsg[widget.index]
                                        ["maxPossibleWinning"]
                                    .isNotEmpty)
                                  Text(
                                          provider.errorsMsg[widget.index]
                                              ["maxPossibleWinning"],
                                          style: TextStyle(
                                              color: ColorManager.white,
                                              fontSize: FontSize.s12))
                                      .center()
                                      .padding(
                                          padding: const EdgeInsets.all(
                                              AppPadding.p8)),
                                if (provider
                                    .errorsMsg[widget.index]["oddChange"]
                                    .isNotEmpty)
                                  Text(
                                          provider.errorsMsg[widget.index]
                                              ["oddChange"],
                                          style: TextStyle(
                                              color: ColorManager.white,
                                              fontSize: FontSize.s12))
                                      .center()
                                      .padding(
                                          padding: const EdgeInsets.all(
                                              AppPadding.p8)),
                                if (provider
                                        .placeBetSingleErrorsMsg[widget.index]
                                        .isNotEmpty &&
                                    !widget.isMultiple)
                                  Text(
                                          provider.placeBetSingleErrorsMsg[
                                              widget.index],
                                          style: TextStyle(
                                              color: ColorManager.white,
                                              fontSize: FontSize.s12))
                                      .center()
                                      .padding(
                                          padding: const EdgeInsets.all(
                                              AppPadding.p8)),
                              ],
                            ),
                          ),
                          Positioned(
                            left: 70,
                            top: 0,
                            child: Transform.rotate(
                              angle: 600,
                              child: ClipPath(
                                clipper: TriangleClipper(),
                                child: Container(
                                  height: AppSize.s14,
                                  width: AppSize.s12,
                                  color: ColorManager.red,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              )
            : const Text("");
      },
    );
  }

  Widget _numberAction(int index, BetSlipNotifier provider) {
    _controller
      ..text = provider.amount[index].toString()
      ..selection = TextSelection.collapsed(
          offset: provider.amount[index].toString().length);
    return Container(
            width: AppSize.s180,
            height: AppSize.s50,
            decoration: BoxDecoration(
                color: const Color(0xFFDEE2E7),
                borderRadius: BorderRadius.circular(AppSize.s8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    provider.onMinTab(
                        number: provider.amount[index] -
                                    (_betSlipNotifier.currency == "LD"
                                        ? _betSlipChangeLD.toDouble()
                                        : _betSlipChangeUSD.toDouble()) <=
                                0
                            ? 0
                            : (_betSlipNotifier.currency == "LD"
                                ? _betSlipChangeLD.toDouble()
                                : _betSlipChangeUSD.toDouble()),
                        index: widget.index,
                        odd: provider.betItems[index].oddValue!);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                            color: _themeNotifier.getTheme().dividerColor),
                      ),
                    ),
                    child: Icon(
                      Icons.remove,
                      size: AppSize.s16,
                      color: _themeNotifier.getTheme().dividerColor,
                    )
                        .padding(padding: const EdgeInsets.all(AppPadding.p8))
                        .center(),
                  ),
                ),
                Expanded(
                    child: TextFormField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  onChanged: (value) {
                    provider.setAmount(
                        index: index,
                        amount: int.parse(value),
                        odd: provider.betItems[index].oddValue!);
                  },
                  controller: _controller,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      textStyle: getBoldStyle(
                          color: ColorManager.black, fontSize: FontSize.s15)),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                )),
                InkWell(
                  onTap: () {
                    provider.onPlusTab(
                        number: (_betSlipNotifier.currency == "LD"
                            ? _betSlipChangeLD.toDouble()
                            : _betSlipChangeUSD.toDouble()),
                        index: widget.index,
                        odd: provider.betItems[index].oddValue!);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                            color: _themeNotifier.getTheme().dividerColor),
                      ),
                    ),
                    child: Icon(
                      Icons.add,
                      size: AppSize.s16,
                      color: _themeNotifier.getTheme().dividerColor,
                    )
                        .padding(padding: const EdgeInsets.all(AppPadding.p8))
                        .center(),
                  ),
                )
              ],
            ))
        .align(alignment: Alignment.centerRight)
        .padding(padding: const EdgeInsets.all(AppPadding.p8));
  }

  Widget _possibleWinnings(BetSlipNotifier provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          Strings.possibleWinnings,
          style: _themeNotifier.getTheme().textTheme.headline4,
        ),
        const SizedBox(
          width: AppSize.s8,
        ),
        Text(
          provider.currency,
          style: _themeNotifier.getTheme().textTheme.headline4,
        ),
        const SizedBox(
          width: AppSize.s4,
        ),
        Text(_getPossibleWinnings(provider.possibleWinnings[widget.index]),
            style: GoogleFonts.poppins(
                textStyle: getSemiBoldStyle(
                    color:
                        _isDarkTheme ? ColorManager.white : ColorManager.black,
                    fontSize: FontSize.s15))),
      ],
    ).padding(padding: const EdgeInsets.all(AppPadding.p8));
  }

  Widget _teams(BetSlipNotifier provider) {
    String base = AppConfig.baseUrl;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.network(
              provider.betSlipSportIconsEntity == null
                  ? ""
                  : provider
                      .betSlipSportIconsEntity!.data!.betSlipSportTypesIcons!
                      .where((element) =>
                          element.betSlipSportIconsId ==
                          provider.betItems[widget.index].sport!.sportId)
                      .single
                      .betSlipSportIconsName
                      .toString(),
              width: AppSize.s30,
              height: AppSize.s30,
              placeholderBuilder: (BuildContext context) => Container(
                  width: AppSize.s30,
                  height: AppSize.s30,
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: const CircularProgressIndicator()),
            ).padding(
                padding: const EdgeInsets.only(
                    right: AppPadding.p8, left: AppPadding.p8)),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: Wrap(
              runSpacing: 8,
              spacing: 0,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: AppPadding.p2),
                  child: TextButton.icon(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize: Size.zero,
                      ),
                      icon: FancyShimmerImage(
                          width: AppSize.s20,
                          height: AppSize.s20,
                          errorWidget: CircleAvatar(
                            child: Text(
                              '${provider.betItems[widget.index].homeTeamName.toString().split(' ').first.substring(0, 1)}${provider.betItems[widget.index].homeTeamName!.split(' ').last.substring(0, 1)}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeightManager.bold,
                                fontSize: FontSize.s12,
                              ),
                            ),
                          ),
                          cacheKey: "$base/api/general/image/TeamsIcon/" +
                              provider.betItems[widget.index].homeTeamId!
                                  .toString() +
                              "_s.webp",
                          imageUrl: "$base/api/general/image/TeamsIcon/" +
                              provider.betItems[widget.index].homeTeamId!
                                  .toString() +
                              "_s.webp"),
                      label: Text(provider.betItems[widget.index].homeTeamName!,
                          style: GoogleFonts.poppins(
                              textStyle: getRegularStyle(
                                  color: _isDarkTheme
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: FontSize.s14)))),
                ),
                const SizedBox(
                  width: AppSize.s8,
                ),
                TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                    child: Text("Vs",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          textStyle: getBoldStyle(
                              color: ColorManager.accentColor,
                              fontSize: FontSize.s16),
                        ))),
                const SizedBox(
                  width: AppSize.s8,
                ),
                TextButton.icon(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                    icon: FancyShimmerImage(
                        width: AppSize.s20,
                        height: AppSize.s20,
                        cacheKey: "$base/general/image/TeamsIcon/" +
                            provider.betItems[widget.index].awayTeamId!
                                .toString() +
                            "_s.webp",
                        errorWidget: CircleAvatar(
                          child: Text(
                            '${provider.betItems[widget.index].awayTeamName!.split(' ').first.substring(0, 1)}${provider.betItems[widget.index].awayTeamName!.split(' ').last.substring(0, 1)}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeightManager.bold,
                              fontSize: FontSize.s12,
                            ),
                          ),
                        ),
                        imageUrl: "$base/general/image/TeamsIcon/" +
                            provider.betItems[widget.index].awayTeamId!
                                .toString() +
                            "_s.webp"),
                    label: Text(provider.betItems[widget.index].awayTeamName!,
                        style: GoogleFonts.poppins(
                            textStyle: getRegularStyle(
                                color:
                                    _isDarkTheme ? Colors.white : Colors.black,
                                fontSize: FontSize.s14))))
              ],
            )),
            // Expanded(
            //   child: Wrap(
            //     crossAxisAlignment: WrapCrossAlignment.center,
            //     runAlignment: WrapAlignment.spaceAround,
            //     alignment: WrapAlignment.spaceBetween,
            //     children: [
            //       SizedBox(
            //         child: Row(
            //           children: [
            //             FancyShimmerImage(
            //                 width: AppSize.s20,
            //                 height: AppSize.s20,
            //                 errorWidget: CircleAvatar(
            //                   child: Text(
            //                     '${provider.betItems[widget.index].homeTeamName.toString().split(' ').first.substring(0, 1)}${provider.betItems[widget.index].homeTeamName!.split(' ').last.substring(0, 1)}',
            //                     maxLines: 1,
            //                     overflow: TextOverflow.ellipsis,
            //                     style: GoogleFonts.poppins(
            //                       fontWeight: FontWeightManager.bold,
            //                       fontSize: FontSize.s12,
            //                     ),
            //                   ),
            //                 ),
            //                 imageUrl:
            //                     "https://app-api.winners.com.lr/general/image/TeamsIcon/" +
            //                         provider.betItems[widget.index].homeTeamId!
            //                             .toString() +
            //                         "_s.webp"),
            //             // const SizedBox(
            //             //   width: AppSize.s8,
            //             // ),
            //             Text(
            //               provider.betItems[widget.index].homeTeamName!,
            //               maxLines: 2,
            //               overflow: TextOverflow.ellipsis,
            //             ),
            //             Text(
            //         "Vs",
            //         style: _themeNotifier.getTheme().textTheme.headline5,
            //         maxLines: 1,
            //       ),
            //           ],
            //         ),
            //       ),

            //       SizedBox(
            //         child: Row(
            //           children: [
            //             FancyShimmerImage(
            //                     width: AppSize.s20,
            //                     height: AppSize.s20,
            //                     errorWidget: CircleAvatar(
            //                       child: Text(
            //                         '${provider.betItems[widget.index].awayTeamName!.split(' ').first.substring(0, 1)}${provider.betItems[widget.index].awayTeamName!.split(' ').last.substring(0, 1)}',
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                         style: GoogleFonts.poppins(
            //                           fontWeight: FontWeightManager.bold,
            //                           fontSize: FontSize.s12,
            //                         ),
            //                       ),
            //                     ),
            //                     imageUrl:
            //                         "https://app-api.winners.com.lr/general/image/TeamsIcon/" +
            //                             provider.betItems[widget.index].awayTeamId!
            //                                 .toString() +
            //                             "_s.webp"),
            //                 const SizedBox(
            //                   width: AppSize.s8,
            //                 ),
            //                 Text(
            //                   provider.betItems[widget.index].awayTeamName!,
            //                 ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ).padding(padding: const EdgeInsets.all(AppPadding.p8)),
            // ),

            InkWell(
              onTap: () {
                if (widget.index == provider.betItems.length) {
                  provider.onClearAllTab();
                } else {
                  provider.onRemoveIconTab(
                      index: widget.index,
                      odd: provider.betItems[widget.index].oddValue!);
                }
              },
              child: SvgPicture.asset(
                Assets.delete,
                color:
                    _isDarkTheme ? ColorManager.white : const Color(0xFF525C6E),
              ).padding(padding: const EdgeInsets.all(AppPadding.p8)),
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.only(left: 75),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (provider.betItems[widget.index].season != null &&
                  provider.betItems[widget.index].season!.isNotEmpty)
                Text(
                        (provider.betItems[widget.index].season.toString()) +
                            " /" +
                            "Day:" +
                            provider.betItems[widget.index].day.toString(),
                        style: _themeNotifier.getTheme().textTheme.bodyText1)
                    .padding(
                        padding: const EdgeInsets.only(
                            right: AppPadding.p8, left: AppPadding.p8)),
              Text(provider.betItems[widget.index].betType!.betTypeName ?? "",
                      style: _themeNotifier.getTheme().textTheme.bodyText1)
                  .padding(
                      padding: const EdgeInsets.only(
                          right: AppPadding.p8, left: AppPadding.p8)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(provider.betItems[widget.index].oddFieldDisplayName!,
                      style: _themeNotifier.getTheme().textTheme.headline1),
                  provider.betItems[widget.index].season != null
                      ? (provider.betItems[widget.index].eventEnableBet !=
                                  true ||
                              provider.betItems[widget.index].oddEnableBet !=
                                  true ||
                              provider.betItems[widget.index].enableBet != true)
                          ? const Icon(Icons.lock)
                          : Text(
                              provider.betItems[widget.index].oddValue!
                                  .toString(),
                              style: GoogleFonts.poppins(
                                  textStyle: getSemiBoldStyle(
                                      color: _isDarkTheme
                                          ? ColorManager.white
                                          : ColorManager.black,
                                      fontSize: FontSize.s15)))
                      : (provider.betItems[widget.index].eventEnableBet !=
                                  true ||
                              provider.betItems[widget.index].oddEnableBet !=
                                  true ||
                              provider.betItems[widget.index].enableBet != true)
                          ? const Icon(Icons.lock)
                          : Text(
                              provider.betItems[widget.index].oddValue!
                                  .toString(),
                              style: GoogleFonts.poppins(
                                  textStyle: getSemiBoldStyle(
                                      color: _isDarkTheme
                                          ? ColorManager.white
                                          : ColorManager.black,
                                      fontSize: FontSize.s15)))
                ],
              ).padding(
                  padding: const EdgeInsets.only(
                      right: AppPadding.p8, left: AppPadding.p8)),
            ],
          ),
        ),
      ],
    );
  }

  String _getPossibleWinnings(double number) {
    if (_betSlipNotifier.currency == "LD") {
      if (number % 5 == 0) {
        // no need to round off
        return number.toInt().toString();
      } else {
        number = number - number % 5;
        return number.toInt().toString();
      }
    } else {
      return number.toStringAsFixed(2);
    }
  }
}
