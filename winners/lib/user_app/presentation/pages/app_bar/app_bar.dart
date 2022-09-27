
import 'package:flutter/cupertino.dart';
import 'package:winners/user_app/core/constants/assets.dart';
import 'package:winners/user_app/core/constants/extensions/widget_extensions.dart';

import 'package:winners/user_app/presentation/notifiers/theme_notifier.dart';
import 'package:winners/user_app/presentation/resources/fonts_manager.dart';
import 'package:winners/user_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

/// page title [title]
/// app bar actions widget [action]
class WinnersAppBar extends StatefulWidget implements PreferredSizeWidget {
  const WinnersAppBar(
      {Key? key,
      required this.title,
      this.action,
      this.onBack,
      this.showBackIcon,
      this.height})
      : super(key: key);
  final String title;
  final Widget? action;
  final Function()? onBack;
  final bool? showBackIcon;
  final double? height;
  @override
  _WinnersAppBarState createState() => _WinnersAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height ?? 69.0);
}

class _WinnersAppBarState extends State<WinnersAppBar> {
  late ThemeNotifier _themeNotifier;

  @override
  Widget build(BuildContext context) {
    _themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);
    return AppBar(
      centerTitle: false,
      toolbarHeight: widget.height,
      title: Text(
        widget.title,
        style: GoogleFonts.poppins(
          fontSize: FontSize.s16,
          fontWeight: FontWeightManager.semiBold,
        ),
      ),
      leading: widget.showBackIcon == null || widget.showBackIcon!
          ? InkWell(
              onTap: widget.onBack ??
                  () {
                   Navigator.of(context).pop();
                  },
              child: Row(
                children: [
                  const SizedBox(
                    width: AppSize.s8,
                  ),
                  Expanded(
                    flex: 2,
                    child: SvgPicture.asset(
                      Assets.backArrow,
                      width: AppSize.s20,
                      color: _themeNotifier
                          .getTheme()
                          .appBarTheme
                          .iconTheme!
                          .color,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: VerticalDivider(
                    color:
                        _themeNotifier.getTheme().appBarTheme.iconTheme!.color,
                    thickness: 1,
                  )),
                ],
              ).padding(padding: const EdgeInsets.all(AppPadding.p8)),
            )
          : null,
      actions: widget.action != null ? [widget.action!] : null,
    );
  }
}
