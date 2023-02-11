import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_password_strength/flutter_password_strength.dart';
import 'package:passwordz/misc/constants.dart';
import 'package:passwordz/models/account.dart';
import 'package:passwordz/routers/app_router.gr.dart';
import 'package:passwordz/widgets/buttons/chevron_back_button.dart';
import 'package:passwordz/widgets/buttons/delete_button.dart';
import 'package:passwordz/widgets/email_form_field.dart';
import 'package:passwordz/widgets/name_form_field.dart';
import 'package:passwordz/widgets/password_form_field.dart';
import 'package:passwordz/widgets/website_form_field.dart';

typedef AccountChangedCallback = void Function(Account account);

class AccountDetailPage extends StatefulWidget {
  final Account? account;
  final AccountChangedCallback? onAccountChanged;
  final VoidCallback? onAccountDeleted;
  final bool masterDetailNavigation;

  const AccountDetailPage(
    this.account, {
    Key? key,
    this.onAccountChanged,
    this.onAccountDeleted,
    this.masterDetailNavigation = false,
  }) : super(key: key);

  @override
  State<AccountDetailPage> createState() => _AccountDetailPageState();
}

class _AccountDetailPageState extends State<AccountDetailPage> {
  final _formKey = GlobalKey<FormState>();

  bool _formValid = false;
  String? _password;

  final _focusNodeName = FocusNode();
  final _focusNodeWebsite = FocusNode();
  final _focusNodeUsername = FocusNode();
  final _focusNodePassword = FocusNode();

  final _detailNameController = TextEditingController();
  final _detailWebsiteController = TextEditingController();
  final _detailUsernameController = TextEditingController();
  final _detailPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.account != null) {
      _updateControllerValues();
    }

    _detailPasswordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    _focusNodeName.dispose();
    _focusNodeWebsite.dispose();
    _focusNodeUsername.dispose();
    _focusNodePassword.dispose();

    _detailNameController.dispose();
    _detailWebsiteController.dispose();
    _detailUsernameController.dispose();
    _detailPasswordController.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AccountDetailPage oldWidget) {
    if (oldWidget.account != widget.account) {
      _updateControllerValues();
    }

    super.didUpdateWidget(oldWidget);
  }

  void _updateControllerValues() {
    _detailNameController.text = widget.account?.name ?? '';
    _detailWebsiteController.text = widget.account?.website ?? '';
    _detailUsernameController.text = widget.account?.username ?? '';
    _detailPasswordController.text = widget.account?.password ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: !widget.masterDetailNavigation
              ? ChevronBackButton(
                  onPressed: () => context.router.pop(),
                )
              : const SizedBox(),
          title: Text(widget.account != null
              ? AppLocalizations.of(context)?.title_edit_account ??
                  'title_edit_account'
              : AppLocalizations.of(context)?.title_add_account ??
                  'title_add_account'),
          actions: [
            if (widget.account != null)
              DeleteButton(
                onPressed: widget.onAccountDeleted != null
                    ? () => _showDeleteAccountDialog(context)
                    : null,
              ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: () {
              final isValid = _formKey.currentState?.validate() ?? false;
              setState(() {
                _formValid = isValid;
              });
            },
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  height: 80,
                  child: NameFormField(
                    AppLocalizations.of(context)?.hint_name ?? 'hint_name',
                    controller: _detailNameController,
                    focusNode: _focusNodeName,
                    validator: (value) {
                      if (value == null || value.length < 4) {
                        return AppLocalizations.of(context)
                                ?.validation_name_too_short ??
                            'validation_name_too_short';
                      }

                      return null;
                    },
                    onFieldSubmitted: (_) {
                      _focusNodeWebsite.requestFocus();
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8.0),
                  height: 80,
                  child: WebsiteFormField(
                    AppLocalizations.of(context)?.hint_website ??
                        'hint_website',
                    controller: _detailWebsiteController,
                    focusNode: _focusNodeWebsite,
                    validator: (value) {
                      if (!RegExp(K.regexURL).hasMatch(value ?? '')) {
                        return AppLocalizations.of(context)
                                ?.validation_invalid_url ??
                            'validation_invalid_url';
                      }

                      return null;
                    },
                    onFieldSubmitted: (_) {
                      _focusNodeUsername.requestFocus();
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8.0),
                  height: 80,
                  child: EmailFormField(
                    AppLocalizations.of(context)?.hint_email ?? 'hint_email',
                    controller: _detailUsernameController,
                    focusNode: _focusNodeUsername,
                    validator: (value) {
                      if (!RegExp(K.regexEmail).hasMatch(value ?? '')) {
                        return AppLocalizations.of(context)
                                ?.validation_invalid_email ??
                            'validation_invalid_email';
                      }

                      return null;
                    },
                    onCopied: () async {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(AppLocalizations.of(context)
                                    ?.snackbar_username_copied ??
                                'snackbar_username_copied')),
                      );

                      await Clipboard.setData(
                          ClipboardData(text: _detailUsernameController.text));
                    },
                    cancellable: true,
                    onFieldSubmitted: (_) {
                      _focusNodePassword.requestFocus();
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8.0),
                  height: 80,
                  child: PasswordFormField(
                    AppLocalizations.of(context)?.hint_password ??
                        'hint_password',
                    controller: _detailPasswordController,
                    focusNode: _focusNodePassword,
                    validator: (value) {
                      if (value == null || value.length < 8) {
                        return AppLocalizations.of(context)
                                ?.validation_password_too_short ??
                            'validation_password_too_short';
                      }

                      return null;
                    },
                    onCopied: () async {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(AppLocalizations.of(context)
                                    ?.snackbar_password_copied ??
                                'snackbar_password_copied')),
                      );

                      await Clipboard.setData(
                          ClipboardData(text: _detailPasswordController.text));
                    },
                    onFieldSubmitted: (_) {
                      if (_formValid && widget.onAccountChanged != null) {
                        _createOrUpdateAccountAndPop(context);
                      }
                    },
                    textInputAction: TextInputAction.go,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: _PasswordComplexity(_password),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: _SaveButton(
                    onPressed: _formValid && widget.onAccountChanged != null
                        ? () => _createOrUpdateAccountAndPop(context)
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  void _showDeleteAccountDialog(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
              AppLocalizations.of(context)?.dialog_delete_account_title ??
                  'dialog_delete_account_title'),
          content: Text(
              AppLocalizations.of(context)?.dialog_delete_account_message ??
                  'dialog_delete_account_message'),
          actions: [
            TextButton(
              child: Text(
                  AppLocalizations.of(context)?.action_yes ?? 'action_yes'),
              onPressed: () {
                widget.onAccountDeleted!();
                context.router.popUntilRouteWithName(AccountsRoute.name);
              },
            ),
            TextButton(
              child:
                  Text(AppLocalizations.of(context)?.action_no ?? 'action_no'),
              onPressed: () => context.router.pop(),
            ),
          ],
        ),
      );
    });
  }

  void _onPasswordChanged() {
    setState(() {
      _password = _detailPasswordController.text;
    });
  }

  void _createOrUpdateAccountAndPop(BuildContext context) {
    widget.onAccountChanged!(
      Account(
        name: _detailNameController.text,
        website: _detailWebsiteController.text,
        username: _detailUsernameController.text,
        password: _detailPasswordController.text,
      ),
    );

    if (!widget.masterDetailNavigation) {
      context.router.pop();
    }
  }
}

class _PasswordComplexity extends StatelessWidget {
  final String? password;

  const _PasswordComplexity(this.password, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)?.label_password_complexity ??
                'label_password_complexity',
            style: Theme.of(context).textTheme.caption,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: FlutterPasswordStrength(
              password: password,
              height: 8,
              radius: 8,
            ),
          ),
        ],
      );
}

class _SaveButton extends StatelessWidget {
  final GestureTapCallback? onPressed;

  const _SaveButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onPressed,
        child: Text(
          AppLocalizations.of(context)?.action_save ?? 'action_save',
        ),
      );
}
