import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:passwordz/blocs/account_bloc/account_bloc.dart';
import 'package:passwordz/cubits/account_action/account_action_cubit.dart';
import 'package:passwordz/cubits/scroll_cubit.dart';
import 'package:passwordz/models/account.dart';
import 'package:passwordz/pages/account_detail_page.dart';
import 'package:passwordz/pages/accounts_page.dart';
import 'package:passwordz/routers/app_router.gr.dart';
import 'package:passwordz/widgets/account_tile.dart';
import 'package:passwordz/widgets/loading_widget.dart';
import 'package:pine/pine.dart';

import '../fixtures/account_fixture_factory.dart';
import 'accounts_page_test.mocks.dart';

@GenerateMocks([
  StackRouter,
])
void main() {
  late MockAccountBloc accountBloc;
  late MockAccountActionCubit accountActionCubit;
  late MockScrollCubit scrollCubit;

  late StackRouter stackRouter;

  late List<Account> accounts;

  setUp(() {
    accountBloc = MockAccountBloc();
    accountActionCubit = MockAccountActionCubit();
    scrollCubit = MockScrollCubit();
    stackRouter = MockStackRouter();

    accounts = AccountFixture.factory().makeMany(3);
  });

  group('testing accounts behavior', () {
    testWidgets('testing successfully fetched accounts', (tester) async {
      whenListen(
        accountBloc,
        Stream.fromIterable([
          const FetchingAccountsState(),
          FetchedAccountsState(accounts),
        ]),
        initialState: const FetchingAccountsState(),
      );

      whenListen(
        accountActionCubit,
        Stream.fromIterable([
          const UnselectedAccountActionState(),
        ]),
        initialState: const UnselectedAccountActionState(),
      );

      whenListen(
        scrollCubit,
        Stream.fromIterable([
          false,
        ]),
        initialState: false,
      );

      await tester.pumpWidget(
        DependencyInjectorHelper(
          blocs: [
            BlocProvider<AccountBloc>.value(value: accountBloc),
            BlocProvider<AccountActionCubit>.value(value: accountActionCubit),
            BlocProvider<ScrollCubit>.value(value: scrollCubit),
          ],
          child: const MaterialApp(
            home: AccountsPage(),
          ),
        ),
      );

      expect(find.byType(LoadingWidget), findsOneWidget);
      expect(find.byType(ListView), findsNothing);
      expect(find.byType(FloatingActionButton), findsNothing);
      expect(find.byType(AccountTile), findsNothing);
      expect(find.text('label_no_accounts_available'), findsNothing);
      expect(find.text('label_error_accounts_available'), findsNothing);

      await tester.pumpAndSettle();

      expect(find.byType(LoadingWidget), findsNothing);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byType(AccountTile), findsNWidgets(accounts.length));
      expect(find.text('label_no_accounts_available'), findsNothing);
      expect(find.text('label_error_accounts_available'), findsNothing);
    });

    testWidgets('testing successfully fetched empty accounts', (tester) async {
      whenListen(
        accountBloc,
        Stream.fromIterable([
          const FetchingAccountsState(),
          const NoAccountsState(),
        ]),
        initialState: const FetchingAccountsState(),
      );

      whenListen(
        accountActionCubit,
        Stream.fromIterable([
          const UnselectedAccountActionState(),
        ]),
        initialState: const UnselectedAccountActionState(),
      );

      whenListen(
        scrollCubit,
        Stream.fromIterable([
          false,
        ]),
        initialState: false,
      );

      await tester.pumpWidget(
        DependencyInjectorHelper(
          blocs: [
            BlocProvider<AccountBloc>.value(value: accountBloc),
            BlocProvider<AccountActionCubit>.value(value: accountActionCubit),
            BlocProvider<ScrollCubit>.value(value: scrollCubit),
          ],
          child: const MaterialApp(
            home: AccountsPage(),
          ),
        ),
      );

      expect(find.byType(LoadingWidget), findsOneWidget);
      expect(find.byType(ListView), findsNothing);
      expect(find.byType(FloatingActionButton), findsNothing);
      expect(find.byType(AccountTile), findsNothing);
      expect(find.text('label_no_accounts_available'), findsNothing);
      expect(find.text('label_error_accounts_available'), findsNothing);

      await tester.pumpAndSettle();

      expect(find.byType(LoadingWidget), findsNothing);
      expect(find.byType(ListView), findsNothing);
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byType(AccountTile), findsNothing);
      expect(find.text('label_no_accounts_available'), findsOneWidget);
      expect(find.text('label_error_accounts_available'), findsNothing);
    });

    testWidgets('testing error while fetching accounts', (tester) async {
      whenListen(
        accountBloc,
        Stream.fromIterable([
          const FetchingAccountsState(),
          const ErrorAccountsState(),
        ]),
        initialState: const FetchingAccountsState(),
      );

      whenListen(
        accountActionCubit,
        Stream.fromIterable([
          const UnselectedAccountActionState(),
        ]),
        initialState: const UnselectedAccountActionState(),
      );

      whenListen(
        scrollCubit,
        Stream.fromIterable([
          false,
        ]),
        initialState: false,
      );

      await tester.pumpWidget(
        DependencyInjectorHelper(
          blocs: [
            BlocProvider<AccountBloc>.value(value: accountBloc),
            BlocProvider<AccountActionCubit>.value(value: accountActionCubit),
            BlocProvider<ScrollCubit>.value(value: scrollCubit),
          ],
          child: const MaterialApp(
            home: AccountsPage(),
          ),
        ),
      );

      expect(find.byType(LoadingWidget), findsOneWidget);
      expect(find.byType(ListView), findsNothing);
      expect(find.byType(FloatingActionButton), findsNothing);
      expect(find.byType(AccountTile), findsNothing);
      expect(find.text('label_no_accounts_available'), findsNothing);
      expect(find.text('label_error_accounts_available'), findsNothing);

      await tester.pumpAndSettle();

      expect(find.byType(LoadingWidget), findsNothing);
      expect(find.byType(ListView), findsNothing);
      expect(find.byType(FloatingActionButton), findsNothing);
      expect(find.byType(AccountTile), findsNothing);
      expect(find.text('label_no_accounts_available'), findsNothing);
      expect(find.text('label_error_accounts_available'), findsOneWidget);
    });
  });

  group('testing on phone devices', () {
    group('testing navigation behavior', () {
      testWidgets(
          'testing navigate to new account page when new account action state is emitted',
          (tester) async {
        tester.binding.window.physicalSizeTestValue = const Size(600, 2000);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        whenListen(
          accountBloc,
          Stream.fromIterable([
            FetchedAccountsState(accounts),
          ]),
          initialState: FetchedAccountsState(accounts),
        );

        whenListen(
          accountActionCubit,
          Stream.fromIterable([
            const UnselectedAccountActionState(),
            const NewAccountActionState(),
          ]),
          initialState: const UnselectedAccountActionState(),
        );

        whenListen(
          scrollCubit,
          Stream.fromIterable([
            false,
          ]),
          initialState: false,
        );

        when(stackRouter.push(AccountDetailRoute(account: null)))
            .thenAnswer((_) async => true);

        await tester.pumpWidget(
          DependencyInjectorHelper(
            blocs: [
              BlocProvider<AccountBloc>.value(value: accountBloc),
              BlocProvider<AccountActionCubit>.value(value: accountActionCubit),
              BlocProvider<ScrollCubit>.value(value: scrollCubit),
            ],
            child: StackRouterScope(
              stateHash: 1,
              controller: stackRouter,
              child: const MaterialApp(
                home: AccountsPage(),
              ),
            ),
          ),
        );

        expect(find.byType(AccountDetailPage), findsNothing);

        await tester.pumpAndSettle();

        verify(stackRouter.push(AccountDetailRoute(account: null))).called(1);
        expect(find.byType(AccountDetailPage), findsNothing);
      });

      testWidgets(
          'testing navigate to edit account when edit account action state is emitted',
          (tester) async {
        tester.binding.window.physicalSizeTestValue = const Size(600, 2000);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        whenListen(
          accountBloc,
          Stream.fromIterable([
            FetchedAccountsState(accounts),
          ]),
          initialState: FetchedAccountsState(accounts),
        );

        whenListen(
          accountActionCubit,
          Stream.fromIterable([
            const UnselectedAccountActionState(),
            EditAccountActionState(account: accounts.first, index: 0),
          ]),
          initialState: const UnselectedAccountActionState(),
        );

        whenListen(
          scrollCubit,
          Stream.fromIterable([
            false,
          ]),
          initialState: false,
        );

        when(stackRouter.push(AccountDetailRoute(account: accounts.first)))
            .thenAnswer((_) async => true);

        await tester.pumpWidget(
          DependencyInjectorHelper(
            blocs: [
              BlocProvider<AccountBloc>.value(value: accountBloc),
              BlocProvider<AccountActionCubit>.value(value: accountActionCubit),
              BlocProvider<ScrollCubit>.value(value: scrollCubit),
            ],
            child: StackRouterScope(
              stateHash: 1,
              controller: stackRouter,
              child: const MaterialApp(
                home: AccountsPage(),
              ),
            ),
          ),
        );

        expect(find.byType(AccountDetailPage), findsNothing);

        await tester.pumpAndSettle();

        verify(stackRouter.push(AccountDetailRoute(account: accounts.first)))
            .called(1);
        expect(find.byType(AccountDetailPage), findsNothing);
      });
    });
  });

  group('testing on tablet and desktop devices', () {
    group('testing navigation behavior', () {
      testWidgets(
          'testing navigate to new account page when new account action state is emitted',
          (tester) async {
        tester.binding.window.physicalSizeTestValue = const Size(2000, 600);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        whenListen(
          accountBloc,
          Stream.fromIterable([
            FetchedAccountsState(accounts),
          ]),
          initialState: FetchedAccountsState(accounts),
        );

        whenListen(
          accountActionCubit,
          Stream.fromIterable([
            const UnselectedAccountActionState(),
            const NewAccountActionState(),
          ]),
          initialState: const UnselectedAccountActionState(),
        );

        whenListen(
          scrollCubit,
          Stream.fromIterable([
            false,
          ]),
          initialState: false,
        );

        when(stackRouter.push(AccountDetailRoute(account: null)))
            .thenAnswer((_) async => true);

        await tester.pumpWidget(
          DependencyInjectorHelper(
            blocs: [
              BlocProvider<AccountBloc>.value(value: accountBloc),
              BlocProvider<AccountActionCubit>.value(value: accountActionCubit),
              BlocProvider<ScrollCubit>.value(value: scrollCubit),
            ],
            child: StackRouterScope(
              stateHash: 1,
              controller: stackRouter,
              child: const MaterialApp(
                home: AccountsPage(),
              ),
            ),
          ),
        );

        expect(find.byType(AccountDetailPage), findsNothing);

        await tester.pumpAndSettle();

        expect(find.byType(AccountDetailPage), findsOneWidget);
        verifyNever(stackRouter.push(AccountDetailRoute(account: null)));
      });

      testWidgets(
          'testing navigate to edit account when edit account action state is emitted',
          (tester) async {
        tester.binding.window.physicalSizeTestValue = const Size(2000, 600);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        whenListen(
          accountBloc,
          Stream.fromIterable([
            FetchedAccountsState(accounts),
          ]),
          initialState: FetchedAccountsState(accounts),
        );

        whenListen(
          accountActionCubit,
          Stream.fromIterable([
            const UnselectedAccountActionState(),
            EditAccountActionState(account: accounts.first, index: 0),
          ]),
          initialState: const UnselectedAccountActionState(),
        );

        whenListen(
          scrollCubit,
          Stream.fromIterable([
            false,
          ]),
          initialState: false,
        );

        when(stackRouter.push(AccountDetailRoute(account: accounts.first)))
            .thenAnswer((_) async => true);

        await tester.pumpWidget(
          DependencyInjectorHelper(
            blocs: [
              BlocProvider<AccountBloc>.value(value: accountBloc),
              BlocProvider<AccountActionCubit>.value(value: accountActionCubit),
              BlocProvider<ScrollCubit>.value(value: scrollCubit),
            ],
            child: StackRouterScope(
              stateHash: 1,
              controller: stackRouter,
              child: const MaterialApp(
                home: AccountsPage(),
              ),
            ),
          ),
        );

        expect(find.byType(AccountDetailPage), findsNothing);

        await tester.pumpAndSettle();

        verifyNever(
            stackRouter.push(AccountDetailRoute(account: accounts.first)));
        expect(find.byType(AccountDetailPage), findsOneWidget);
      });
    });
  });
}

class MockAccountBloc extends MockBloc<AccountEvent, AccountState>
    implements AccountBloc {}

class MockAccountActionCubit extends MockCubit<AccountActionState>
    implements AccountActionCubit {}

class MockScrollCubit extends MockCubit<bool> implements ScrollCubit {}
