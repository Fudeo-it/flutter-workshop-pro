import 'package:equatable/equatable.dart';

class Account extends Equatable {
  final String name;
  final String website;
  final String username;
  final String password;

  const Account({
    required this.name,
    required this.website,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [name];
}
