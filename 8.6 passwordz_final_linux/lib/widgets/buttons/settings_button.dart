import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final GestureTapCallback? onPressed;

  const SettingsButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.settings),
      );
}
