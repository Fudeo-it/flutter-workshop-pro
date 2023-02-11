import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passwordz/blocs/sign_in/sign_in_bloc.dart';
import 'package:passwordz/cubits/auth/auth_cubit.dart';
import 'package:passwordz/misc/constants.dart';
import 'package:passwordz/routers/app_router.gr.dart';
import 'package:passwordz/widgets/email_form_field.dart';
import 'package:passwordz/widgets/password_form_field.dart';
import 'package:passwordz/widgets/responsive_builder.dart';

class SignInPage extends StatelessWidget with AutoRouteWrapper {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<SignInBloc>(
            create: (context) => SignInBloc(
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
            if (deviceType > DeviceType.phone)
              const Expanded(child: _SignInImage()),
            const Expanded(child: _SignIn()),
          ],
        ),
      );
}

class _SignIn extends StatefulWidget {
  const _SignIn({Key? key}) : super(key: key);

  @override
  State<_SignIn> createState() => _SignInState();
}

class _SignInState extends State<_SignIn> {
  final _formKey = GlobalKey<FormState>();
  bool _formValid = false;

  final _focusNodeEmail = FocusNode();
  final _focusNodePassword = FocusNode();

  final _signInEmailController = TextEditingController();
  final _signInPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: () {
          final isValid = _formKey.currentState?.validate() ?? false;

          setState(() {
            _formValid = isValid;
          });
        },
        child: BlocConsumer<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state is SignedInState) {
              context.read<AuthCubit>().authenticated(state.user);
            } else if (state is ErrorSignInState) {
              _showSignInErrorDialog(context);
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
              const _WelcomeBackTitle(),
              const _WelcomeBackCaption(),
              Container(
                margin: const EdgeInsets.only(top: 72.0),
                height: 80,
                child: EmailFormField(
                  AppLocalizations.of(context)?.hint_email ?? 'hint_email',
                  controller: _signInEmailController,
                  focusNode: _focusNodeEmail,
                  enabled: state is! SigningInState,
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
                  controller: _signInPasswordController,
                  focusNode: _focusNodePassword,
                  enabled: state is! SigningInState,
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return AppLocalizations.of(context)
                              ?.validation_password_too_short ??
                          'validation_password_too_short';
                    }

                    return null;
                  },
                  onFieldSubmitted: (_) {
                    if (_formValid) {
                      context.read<SignInBloc>().signIn(
                            email: _signInEmailController.text,
                            password: _signInPasswordController.text,
                          );
                    }
                  },
                  textInputAction: TextInputAction.go,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: _SignInButton(
                  loading: state is SigningInState,
                  onPressed: _formValid
                      ? () => context.read<SignInBloc>().signIn(
                            email: _signInEmailController.text,
                            password: _signInPasswordController.text,
                          )
                      : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 192.0),
                child: _SignUpButton(
                  onPressed: () => context.pushRoute(const SignUpRoute()),
                ),
              ),
            ],
          ),
        ),
      ));

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();

    _signInEmailController.dispose();
    _signInPasswordController.dispose();

    super.dispose();
  }

  void _showSignInErrorDialog(BuildContext context) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(
                AppLocalizations.of(context)?.dialog_wrong_sign_in_title ??
                    'dialog_wrong_sign_in_title'),
            content: Text(
                AppLocalizations.of(context)?.dialog_wrong_sign_in_message ??
                    'dialog_wrong_sign_in_message'),
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

class _WelcomeBackTitle extends StatelessWidget {
  const _WelcomeBackTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
        AppLocalizations.of(context)?.label_welcome_back_title ??
            'label_welcome_back_title',
        style: Theme.of(context).textTheme.titleLarge,
      );
}

class _WelcomeBackCaption extends StatelessWidget {
  const _WelcomeBackCaption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
        AppLocalizations.of(context)?.label_welcome_back_caption ??
            'label_welcome_back_caption',
        style: Theme.of(context).textTheme.titleSmall,
      );
}

class _SignInButton extends StatelessWidget {
  final bool loading;
  final GestureTapCallback? onPressed;

  const _SignInButton({
    Key? key,
    this.loading = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onPressed,
        child: !loading
            ? Text(AppLocalizations.of(context)?.action_sign_in ??
                'action_sign_in')
            : const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
      );
}

class _SignUpButton extends StatelessWidget {
  final GestureTapCallback? onPressed;

  const _SignUpButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onPressed,
        child: RichText(
          text: TextSpan(
            text: AppLocalizations.of(context)?.label_no_account ??
                'label_no_account',
            style: Theme.of(context).textTheme.caption,
            children: [
              TextSpan(
                text: AppLocalizations.of(context)?.action_sign_up ??
                    'action_sign_up',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w900,
                ),
              )
            ],
          ),
        ),
      );
}

class _SignInImage extends StatelessWidget {
  const _SignInImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: double.maxFinite,
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.all(128),
        child: SvgPicture.asset(K.signInImage),
      );
}
