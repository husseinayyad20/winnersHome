
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:winners/user_app/core/constants/assets.dart';
import 'package:winners/user_app/core/widgets/error_dialog/custom_dialog_props.dart';
import 'package:winners/user_app/presentation/resources/values_manager.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({
    required this.props,
    Key? key,
  }) : super(key: key);
  final CustomDialogProps props;

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return _buildAlert(context);
  }

  AlertDialog _buildAlert(BuildContext context) {
    bool withoutButtons = widget.props.firstTap == null ||
        widget.props.buttonTitle == "" ||
        widget.props.secbuttonTitle == null ||
        widget.props.secbuttonTitle == "";
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      backgroundColor: Colors.white,
      title: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: const Icon(Icons.close),
            onTap: widget.props.firstTap,
          ),
        ),
      ),
      content: SizedBox(
        height: AppSize.s140,
        child: Column(
          children: [
            widget.props.isSuccess == true
                ? SvgPicture.asset(
                    Assets.done,
                    width: 30,
                  )
                : widget.props.isSuccess == false
                    ? const Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 38,
                      )
                    : const SizedBox(),
            const SizedBox(
              height: AppSize.s12,
            ),
            Text(
              widget.props.title ?? '',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(
              height: AppSize.s18,
            ),
            Text(
              widget.props.message ?? '',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.end,
      actions: [
        Center(
          child: Column(
            children: [
              withoutButtons
                  ? const SizedBox()
                  : Divider(
                      color: Colors.grey.shade300,
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  widget.props.secbuttonTitle == null ||
                          widget.props.secbuttonTitle == ""
                      ? const SizedBox()
                      : Expanded(
                          child: TextButton(
                            onPressed: widget.props.secTap,
                            child: Text(
                              widget.props.secbuttonTitle ?? "",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                        ),
                  withoutButtons
                      ? const SizedBox()
                      : const SizedBox(
                          height: 50,
                          child: VerticalDivider(
                            thickness: 1,
                          ),
                        ),
                  widget.props.firstTap == null ||
                          widget.props.buttonTitle == ""
                      ? const SizedBox()
                      : Expanded(
                          child: Align(
                            alignment: widget.props.secTap == null
                                ? Alignment.centerRight
                                : Alignment.center,
                            child: TextButton(
                              onPressed: widget.props.firstTap,
                              child: Text(
                                widget.props.buttonTitle ?? '',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
