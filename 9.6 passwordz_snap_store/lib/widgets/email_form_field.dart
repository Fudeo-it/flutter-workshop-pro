import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmailFormField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final bool enabled;
  final bool cancellable;
  final GestureTapCallback? onCopied;

  const EmailFormField(
    this.label, {
    Key? key,
    this.controller,
    this.focusNode,
    this.validator,
    this.onFieldSubmitted,
    this.textInputAction,
    this.enabled = true,
    this.cancellable = false,
    this.onCopied,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextFormField(
        enabled: enabled,
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: label,
          prefixIcon: const Icon(
            FontAwesomeIcons.envelope,
            size: 18.0,
          ),
          suffixIcon: cancellable || onCopied != null
              ? Container(
                  width: 90,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (onCopied != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: onCopied,
                            child: const Icon(
                              FontAwesomeIcons.clipboard,
                              size: 18.0,
                            ),
                          ),
                        ),
                      if (cancellable)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              controller?.clear();
                            },
                            child: const Icon(
                              FontAwesomeIcons.xmark,
                              size: 18.0,
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              : null,
        ),
        validator: validator,
        onFieldSubmitted: onFieldSubmitted,
        textInputAction: textInputAction,
      );
}
