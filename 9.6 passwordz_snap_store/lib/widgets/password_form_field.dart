import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PasswordFormField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final bool enabled;
  final GestureTapCallback? onCopied;

  const PasswordFormField(
    this.label, {
    Key? key,
    this.controller,
    this.focusNode,
    this.validator,
    this.onFieldSubmitted,
    this.textInputAction,
    this.enabled = true,
    this.onCopied,
  }) : super(key: key);

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) => TextFormField(
        enabled: widget.enabled,
        controller: widget.controller,
        focusNode: widget.focusNode,
        obscureText: _obscureText,
        decoration: InputDecoration(
          hintText: widget.label,
          prefixIcon: const Icon(
            FontAwesomeIcons.lock,
            size: 18.0,
          ),
          suffixIcon: Container(
            width: 90,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (widget.onCopied != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: widget.onCopied,
                      child: const Icon(
                        FontAwesomeIcons.clipboard,
                        size: 18.0,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                      _obscureText
                          ? FontAwesomeIcons.eye
                          : FontAwesomeIcons.eyeSlash,
                      size: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        textInputAction: widget.textInputAction,
      );
}
