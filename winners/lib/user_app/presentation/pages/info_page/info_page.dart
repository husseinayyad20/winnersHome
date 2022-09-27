
import 'package:winners/user_app/core/constants/extensions/widget_extensions.dart';
import 'package:winners/user_app/core/constants/theme.dart';
import 'package:winners/user_app/presentation/notifiers/home_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/theme_notifier.dart';

import 'package:winners/user_app/presentation/pages/app_bar/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late HomeNotifier _homeNotifier;
  // late WebViewController _controller;
  @override
  void initState() {
    super.initState();
    _homeNotifier = Provider.of<HomeNotifier>(context, listen: false);
    _homeNotifier.getPage(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    final homeNotifier = Provider.of<HomeNotifier>(context, listen: true);
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);
    bool _isDarkTheme = (themeNotifier == AppThemes().darkTheme);
    ThemeData theme =
        _isDarkTheme ? AppThemes().darkTheme : AppThemes().lightTheme;
    return Material(
      type: MaterialType.transparency,
      child: Theme(
        data: theme,
        child: Scaffold(
          appBar: WinnersAppBar(
            title: homeNotifier.pageEntity == null
                ? ""
                : homeNotifier.pageEntity!.pageTitle!,
                  onBack: (() {
                  Navigator.of(context).pop();
                }),
          ),
          backgroundColor: theme.primaryColorDark,
          body: homeNotifier.pageEntity == null
              ? const CircularProgressIndicator().center()
              : _view(homeNotifier, context, theme),
        ),
      ),
    );
  }

  Widget _view(
      HomeNotifier HomeNotifier, BuildContext context, ThemeData theme) {
    String htmlContent = """
${HomeNotifier.pageEntity!.pageText}
""";

    // debugPrint(htmlContent);
    return Container(
        color: theme.primaryColor,
        padding: const EdgeInsets.all(4),
        height: MediaQuery.of(context).size.height,
        // child: WebView(
        //   initialUrl: 'about:blank',
        //   javascriptMode: JavascriptMode.unrestricted,
        //   onWebViewCreated: (WebViewController webViewController) {
        //     _controller = webViewController;
        //     _loadHtmlFromAssets(getHtml(htmlContent));
        //   },
        // ),
        child: SingleChildScrollView(
          child: HtmlWidget(htmlContent,
              textStyle: const TextStyle(
                fontSize: 13,

                //color: Theme.of(context).toggleableActiveColor,
                decoration: TextDecoration.none,
              )),
        ));
  }
}
