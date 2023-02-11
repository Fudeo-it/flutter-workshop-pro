import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passwordz/theme/cubits/theme_cubit.dart';

typedef ThemeSelectorWidgetBuilder = Widget Function(
    BuildContext, ThemeMode mode);

class ThemeSelector extends StatelessWidget {
  final ThemeSelectorWidgetBuilder builder;

  const ThemeSelector({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) => builder(
          context,
          state.light
              ? ThemeMode.light
              : state.dark
                  ? ThemeMode.dark
                  : ThemeMode.system,
        ),
      );
}
