import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frutter/common/utils/theme/custom_themes.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog(
      {Key? key,
      required this.title,
      required this.content,
      this.padding,
      this.titleColor,
      this.titleBackground})
      : super(key: key);
  final Widget content;
  final EdgeInsetsGeometry? padding;
  final String title;
  final Color? titleColor;
  final Color? titleBackground;

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              color: widget.titleBackground,
              child: Row(
                children: [
                  const SizedBox(width: 40),
                  Expanded(
                      child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineLarge,
                  )),
                  SizedBox(
                      width: 40,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(FontAwesomeIcons.xmark),
                      )),
                ],
              ),
            ),
            const Divider(thickness: 1, height: 1, endIndent: 10, indent: 10),
            Flexible(
                child: Container(
                    padding: widget.padding ?? const EdgeInsets.all(16),
                    child: widget.content)),
          ])),
    );
  }
}
