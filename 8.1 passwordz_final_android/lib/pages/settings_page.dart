import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:passwordz/theme/cubits/theme_cubit.dart';
import 'package:passwordz/theme/models/theme.dart';
import 'package:passwordz/theme/widgets/builders/settings_tile_bloc_builder.dart';
import 'package:passwordz/widgets/bottom_sheets/selector_value_sheet.dart';
import 'package:passwordz/widgets/buttons/chevron_back_button.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: ChevronBackButton(
            onPressed: () => context.router.pop(),
          ),
          title: Text(
              AppLocalizations.of(context)?.title_settings ?? 'title_settings'),
        ),
        body: SettingsList(
          sections: [
            SettingsSection(
              title: Text(
                AppLocalizations.of(context)?.settings_app ?? 'settings_app',
              ),
              tiles: [
                SettingsTileBlocBuilder<ThemeCubit, ThemeState>(
                  builder: (context, state) => SettingsTile(
                    title: Text(AppLocalizations.of(context)?.settings_theme ??
                        'settings_theme'),
                    leading: const Icon(Icons.lightbulb),
                    value: Text(
                      state.theme.localize(context) ?? state.theme.name,
                    ),
                    onPressed: (context) => showModalBottomSheet(
                      context: context,
                      builder: (_) => SelectorValueSheet<ThemeType>(
                        title: AppLocalizations.of(context)?.settings_theme,
                        values: ThemeType.values,
                        initialValue: state.theme,
                        localizeValue: (theme) => theme.localize(context),
                        onSelectedValueChanged:
                            context.watch<ThemeCubit>().setTheme,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
