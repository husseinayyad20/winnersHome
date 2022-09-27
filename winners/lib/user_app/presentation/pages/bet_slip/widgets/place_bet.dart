
import 'package:winners/user_app/core/constants/extensions/widget_extensions.dart';
import 'package:winners/user_app/core/constants/strings.dart';
import 'package:winners/user_app/core/constants/theme.dart';
import 'package:winners/user_app/core/widgets/button/rounded_button.dart';
import 'package:winners/user_app/core/widgets/error_dialog/custom_dialog.dart';
import 'package:winners/user_app/core/widgets/error_dialog/custom_dialog_props.dart';

import 'package:winners/user_app/data/models/bet_slip_configuration/bet_slip_constants.dart';
import 'package:winners/user_app/data/models/bet_slip_configuration/place_bet_function.dart';


import 'package:winners/user_app/presentation/notifiers/bet_slip/bet_slip_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/bet_slip/place_bet_functions_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/general_configuration_notifier.dart';

import 'package:winners/user_app/presentation/notifiers/theme_notifier.dart';
import 'package:winners/user_app/presentation/pages/info_page/info_page.dart';
import 'package:winners/user_app/presentation/resources/color_manager.dart';
import 'package:winners/user_app/presentation/resources/fonts_manager.dart';
import 'package:winners/user_app/presentation/resources/styles_manager.dart';
import 'package:winners/user_app/presentation/resources/values_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PlaceBet extends StatefulWidget {
  const PlaceBet({Key? key, required this.isMultiple}) : super(key: key);
  final bool isMultiple;

  @override
  _PlaceBetState createState() => _PlaceBetState();
}

class _PlaceBetState extends State<PlaceBet> {
  late ThemeNotifier _themeNotifier;
  late double _width;
  late BetSlipNotifier _betSlipNotifier;
  late PlaceBetSlipFunctionsNotifier _betSlipFunctionsNotifier;
  late bool _isDarkTheme;
  late GeneralConfigurationNotifier _generalConfigurationNotifier;
  late BetSlipConstants _betSlipConstants;

  late double _minOddsMultiplier, _maxOddsMultiplier;
  late int _betSlipChangeLD, _betSlipChangeUSD;
  final _controller = TextEditingController();

  @override
  void initState() {
    _betSlipNotifier = Provider.of<BetSlipNotifier>(context, listen: false);
    _betSlipFunctionsNotifier =
        Provider.of<PlaceBetSlipFunctionsNotifier>(context, listen: false);
    _generalConfigurationNotifier =
        Provider.of<GeneralConfigurationNotifier>(context, listen: false);

    _betSlipConstants = _generalConfigurationNotifier
        .betSlipConfigurationEntity.data!.betSlipConstants!;
    _betSlipFunctionsNotifier.initBetFunctions(_generalConfigurationNotifier
        .betSlipConfigurationEntity.data!.placeBetFunctions!);
    _minOddsMultiplier = _generalConfigurationNotifier
        .betSlipConfigurationEntity.data!.betSlipConstants!.minOddsMultiplier!;
    _maxOddsMultiplier = _generalConfigurationNotifier
        .betSlipConfigurationEntity.data!.betSlipConstants!.maxOddsMultiplier!
        .toDouble();
    _betSlipChangeLD = _generalConfigurationNotifier
        .betSlipConfigurationEntity.data!.betSlipConstants!.betSlipChangeLD!;
    _betSlipChangeUSD = _generalConfigurationNotifier
        .betSlipConfigurationEntity.data!.betSlipConstants!.betSlipChangeUSD!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);
    _isDarkTheme = (_themeNotifier.getTheme() == AppThemes().darkTheme);
    NumberFormat formatter = NumberFormat.decimalPattern('en_us');
    return SizedBox(
      //color: _themeNotifier.getTheme().primaryColorDark,
      width: _width,
      child: Consumer<BetSlipNotifier>(
        builder: (context, betSlipProvider, child) {
          return betSlipProvider.showData
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _messages(betSlipProvider),
                    InkWell(
                      onTap: betSlipProvider.onClearAllTab,
                      child: Text(Strings.clearAll,
                              style: GoogleFonts.poppins(
                                  textStyle: getRegularStyle(
                                color: _isDarkTheme
                                    ? ColorManager.white
                                    : const Color(0xFF525C6E),
                              )))
                          .padding(
                              padding: const EdgeInsets.all(AppPadding.p8)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "${Strings.stake} ( ${betSlipProvider.betItems.length} Bets)",
                            style: GoogleFonts.poppins(
                                textStyle: getSemiBoldStyle(
                                    color: _isDarkTheme
                                        ? ColorManager.white
                                        : ColorManager.black,
                                    fontSize: FontSize.s12))),
                        _numberAction()
                      ],
                    ).padding(padding: const EdgeInsets.all(AppPadding.p12)),
                    if (widget.isMultiple)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Strings.totalOdds,
                              style: GoogleFonts.poppins(
                                  textStyle: getBoldStyle(
                                      color: _isDarkTheme
                                          ? ColorManager.white
                                          : ColorManager.black,
                                      fontSize: FontSize.s12))),
                          Text(betSlipProvider.totalOdd.toStringAsFixed(2),
                              style: GoogleFonts.poppins(
                                  textStyle: getMediumStyle(
                                      color: _isDarkTheme
                                          ? ColorManager.white
                                          : ColorManager.black,
                                      fontSize: FontSize.s14)))
                        ],
                      ).padding(padding: const EdgeInsets.all(AppPadding.p12)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Strings.possibleWinnings,
                            style: GoogleFonts.poppins(
                                textStyle: getSemiBoldStyle(
                                    color: _isDarkTheme
                                        ? ColorManager.white
                                        : ColorManager.black,
                                    fontSize: FontSize.s12))),
                        Row(
                          children: [
                            Text(betSlipProvider.currency,
                                style: GoogleFonts.poppins(
                                    textStyle: getMediumStyle(
                                        color: _isDarkTheme
                                            ? ColorManager.white
                                            : ColorManager.black,
                                        fontSize: FontSize.s12))),
                            const SizedBox(
                              width: AppSize.s4,
                            ),
                            Text(
                                formatter.format(double.parse(
                                    _getPossibleWinnings(betSlipProvider))),
                                style: getMediumStyle(
                                    color: _isDarkTheme
                                        ? ColorManager.white
                                        : ColorManager.black,
                                    fontSize: FontSize.s18)),
                          ],
                        ),
                      ],
                    ).padding(padding: const EdgeInsets.all(AppPadding.p12)),
                    _placeBetFunction(),
                    _termsAndConditions()
                  ],
                )
              : const Text("");
        },
      ),
    );
  }

  Widget _messages(BetSlipNotifier provider) {
    List<String> errors = provider.errorOutput(widget.isMultiple);
    return Container(
        color: _isDarkTheme
            ? ColorManager.darkPrimary
            : ColorManager.primaryColorLight,
        width: _width,
        margin: const EdgeInsets.all(AppMargin.m12),
        child: ListView.builder(
          itemCount: errors.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => Row(
            children: [
              CircleAvatar(
                backgroundColor:
                    errors[index].toString() == Strings.someBetsValuesChanged
                        ? Colors.orangeAccent
                        : ColorManager.red,
                radius: 12,
                child: Text(
                  "i",
                  style: TextStyle(color: ColorManager.white),
                ),
              ),
              const SizedBox(
                width: AppSize.s8,
              ),
              Flexible(
                child: Text(errors[index].toString(),
                    style: TextStyle(
                        color: _isDarkTheme
                            ? ColorManager.white
                            : ColorManager.black,
                        fontSize: FontSize.s12)),
              )
            ],
          ).center().padding(padding: const EdgeInsets.all(AppPadding.p8)),
        ));
  }

  Widget _numberAction() {
    return Container(
      width: AppSize.s180,
      height: AppSize.s50,
      decoration: BoxDecoration(
          color: const Color(0xFFDEE2E7),
          borderRadius: BorderRadius.circular(AppSize.s8)),
      child: Consumer<BetSlipNotifier>(
        builder: (context, provider, child) {
          _controller
            ..text = provider.hideStakeAmount
                ? "-"
                : widget.isMultiple
                    ? provider.stakeAmountForMultiple.toString()
                    : provider.stakeAmount.toString()
            ..selection = TextSelection.collapsed(
                offset: provider.hideStakeAmount
                    ? "-".length
                    : widget.isMultiple
                        ? provider.stakeAmountForMultiple.toString().length
                        : provider.stakeAmount.toString().length);
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  widget.isMultiple
                      ? provider.setStakeAmountFroMultiple(
                          provider.stakeAmountForMultiple == 0 ||
                                  provider.stakeAmountForMultiple -
                                          (_betSlipNotifier.currency == "LD"
                                              ? _betSlipChangeLD
                                              : _betSlipChangeUSD) <=
                                      0
                              ? provider.stakeAmountForMultiple
                              : provider.stakeAmountForMultiple -
                                  (_betSlipNotifier.currency == "LD"
                                      ? _betSlipChangeLD
                                      : _betSlipChangeUSD))
                      : provider.setStakeAmount(provider.stakeAmount == 0 ||
                              provider.stakeAmount -
                                      (_betSlipNotifier.currency == "LD"
                                          ? _betSlipChangeLD
                                          : _betSlipChangeUSD) <=
                                  0
                          ? provider.stakeAmount
                          : provider.stakeAmount -
                              (_betSlipNotifier.currency == "LD"
                                  ? _betSlipChangeLD
                                  : _betSlipChangeUSD));
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
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                textAlign: TextAlign.center,
                controller: _controller,
                onChanged: (value) {
                  widget.isMultiple
                      ? provider.setStakeAmountFroMultiple(int.parse(value))
                      : provider.setStakeAmount(int.parse(value));
                },
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                // controller: TextEditingController(
                //   text: ,
                // ),
                style: GoogleFonts.poppins(
                    textStyle: getBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s15)),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              )),
              InkWell(
                onTap: () {
                  widget.isMultiple
                      ? provider.setStakeAmountFroMultiple(
                          provider.stakeAmountForMultiple + 10)
                      : provider.setStakeAmount(provider.stakeAmount +
                          (_betSlipNotifier.currency == "LD"
                              ? _betSlipChangeLD
                              : _betSlipChangeUSD));
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
          );
        },
      ),
    );
  }

  Widget _placeBetFunction() {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: Strings.placeBetFunction,
        labelStyle: _themeNotifier.getTheme().textTheme.headline2,
        border: const OutlineInputBorder(),
      ),
      child: Consumer<PlaceBetSlipFunctionsNotifier>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: _generalConfigurationNotifier
                .betSlipConfigurationEntity.data!.placeBetFunctions!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  provider.onBetSelected(index);
                },
                child: _radioItem(provider.betFunctions[index],
                    provider.betFunctionsActive[index]),
              );
            },
          );
        },
      ),
    ).padding(padding: const EdgeInsets.all(AppPadding.p12));
  }

  Widget _radioItem(PlaceBetFunction item, bool betFunctionsActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: [
            Container(
                width: AppSize.s22,
                height: AppSize.s22,
                decoration: BoxDecoration(
                    color: betFunctionsActive
                        ? _themeNotifier.getTheme().colorScheme.secondary
                        : _isDarkTheme
                            ? ColorManager.white
                            : ColorManager.gray,
                    shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p6),
                  child: Container(
                    width: AppSize.s16,
                    height: AppSize.s16,
                    decoration: BoxDecoration(
                        color: _themeNotifier.getTheme().primaryColor,
                        shape: BoxShape.circle),
                  ),
                )),
            const SizedBox(
              width: AppSize.s20,
            ),
            Text(
              item.option!,
              style: betFunctionsActive
                  ? _themeNotifier.getTheme().textTheme.headline5
                  : _themeNotifier.getTheme().textTheme.headline6,
            ),
          ],
        ).padding(padding: const EdgeInsets.all(AppPadding.p8)),
        const SizedBox(
          width: AppSize.s20,
        ),
        Flexible(
          child: Text(
            item.optionText!,
            style: const TextStyle(
                color: Color(0xFF909090), fontSize: FontSize.s12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }

  Widget _termsAndConditions() {
    return Consumer<BetSlipNotifier>(
      builder: (context, provider, child) {
        return Column(
          children: [
            provider.isPlaceBetLoading
                ? const CircularProgressIndicator().center()
                :  RoundedButton(
                          text: Strings.placeBet,
                          isButtonDisabled:
                              provider.isButtonDisabled(widget.isMultiple),
                          onPressed: () {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                             _placeBetAction(
                                      provider: provider,
                                      memberId: "",
                                      token: "");
                            //  if (widget.isMultiple &&
                            //       authProvider
                            //               .user!
                            //               .member!
                            //               .memberBalances![
                            //                   provider.currency == "LD" ? 0 : 1]
                            //               .balance! <
                            //           provider.stakeAmountForMultiple) {
                            //     var baseDialog = BaseAlertDialog(
                            //       title: Strings.noEnoughMoney,
                            //       content: Strings.noEnoughMoneyMsg,
                            //       yesOnPressed: () {
                            //         Navigator.of(context)
                            //             .push(MaterialPageRoute(
                            //               builder: (context) =>
                            //                   const DepositsPage(),
                            //             ))
                            //             .then((value) =>
                            //                 Navigator.of(context).pop());
                            //       },
                            //       yes: Strings.deposit,
                            //       no: Strings.gotIt,
                            //       noOnPressed: () {
                            //         Navigator.of(context).pop();
                            //       },
                            //     );
                            //     showDialog(
                            //         context: context,
                            //         builder: (BuildContext context) =>
                            //             baseDialog);
                            //   } else {
                            //     if (widget.isMultiple) {
                            //       if (provider.stakeAmountForMultiple >
                            //               _maxOddsMultiplier ||
                            //           provider.stakeAmountForMultiple <
                            //               _minOddsMultiplier) {
                            //         var baseDialog = BaseAlertDialog(
                            //           title: Strings.errorMessage,
                            //           content: provider.stakeAmountForMultiple >
                            //                   _maxOddsMultiplier
                            //               ? Strings.maxOdds +
                            //                   " $_maxOddsMultiplier"
                            //               : Strings.minimumOdds +
                            //                   " $_minOddsMultiplier",
                            //           yesOnPressed: () {
                            //             Navigator.of(context).pop();
                            //           },
                            //           yes: Strings.ok,
                            //         );
                            //         showDialog(
                            //             context: context,
                            //             builder: (BuildContext context) =>
                            //                 baseDialog);
                            //       } else {
                            //         _placeBetAction(
                            //             provider: provider,
                            //             memberId: authProvider
                            //                 .user!.member!.memberId
                            //                 .toString(),
                            //             token: authProvider.user!.member!.token);
                            //       }
                            //     } else {
                            //       _placeBetAction(
                            //           provider: provider,
                            //           memberId: authProvider
                            //               .user!.member!.memberId
                            //               .toString(),
                            //           token: authProvider.user!.member!.token);
                            //     }
                            //   }
                          
                    },
                  ),
            provider.isCreateBetCodeLoading
                ? const CircularProgressIndicator().center()
                : RoundedButton(
                    text: Strings.getBetCode,
                    isButtonDisabled:
                        provider.isButtonDisabled(widget.isMultiple),
                    onPressed: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      _getBetCodeAction(provider);
                    },
                    color:
                        _themeNotifier.getTheme().appBarTheme.backgroundColor,
                    textColor: provider.isButtonDisabled(widget.isMultiple)
                        ? Colors.transparent
                        : _isDarkTheme
                            ? ColorManager.white
                            : ColorManager.gray,
                  ),
            InkWell(
              onTap: () async {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      const InfoPage(title: 'terms-and-conditions'),
                ));
              },
              child: RichText(
                  softWrap: true,
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                      text: Strings
                          .byPlacingABetYouAutomaticallyAcceptTheMostRecentVersionOfThe,
                      style: GoogleFonts.poppins(
                          textStyle: getMediumStyle(
                              color: _isDarkTheme
                                  ? ColorManager.white
                                  : ColorManager.black,
                              fontSize: FontSize.s12)),
                    ),
                    TextSpan(
                      text: Strings.termsAndConditions,
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: _isDarkTheme
                              ? ColorManager.white
                              : ColorManager.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ])).padding(padding: const EdgeInsets.all(AppPadding.p12)),
            )
          ],
        );
      },
    );
  }

  String _getPossibleWinnings(
    BetSlipNotifier betSlipProvider,
  ) {
    double multipleNumber = betSlipProvider.stakePossibleWinningsForMultiple;
    double number = betSlipProvider.stakePossibleWinnings;

    if (widget.isMultiple) {
      if (_betSlipNotifier.currency == "LD") {
        if (multipleNumber % 5 == 0) {
          // no need to round off
          return multipleNumber.toInt().toString();
        } else {
          multipleNumber = multipleNumber - multipleNumber % 5;
          return multipleNumber.toInt().toString();
        }
      } else {
        return multipleNumber.toStringAsFixed(2);
      }
    } else {
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

  void _placeBetAction(
      {required BetSlipNotifier provider,
      required String token,
      required String memberId}) {
    if (widget.isMultiple) {
      provider
          .executePlaceBetMultiple(token: token, memberId: memberId)
          .whenComplete(() {
        if (provider.placeBet != null) {
          var baseDialog = CustomDialog(
            props: CustomDialogProps(
                buttonTitle: Strings.ok,
                message: provider.placeBet!.message,
                title: Strings.placeBet,
                firstTap: () {
                  Navigator.of(context).pop();
                  if (provider.placeBet!.success!) {
                    provider.onClearAllTab();
                  }
                }),
          );
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) => baseDialog);
        }
      });
    } else {
      provider
          .executePlaceBetSingle(memberId: memberId, token: token)
          .then((value) {
        if (provider.placeBet != null &&
            (!provider.hasErrorOnPlaceBetSingle &&
                provider.placeBet!.success!)) {
          var baseDialog = CustomDialog(
            props: CustomDialogProps(title:Strings.placeBet,
            buttonTitle: Strings.ok,
            firstTap: (){
                if (!provider.hasErrorOnPlaceBetSingle) {
                provider.onClearAllTab();
              }

              Navigator.of(context).pop();
            }
             ),
         
          );

          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) => baseDialog);
        } else {
          if (provider.placeBet != null && (!provider.placeBet!.success!)) {
            var baseDialog = CustomDialog(
              props: CustomDialogProps(buttonTitle: Strings.ok,
              title: Strings.placeBet,
              message: provider.placeBet!.message!,
              firstTap: (() {
                Navigator.of(context).pop();
              })
              ),
           
            );

            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) => baseDialog);
          }
        }
      });
    }
  }

  void _getBetCodeAction(BetSlipNotifier provider) {
    _betSlipNotifier.executeCreateBetCode().whenComplete(() {
      if (provider.betCodeEntity!.success!) {

        var baseDialog = CustomDialog(props: CustomDialogProps(
            title: Strings.theBetCodeIs,
            message: provider.betCodeEntity!.data!.code!.toString(),
            firstTap: () {
              Clipboard.setData(ClipboardData(
                text: provider.betCodeEntity!.data!.code!.toString(),
              )).whenComplete(() => Navigator.of(context).pop());
            },
            secTap: () {
              Navigator.of(context).pop();
            },
            buttonTitle: Strings.copyCode,
            secbuttonTitle: Strings.close));
        showDialog(
            context: context, builder: (BuildContext context) => baseDialog);
      } else {
        var baseDialog =  CustomDialog(props: CustomDialogProps(
          title: Strings.getBetCode,
          message: provider.betCodeEntity!.message!,
          firstTap: () {},
          buttonTitle: Strings.ok,
        ));
        showDialog(
            context: context, builder: (BuildContext context) => baseDialog);
      }
    });
  }
}
