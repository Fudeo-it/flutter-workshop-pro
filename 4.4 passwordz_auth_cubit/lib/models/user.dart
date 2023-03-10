import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String email;
  final String token;

  const User({
    required this.name,
    required this.email,
    required this.token,
  });

  @override
  List<Object?> get props => [email];
}
