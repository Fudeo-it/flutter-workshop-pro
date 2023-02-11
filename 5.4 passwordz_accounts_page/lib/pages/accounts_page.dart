import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:passwordz/blocs/account_bloc/account_bloc.dart';
import 'package:passwordz/cubits/account_action/account_action_cubit.dart';
import 'package:passwordz/cubits/auth/auth_cubit.dart';
import 'package:passwordz/cubits/scroll_cubit.dart';
import 'package:passwordz/widgets/account_tile.dart';
import 'package:passwordz/widgets/loading_widget.dart';
import 'package:passwordz/widgets/sign_out_button.dart';

class AccountsPage extends StatelessWidget with AutoRouteWrapper {
  const AccountsPage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<ScrollCubit>(
            create: (_) => ScrollCubit(),
          ),
          BlocProvider<AccountActionCubit>(
            create: (_) => AccountActionCubit(),
          ),
          BlocProvider<AccountBloc>(
            create: (context) => AccountBloc(
              accountRepository: context.read(),
            )..fetchAccounts(),
          ),
        ],
        child: this,
      );

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(AppLocalizations.of(context)?.app_name ?? ''),
            actions: [
              SignOutButton(
                onPressed: () => _showSignOutDialog(context),
              ),
            ],
          ),
          body: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) => Stack(
              alignment: Alignment.center,
              children: [
                if (state is FetchingAccountsState) const LoadingWidget(),
                if (state is FetchedAccountsState)
                  NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollStartNotification) {
                        context.read<ScrollCubit>().start();
                      } else if (notification is ScrollEndNotification) {
                        context.read<ScrollCubit>().stop();
                      }

                      return false;
                    },
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final account = state.accounts[index];

                        return AccountTile(account);
                      },
                      itemCount: state.accounts.length,
                    ),
                  ),
                if (state is NoAccountsState)
                  Center(
                    child: Text(
                      AppLocalizations.of(context)
                              ?.label_no_accounts_available ??
                          'label_no_accounts_available',
                    ),
                  ),
                if (state is ErrorAccountsState)
                  Center(
                    child: Text(
                      AppLocalizations.of(context)
                              ?.label_error_accounts_available ??
                          'label_error_accounts_available',
                    ),
                  ),
                if (state is FetchedAccountsState || state is NoAccountsState)
                  BlocBuilder<ScrollCubit, bool>(
                    builder: (context, isScrolling) => AnimatedPositioned(
                      duration: const Duration(milliseconds: 250),
                      bottom: isScrolling ? -100 : 24,
                      child: FloatingActionButton(
                        child: const FaIcon(
                          FontAwesomeIcons.plus,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );

  void _showSignOutDialog(BuildContext context) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(AppLocalizations.of(context)?.dialog_sign_out_title ??
                'dialog_sign_out_title'),
            content: Text(
                AppLocalizations.of(context)?.dialog_sign_out_message ??
                    'dialog_sign_out_message'),
            actions: [
              TextButton(
                child: Text(
                    AppLocalizations.of(context)?.action_yes ?? 'action_yes'),
                onPressed: () {
                  context.router.pop();
                  context.read<AuthCubit>().signOut();
                },
              ),
              TextButton(
                child: Text(
                    AppLocalizations.of(context)?.action_no ?? 'action_no'),
                onPressed: () => context.router.pop(),
              ),
            ],
          ),
        );
      });
}
