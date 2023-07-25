class UIError {
  final String message;
  const UIError(this.message);
}

class Failure {
  final String message;
  Failure(this.message);
}

class NetworkFailure extends Failure {
  NetworkFailure(String message) : super(message);
}

class ApiFailure extends Failure {
  ApiFailure(String message) : super(message);
}

class DbFailure extends Failure {
  DbFailure(String message) : super(message);
}
