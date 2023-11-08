abstract class CustomException implements Exception {
  final String message;

  CustomException(this.message);
}

class UnknownException extends CustomException {
  UnknownException(super.message);
}

class DatabaseException extends CustomException {
  DatabaseException(super.message);
}
