
import 'package:winners/user_app/core/constants/assets.dart';
import 'package:winners/user_app/core/constants/extensions/widget_extensions.dart';
import 'package:winners/user_app/core/constants/theme.dart';
import 'package:winners/user_app/presentation/notifiers/theme_notifier.dart';
import 'package:winners/user_app/presentation/resources/color_manager.dart';
import 'package:winners/user_app/presentation/resources/values_manager.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DropDownSelect<T> extends StatelessWidget {
  const DropDownSelect(
      {Key? key,
      required this.items,
      required this.hintText,
      required this.onChanged,
      this.showFlag})
      : super(key: key);
  final List<T?> items;

  final String hintText;
  final bool? showFlag;

  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) {
    ThemeNotifier _themeNotifier =
        Provider.of<ThemeNotifier>(context, listen: true);
    bool isDarkTheme = (_themeNotifier.getTheme() == AppThemes().darkTheme);
    ThemeData theme=isDarkTheme?AppThemes().darkTheme:AppThemes().lightTheme;
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: Container(
          decoration: BoxDecoration(
              color: isDarkTheme
                  ? ColorManager.darkPrimary
                  : const Color(0x00000029).withOpacity(0.1),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: DropdownButtonFormField2(
            decoration: const InputDecoration(
              //Add isDense true and zero Padding.
              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
              isDense: true,
              border: InputBorder.none,
            ),
            isExpanded: true,
            hint: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (showFlag == null || showFlag!)
                  SvgPicture.asset(Assets.liberia),
                Text(
                  hintText,
                  style: const TextStyle(),
                ),
              ],
            ),
            icon: Icon(
              Icons.keyboard_arrow_down_outlined,
              color: isDarkTheme ? ColorManager.white : ColorManager.black,
            ),
            dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: isDarkTheme
                    ? ColorManager.darkPrimary
                    : ColorManager.white),
            items: items
                .map((item) => DropdownMenuItem<T>(
                    value: item,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          width: AppSize.s8,
                        ),
                        if (showFlag == null || showFlag!)
                          Expanded(
                              child: SvgPicture.asset(
                            item.toString() == "LD"
                                ? Assets.liberia
                                : Assets.unitedStates,
                            width: AppSize.s20,
                          )),
                        Expanded(
                          child: Text(
                            item!.toString(),
                            maxLines: 1,
                            style:
                               theme.textTheme.headline1,
                          ),
                        ),
                      ],
                    )))
                .toList(),
            onChanged: onChanged,
          ).padding(
              padding: const EdgeInsets.only(
                  right: AppPadding.p4, left: AppPadding.p4))),
    );
  }
}
