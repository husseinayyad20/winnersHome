
import 'package:winners/user_app/core/constants/theme.dart';
import 'package:winners/user_app/presentation/notifiers/theme_notifier.dart';
import 'package:winners/user_app/presentation/pages/app_bar/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';
class WebViewPage extends StatelessWidget {
  const WebViewPage({Key? key, required this.name, required this.link})
      : super(key: key);
  final String name, link;

  @override
  Widget build(BuildContext context) {
     final themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);
    bool isDarkTheme = (themeNotifier.getTheme() == AppThemes().darkTheme);
    ThemeData theme=isDarkTheme?AppThemes().darkTheme:AppThemes().lightTheme;
    return Scaffold(
      appBar: WinnersAppBar(
        title: name,
        showBackIcon: true,
        onBack: () {
          Navigator.of(context).pop();
        },
      ),
      body: WebView(
        initialUrl: link,
        backgroundColor: theme.primaryColor,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
