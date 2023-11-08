import 'package:equatable/equatable.dart';

class Role extends Equatable {
  final int id;
  final String role;

  const Role({required this.id, required this.role});
  @override
  List<Object?> get props => [id, role];

  static const roles = [
    Role(id: 1, role: "Product Designer"),
    Role(id: 2, role: "Flutter Developer"),
    Role(id: 3, role: "QA Tester"),
    Role(id: 4, role: "Product Owner"),
  ];
}
