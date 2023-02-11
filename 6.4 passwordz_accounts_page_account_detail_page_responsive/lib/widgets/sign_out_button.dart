import 'package:flutter/material.dart';

class SignOutButton extends StatelessWidget {
  final GestureTapCallback? onPressed;

  const SignOutButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.logout),
      );
}
