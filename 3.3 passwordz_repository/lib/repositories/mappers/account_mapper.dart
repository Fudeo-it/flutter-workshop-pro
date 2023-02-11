import 'package:passwordz/models/account.dart';
import 'package:passwordz/services/network/dto/password_dto.dart';
import 'package:pine/pine.dart';

class AccountMapper extends DTOMapper<PasswordDTO, Account> {

  @override
  Account fromDTO(PasswordDTO dto) => Account(
    name: dto.name,
    website: dto.website,
    username: dto.username,
    password: dto.password,
  );

  @override
  PasswordDTO toDTO(Account model) => PasswordDTO(
    name: model.name,
    website: model.website,
    username: model.username,
    password: model.password,
  );

}