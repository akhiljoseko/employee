import 'package:equatable/equatable.dart';

class Role extends Equatable {
  final int id;
  final String role;

  const Role({required this.id, required this.role});
  @override
  List<Object?> get props => [id, role];
}
