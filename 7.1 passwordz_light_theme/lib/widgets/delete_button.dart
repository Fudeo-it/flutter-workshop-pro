import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final GestureTapCallback? onPressed;

  const DeleteButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.delete),
      );
}
