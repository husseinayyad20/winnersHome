import 'package:winners/user_app/core/constants/theme.dart';

import 'package:winners/user_app/presentation/notifiers/general_configuration_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/home_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/selected_match_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/theme_notifier.dart';
import 'package:winners/user_app/presentation/pages/app_bar/app_bar.dart';
import 'package:winners/user_app/presentation/pages/home/home_match_details_page.dart';
import 'package:winners/user_app/presentation/pages/virtual/virtual_matches_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VirtualMatchesPage extends StatefulWidget {
  final String title;
  const VirtualMatchesPage({Key? key, required this.title}) : super(key: key);

  @override
  State<VirtualMatchesPage> createState() => _VirtualMatchesPageState();
}

class _VirtualMatchesPageState extends State<VirtualMatchesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<HomeNotifier>(context, listen: true);
      final themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);
    bool isDarkTheme = (themeNotifier.getTheme() == AppThemes().darkTheme);
    ThemeData theme=isDarkTheme?AppThemes().darkTheme:AppThemes().lightTheme;

    bool isMatchSelected = value.virtualMatchNotifier != null;
    return Stack(
      children: [
        Scaffold(
          // backgroundColor: theme.primaryColor,
          backgroundColor: isDarkTheme
              ? theme.primaryColorLight
              : theme.primaryColor,
          appBar: _appBar(context, value),
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              // physics: const NeverScrollableScrollPhysics(),
              // shrinkWrap: true,
              children: [
                _iframeOne(context, value),
                value.virtualBetSportEventEntity?.data?.sportEvents
                            ?.isNotEmpty ??
                        false
                    ? value.loading
                        ? const Padding(
                            padding: EdgeInsets.only(top: 32.0),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : const VirtualDailyLayout()
                    : Center(
                        child: Text(
                          value.virtualErrorMessage,
                          style: GoogleFonts.poppins(
                            color: Colors.red,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
        isMatchSelected
            ? ChangeNotifierProvider(
                lazy: false,
                create: (_) {
                  return SelectedMatchNotifier(
                    value,
                    value.selectedVirtualSportEvent!,
                  );
                },
                child: HomeMatchDetailsPage(
                  matchNotifier: value.virtualMatchNotifier!,
                  isVirtual: true,
                ),
              )
            : const SizedBox()
      ],
    );
  }

  //WebViewController? _webViewController;
  InAppWebViewController? wcontroller;

  SizedBox _iframeOne(BuildContext context, HomeNotifier homeNotifier) {
    final configNotifier =
        Provider.of<GeneralConfigurationNotifier>(context, listen: false);
    String attr = homeNotifier.virtualSportType!.sportDisplayName!
        .split(' ')
        .first
        .toLowerCase();
    String _js = '''
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    </head>
    <body style="padding: 0; margin: 0;">
        <iframe width="100%" height="500" name="vf_iframe" frameborder="0" scrolling="no" class="frame-video" style="display: block;" src="${configNotifier.config!.data!.getProp(attr.toString())}"></iframe>        
        <script>
                  window.addEventListener("message", (message)=> {
                //console.log(message.data.setVfMatches.season_nr);
                if (message.data.setVfMatches)
                    window.flutter_inappwebview.callHandler('msgHandler',message.data.setVfMatches.match_day,message.data.setVfMatches.season_nr);
                else if(message.data.setVfMatches)
                    window.flutter_inappwebview.callHandler('msgHandler',message.data.setVflMatchday.match_day,message.data.setVflMatchday.season_name.replace("VFL Season ", ""));
                else if(message.data.setVblMatchday)
                    window.flutter_inappwebview.callHandler('msgHandler',message.data.setVblMatchday.match_day,message.data.setVblMatchday.season_name);
            });
        </script>
    </body>
</html>
  ''';
    return SizedBox(
        height: 425,
        child: InAppWebView(
          initialOptions: InAppWebViewGroupOptions(
            android: AndroidInAppWebViewOptions(
              domStorageEnabled: true,
              safeBrowsingEnabled: false,
              useHybridComposition: true,
              allowContentAccess: true,
              loadsImagesAutomatically: true,
              mixedContentMode:
                  AndroidMixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
            ),
          ),
          onLoadStop: (_, __) {},
          onConsoleMessage: (controller, consoleMessage) {},
          onLoadHttpError: (_, __, index, err) {},
          onWebViewCreated: (controller) async {
            wcontroller = controller;
            //wcontroller?.addWebMessageListener(WebMessageListener(jsObjectName: "",onPostMessage: ))
            controller.addJavaScriptHandler(
                handlerName: 'msgHandler',
                callback: (message) {
                  if (message[0] is int && message[1] is int) {
                    homeNotifier.setVirtualMatchDay(message[0].toString());
                    homeNotifier.setVirtualSeasonId(message[1].toString());
                    homeNotifier.invokeVirtual();
                    Future.delayed(const Duration(seconds: 3), () {
                      setState(() {});
                    });
                  }
                });
            await controller.loadData(data: _js);
          },
        ));
  }

  WinnersAppBar _appBar(BuildContext context, HomeNotifier homeNotifier) {
    return WinnersAppBar(
      title: homeNotifier.virtualSportType!.sportDisplayName!,
      onBack: () {
        homeNotifier.setShowVirtualMatches(false);
      },
    );
  }
}
