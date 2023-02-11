import 'package:logger/logger.dart';
import 'package:passwordz/models/account.dart';
import 'package:passwordz/services/network/account_service.dart';
import 'package:passwordz/services/network/dto/password_dto.dart';
import 'package:passwordz/services/network/dto/update_account_request.dart';
import 'package:pine/utils/mapper.dart';

class AccountRepository {
  final AccountService accountService;
  final DTOMapper<PasswordDTO, Account> accountMapper;
  final Logger logger;

  AccountRepository({
    required this.accountService,
    required this.accountMapper,
    required this.logger,
  });

  Future<List<Account>> get accounts async {
    try {
      final response = await accountService.all();

      return response.passwords
          .map(accountMapper.fromDTO)
          .toList(growable: false);
    } catch (error, stackTrace) {
      logger.e(
        'Error getting account list',
        error,
        stackTrace,
      );

      rethrow;
    }
  }

  Future<List<Account>> update(List<Account> accounts) async {
    try {
      final response = await accountService.update(
        UpdateAccountRequest(
          accounts.map(accountMapper.toDTO).toList(growable: false),
        ),
      );

      return response.passwords
          .map(accountMapper.fromDTO)
          .toList(growable: false);
    } catch (error, stackTrace) {
      logger.e(
        'Error updating account list',
        error,
        stackTrace,
      );

      rethrow;
    }
  }
}
