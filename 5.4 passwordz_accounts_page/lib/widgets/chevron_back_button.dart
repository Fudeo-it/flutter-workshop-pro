import 'package:flutter/material.dart';

class ChevronBackButton extends StatelessWidget {
  final GestureTapCallback? onPressed;

  const ChevronBackButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.chevron_left),
      );
}
