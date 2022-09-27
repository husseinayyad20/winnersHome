
import 'package:winners/user_app/presentation/notifiers/theme_notifier.dart';
import 'package:winners/user_app/presentation/resources/fonts_manager.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

/// button title [name]
/// button on press action [onPressed]
/// button width [width]
/// button color [color]
class RoundedButton extends StatefulWidget {
  const RoundedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
    this.width,
    this.isButtonDisabled,
  }) : super(key: key);
  final String text;
  final VoidCallback? onPressed;

  final Color? color, textColor;
  final double? width;
  final bool? isButtonDisabled;

  @override
  _RoundedButtonState createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  late ThemeNotifier _themeNotifier;

  @override
  Widget build(BuildContext context) {
    _themeNotifier = Provider.of<ThemeNotifier>(context, listen: true);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      width: widget.width ?? MediaQuery.of(context).size.width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              textStyle: GoogleFonts.poppins(
                  fontSize: FontSize.s15,
                  fontWeight: FontWeight.bold,
                  color: widget.textColor ?? Colors.white),

              // ignore: deprecated_member_use
              primary: widget.color ?? _themeNotifier.getTheme().accentColor,
              onPrimary: widget.textColor ?? Colors.white,
              shape: RoundedRectangleBorder(
                  side: widget.textColor != null
                      ? BorderSide(color: widget.textColor!)
                      : const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(30))),
          onPressed:
              widget.isButtonDisabled == null || !widget.isButtonDisabled!
                  ? widget.onPressed
                  : null,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              widget.text,
            ),
          )),
    );
  }
}
