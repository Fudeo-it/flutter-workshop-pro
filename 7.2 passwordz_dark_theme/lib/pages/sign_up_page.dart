import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passwordz/blocs/sign_up/sign_up_bloc.dart';
import 'package:passwordz/misc/constants.dart';
import 'package:passwordz/routers/app_router.gr.dart';
import 'package:passwordz/widgets/buttons/chevron_back_button.dart';
import 'package:passwordz/widgets/email_form_field.dart';
import 'package:passwordz/widgets/name_form_field.dart';
import 'package:passwordz/widgets/password_form_field.dart';
import 'package:passwordz/widgets/responsive_builder.dart';

class SignUpPage extends StatelessWidget with AutoRouteWrapper {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<SignUpBloc>(
            create: (context) => SignUpBloc(
              userRepository: context.read(),
            ),
          ),
        ],
        child: this,
      );

  @override
  Widget build(BuildContext context) => ResponsiveBuilder(
        builder: (context, deviceType) => Row(
          children: [
            const Expanded(child: _SignUp()),
            if (deviceType > DeviceType.phone)
              const Expanded(child: _SignUpImage()),
          ],
        ),
      );
}

class _SignUp extends StatefulWidget {
  const _SignUp({Key? key}) : super(key: key);

  @override
  State<_SignUp> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<_SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool _formValid = false;

  final _focusNodeName = FocusNode();
  final _focusNodeEmail = FocusNode();
  final _focusNodePassword = FocusNode();
  final _focusNodeConfirmPassword = FocusNode();

  final _signUpNameController = TextEditingController();
  final _signUpEmailController = TextEditingController();
  final _signUpPasswordController = TextEditingController();
  final _signUpConfirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: ChevronBackButton(
            onPressed: () => context.router.pop(),
          ),
        ),
        body: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: () {
            final isValid = _formKey.currentState?.validate() ?? false;

            setState(() {
              _formValid = isValid;
            });
          },
          child: BlocConsumer<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state is SignedUpState) {
                _showSignUpSuccessDialog(context);
              } else if (state is ErrorSignUpState) {
                _showSignUpErrorDialog(context);
              }
            },
            builder: (context, state) => ListView(
              padding: const EdgeInsets.only(
                left: 32.0,
                right: 32.0,
                top: 128.0,
              ),
              physics: const BouncingScrollPhysics(),
              children: [
                const _SailWithUsTitle(),
                const _SailWithUsCaption(),
                Container(
                  margin: const EdgeInsets.only(top: 72.0),
                  height: 80,
                  child: NameFormField(
                    AppLocalizations.of(context)?.hint_name ?? 'hint_name',
                    controller: _signUpNameController,
                    focusNode: _focusNodeName,
                    enabled: state is! SigningUpState,
                    validator: (value) {
                      if (value == null || value.length < 4) {
                        return AppLocalizations.of(context)
                                ?.validation_name_too_short ??
                            'validation_name_too_short';
                      }

                      return null;
                    },
                    onFieldSubmitted: (_) {
                      _focusNodeEmail.requestFocus();
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8.0),
                  height: 80,
                  child: EmailFormField(
                    AppLocalizations.of(context)?.hint_email ?? 'hint_email',
                    controller: _signUpEmailController,
                    focusNode: _focusNodeEmail,
                    enabled: state is! SigningUpState,
                    validator: (value) {
                      if (!RegExp(K.regexEmail).hasMatch(value ?? '')) {
                        return AppLocalizations.of(context)
                                ?.validation_invalid_email ??
                            'validation_invalid_email';
                      }

                      return null;
                    },
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
                    controller: _signUpPasswordController,
                    focusNode: _focusNodePassword,
                    enabled: state is! SigningUpState,
                    validator: (value) {
                      if (value == null || value.length < 8) {
                        return AppLocalizations.of(context)
                                ?.validation_password_too_short ??
                            'validation_password_too_short';
                      }

                      return null;
                    },
                    onFieldSubmitted: (_) {
                      _focusNodeConfirmPassword.requestFocus();
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8.0),
                  height: 80,
                  child: PasswordFormField(
                    AppLocalizations.of(context)?.hint_password_confirm ??
                        'hint_password_confirm',
                    controller: _signUpConfirmPasswordController,
                    focusNode: _focusNodeConfirmPassword,
                    enabled: state is! SigningUpState,
                    validator: (value) {
                      if (_signUpPasswordController.text != value) {
                        return AppLocalizations.of(context)
                                ?.validation_password_do_not_match ??
                            'validation_password_do_not_match';
                      }

                      return null;
                    },
                    onFieldSubmitted: (_) {
                      if (_formValid) {
                        context.read<SignUpBloc>().signUp(
                              name: _signUpNameController.text,
                              email: _signUpEmailController.text,
                              password: _signUpPasswordController.text,
                            );
                      }
                    },
                    textInputAction: TextInputAction.go,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: _SignUpButton(
                    loading: state is SigningUpState,
                    onPressed: _formValid
                        ? () => context.read<SignUpBloc>().signUp(
                              name: _signUpNameController.text,
                              email: _signUpEmailController.text,
                              password: _signUpPasswordController.text,
                            )
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  @override
  void dispose() {
    _focusNodeName.dispose();
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _focusNodeConfirmPassword.dispose();

    _signUpNameController.dispose();
    _signUpEmailController.dispose();
    _signUpPasswordController.dispose();
    _signUpConfirmPasswordController.dispose();

    super.dispose();
  }

  void _showSignUpSuccessDialog(BuildContext context) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(
                AppLocalizations.of(context)?.dialog_success_sign_up_title ??
                    'dialog_success_sign_up_title'),
            content: Text(
                AppLocalizations.of(context)?.dialog_success_sign_up_message ??
                    'dialog_success_sign_up_message'),
            actions: [
              TextButton(
                child: Text(
                    AppLocalizations.of(context)?.action_ok ?? 'action_ok'),
                onPressed: () =>
                    context.router.popUntilRouteWithName(SignInRoute.name),
              ),
            ],
          ),
        );
      });

  void _showSignUpErrorDialog(BuildContext context) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(
                AppLocalizations.of(context)?.dialog_wrong_sign_up_title ??
                    'dialog_wrong_sign_up_title'),
            content: Text(
                AppLocalizations.of(context)?.dialog_wrong_sign_up_message ??
                    'dialog_wrong_sign_up_message'),
            actions: [
              TextButton(
                child: Text(
                    AppLocalizations.of(context)?.action_ok ?? 'action_ok'),
                onPressed: () => context.router.pop(),
              ),
            ],
          ),
        );
      });
}

class _SailWithUsTitle extends StatelessWidget {
  const _SailWithUsTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
        AppLocalizations.of(context)?.label_sail_with_us_title ??
            'label_sail_with_us_title',
        style: Theme.of(context).textTheme.titleLarge,
      );
}

class _SailWithUsCaption extends StatelessWidget {
  const _SailWithUsCaption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
        AppLocalizations.of(context)?.label_sail_with_us_caption ??
            'label_sail_with_us_caption',
        style: Theme.of(context).textTheme.titleSmall,
      );
}

class _SignUpButton extends StatelessWidget {
  final bool loading;
  final GestureTapCallback? onPressed;

  const _SignUpButton({
    Key? key,
    this.loading = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onPressed,
        child: !loading
            ? Text(AppLocalizations.of(context)?.action_sign_up ??
                'action_sign_up')
            : const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
      );
}

class _SignUpImage extends StatelessWidget {
  const _SignUpImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: double.maxFinite,
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.all(128),
        child: SvgPicture.asset(K.signUpImage),
      );
}
