import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NameFormField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final bool enabled;

  const NameFormField(
    this.label, {
    Key? key,
    this.controller,
    this.focusNode,
    this.validator,
    this.onFieldSubmitted,
    this.textInputAction,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextFormField(
        enabled: enabled,
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          hintText: label,
          prefixIcon: const Icon(
            FontAwesomeIcons.cube,
            size: 18.0,
          ),
        ),
        validator: validator,
        onFieldSubmitted: onFieldSubmitted,
        textInputAction: textInputAction,
      );
}
