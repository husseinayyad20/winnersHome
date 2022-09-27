
import 'package:winners/user_app/core/constants/extensions/widget_extensions.dart';
import 'package:winners/user_app/core/constants/strings.dart';
import 'package:winners/user_app/core/widgets/button/drop_down_select/drop_down_select.dart';
import 'package:winners/user_app/core/widgets/button/rounded_button.dart';
import 'package:winners/user_app/core/widgets/error_dialog/custom_dialog.dart';
import 'package:winners/user_app/core/widgets/error_dialog/custom_dialog_props.dart';


import 'package:winners/user_app/presentation/notifiers/bet_slip/bet_slip_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/general_configuration_notifier.dart';

import 'package:winners/user_app/presentation/notifiers/theme_notifier.dart';
import 'package:winners/user_app/presentation/pages/app_bar/app_bar.dart';
import 'package:winners/user_app/presentation/pages/bet_slip/widgets/bet_slip_item.dart';
import 'package:winners/user_app/presentation/pages/bet_slip/widgets/place_bet.dart';
import 'package:winners/user_app/presentation/resources/color_manager.dart';
import 'package:winners/user_app/presentation/resources/fonts_manager.dart';
import 'package:winners/user_app/presentation/resources/styles_manager.dart';
import 'package:winners/user_app/presentation/resources/values_manager.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import '../../../core/constants/theme.dart';

class BetSlipPage extends StatefulWidget {
  const BetSlipPage({Key? key}) : super(key: key);

  @override
  _BetSlipPageState createState() => _BetSlipPageState();
}

class _BetSlipPageState extends State<BetSlipPage>
    with AutomaticKeepAliveClientMixin<BetSlipPage>, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  late ThemeNotifier _themeNotifier;
  late BetSlipNotifier _betSlipNotifier;

  late GeneralConfigurationNotifier _generalConfigurationNotifier;

  late double _width;

  late TabController _tabController;
  late bool _isDarkTheme;
  FocusNode currentFocus = FocusNode();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
  

    _betSlipNotifier = Provider.of<BetSlipNotifier>(context, listen: false);
    _betSlipNotifier.executeGetSportIcons();
    _generalConfigurationNotifier =
        Provider.of<GeneralConfigurationNotifier>(context, listen: false);

    _generalConfigurationNotifier.executeGetSportTypeIcon();
    _generalConfigurationNotifier.executeGetCurrencies();
    _generalConfigurationNotifier
        .executeGetBetSlipConfiguration()
        .whenComplete(() {
      _betSlipNotifier.setBetSlipConfigurationIsLoad(true);

      _betSlipNotifier.setBetSlipConfigurationEntity(
          _generalConfigurationNotifier.betSlipConfigurationEntity);
    }).catchError((error) {
      _betSlipNotifier.setBetSlipConfigurationIsLoad(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    _width = MediaQuery.of(context).size.width;
    _themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);

    _isDarkTheme = (_themeNotifier.getTheme() == AppThemes().darkTheme);

    return Scaffold(
      backgroundColor: _isDarkTheme
          ? const Color(0xFF14213C)
          : _themeNotifier.getTheme().primaryColor,
      appBar: WinnersAppBar(
        title: Strings.betSlip,
       
        action: SizedBox(
          width: AppSize.s140,
          child: Consumer<GeneralConfigurationNotifier>(
            builder: (context, provider, child) {
              return provider.currency != null
                  ? DropDownSelect<String>(
                      items: provider.currency!.data!
                          .map((e) => e.currencySymbol!)
                          .toList(),
                      onChanged: (value) {
                        _betSlipNotifier.setCurrency(value!);
                        if (_betSlipNotifier.betSlip != null) {
                          _initBetSlipItemData(_betSlipNotifier.betItems);
                        }
                      },
                      hintText: provider.currency!.data!.first.currencySymbol!,
                    )
                  : const Text("");
            },
          ),
        ),
        
      ),
      body: GestureDetector(
        onTap: () {
          // FocusScopeNode currentFocus = FocusScope.of(context);

          if (currentFocus.canRequestFocus) {
            currentFocus.unfocus();
          }
        },
        child: NotificationListener<ScrollNotification>(
        
          child: Consumer<BetSlipNotifier>(
            builder: (context, provider, child) {
              return provider.betSlipConfigurationIsLoad == null
                  ? const CircularProgressIndicator().center()
                  : !provider.betSlipConfigurationIsLoad!
                      ? const Text("")
                      : SingleChildScrollView(
                         
                          child: Column(
                            children: [
                              const SizedBox(
                                height: AppSize.s30,
                              ),
                              _tabsHeader(),
                              const SizedBox(
                                height: AppSize.s15,
                              ),
                              _loadBetCode()
                            ],
                          ),
                        );
            },
          ),
        ),
      ),
    );
  }

  Widget _tabsHeader() {
    return Consumer<BetSlipNotifier>(
      builder: (context, provider, child) {
        return Column(
          children: [
            Container(
              color: _isDarkTheme
                  ? ColorManager.tabBarDarkBackground
                  : _themeNotifier.getTheme().primaryColorLight,
              width: _width,
              child: IgnorePointer(
                ignoring: !provider.isBetSlipLoaded,
                child: TabBar(
                  controller: _tabController,
                  onTap: (int index) {
                    provider.onTab(index);
                    // change  StakeAmount for multiple to default value
                    if (index == 1) {
                      _changeStakeAmount();
                    }
                  },
                  unselectedLabelColor: !provider.isBetSlipLoaded
                      ? const Color(0xFF828C9F)
                      : _isDarkTheme
                          ? ColorManager.white
                          : ColorManager.darkPrimaryColorDark,
                  unselectedLabelStyle: getBoldStyle(
                      color: !provider.isBetSlipLoaded
                          ? const Color(0xFF828C9F)
                          : _isDarkTheme
                              ? ColorManager.white
                              : ColorManager.darkPrimaryColorDark,
                      fontSize: FontSize.s14),
                  labelColor: !provider.isBetSlipLoaded
                      ? const Color(0xFF828C9F)
                      : _isDarkTheme
                          ? ColorManager.white
                          : ColorManager.darkPrimaryColorDark.withOpacity(0.9),
                  labelStyle: getBoldStyle(
                    fontSize: FontSize.s14,
                    color: !provider.isBetSlipLoaded
                        ? const Color(0xFF828C9F)
                        : _isDarkTheme
                            ? ColorManager.white
                            : ColorManager.darkPrimaryColorDark,
                  ),
                  padding: const EdgeInsets.only(
                      right: AppPadding.p60, left: AppPadding.p60),
                  indicatorColor: !provider.isBetSlipLoaded
                      ? Colors.transparent
                      : _isDarkTheme
                          ? ColorManager.white
                          : ColorManager.darkPrimaryColorDark,
                  tabs: const [
                    Tab(
                      text: Strings.single,
                    ),
                    Tab(
                      text: Strings.multiple,
                    ),
                  ],
                ),
              ),
            ),
            provider.betItems.isNotEmpty
                ? Column(
                    children: [
                      provider.isBetSlipLoaded
                          ? provider.betItems.isNotEmpty
                              ? Column(
                                  children: [
                                    provider.index == 0
                                        ? _single(provider.betItems)
                                        : _multiple(provider.betItems),
                                    PlaceBet(isMultiple: provider.index != 0)
                                  ],
                                )
                              : const Text("")
                          : const CircularProgressIndicator().center().padding(
                              padding: const EdgeInsets.all(AppPadding.p12)),
                    ],
                  )
                : Container(
                    decoration: BoxDecoration(
                        color: _isDarkTheme
                            ? const Color(0xFF14213C)
                            : ColorManager.white,
                        border: Border.all(
                            color:
                                _themeNotifier.getTheme().primaryColorLight)),
                    width: _width,
                    child: Padding(
                      padding: const EdgeInsets.all(AppPadding.p20),
                      child: Text(Strings.noBetSelected,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              textStyle: getRegularStyle(
                                  color: _isDarkTheme
                                      ? ColorManager.white.withOpacity(0.44)
                                      : const Color(0xFFAEB4BF),
                                  fontSize: FontSize.s15))),
                    ).center(),
                  )
          ],
        );
      },
    );
  }

  Widget _loadBetCode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: _isDarkTheme
              ? ColorManager.tabBarDarkBackground
              : _themeNotifier.getTheme().primaryColorLight,
          width: _width,
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: Text(Strings.loadBetCode,
                style: _themeNotifier.getTheme().textTheme.headline1),
          ).center(),
        ),
        Container(
            decoration: BoxDecoration(
                color:
                    _isDarkTheme ? const Color(0xFF14213C) : ColorManager.white,
                border: Border.all(
                    color: _themeNotifier.getTheme().primaryColorLight)),
            width: _width,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  margin: const EdgeInsets.only(
                    top: 16,
                    bottom: 16,
                    left: 16,
                    right: 16,
                  ),
                  decoration: BoxDecoration(
                      color: _isDarkTheme
                          ? const Color(0xFF0B1828)
                          : const Color(0xFFF5F5F9),
                      borderRadius: BorderRadius.circular(5)),
                  child: GestureDetector(
                    child: TextFormField(
                      controller: _betSlipNotifier.betCodeEditingController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      autofocus: false,
                      focusNode: currentFocus,
                      onChanged: (text) {
                        _betSlipNotifier.changeBetCodeState();
                      },
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: _isDarkTheme
                            ? ColorManager.white
                            : const Color(0xFF0B1828),
                        // Get.theme.hintColor,
                        fontSize: 12,
                      ),
                      decoration: const InputDecoration(
                        hintText: Strings.codeHere,
                        hintStyle: TextStyle(color: Color(0xFF707070)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                if (_betSlipNotifier.loadBetCodeLoading)
                  const CircularProgressIndicator().center(),
                RoundedButton(
                  text: Strings.load,
                  isButtonDisabled: false,
                  color: _betSlipNotifier.betCodeEditingController.text.isEmpty
                      ? _themeNotifier
                          .getTheme()
                          .colorScheme
                          .secondary
                          .withOpacity(0.5)
                      : null,
                  onPressed: () {
                    if (currentFocus.canRequestFocus) {
                      currentFocus.unfocus();
                    }
                    if (!_betSlipNotifier.loadBetCodeLoading &&
                        _betSlipNotifier
                            .betCodeEditingController.text.isNotEmpty) {
                      int amount = _betSlipNotifier.currency == "LD"
                          ? _generalConfigurationNotifier
                              .betSlipConfigurationEntity
                              .data!
                              .betSlipConstants!
                              .betSlipAmountLd!
                          : _generalConfigurationNotifier
                              .betSlipConfigurationEntity
                              .data!
                              .betSlipConstants!
                              .betSlipAmountUsd!;

                      _betSlipNotifier
                          .executeGetBetSlip(
                              _generalConfigurationNotifier
                                  .config!.data!.feedSr!,
                              amount)
                          .then((value) {
                        if (!_betSlipNotifier.betSlip!.success!) {
                          var baseDialog = CustomDialog(
                            props: CustomDialogProps(buttonTitle:Strings.ok,
                            message: _betSlipNotifier.betSlip!.message!,
                            
                            firstTap:  (){
                                 Navigator.of(context).pop();
                            },
                            title: Strings.errorMessage
                            ),
                          
                          );
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => baseDialog);
                        }
                      });
                    }
                  },
                )
              ],
            ))
      ],
    );
  }

  Widget _single(data) {
    return ListView.builder(
      itemBuilder: (context, index) => BetSlipItem(
        isMultiple: false,
        index: index,
      ),
      itemCount: data.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  Widget _multiple(data) {
    return ListView.builder(
      itemBuilder: (context, index) => BetSlipItem(
        isMultiple: true,
        index: index,
      ),
      itemCount: data.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  void _initBetSlipItemData(dataList) {
    int amount = _betSlipNotifier.currency == "LD"
        ? _generalConfigurationNotifier
            .betSlipConfigurationEntity.data!.betSlipConstants!.betSlipAmountLd!
        : _generalConfigurationNotifier.betSlipConfigurationEntity.data!
            .betSlipConstants!.betSlipAmountUsd!;

    _betSlipNotifier.initAmount(list: dataList, betSlipAmount: amount);
    _betSlipNotifier.initPossibleWinnings(
      betSlipAmount: amount,
    );
  }

  void _changeStakeAmount() {
    int amount = _betSlipNotifier.currency == "LD"
        ? _generalConfigurationNotifier
            .betSlipConfigurationEntity.data!.betSlipConstants!.betSlipAmountLd!
        : _generalConfigurationNotifier.betSlipConfigurationEntity.data!
            .betSlipConstants!.betSlipAmountUsd!;
    _betSlipNotifier.setStakeAmountFroMultiple(amount);
  }
}
