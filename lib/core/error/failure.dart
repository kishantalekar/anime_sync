class ApiFailure {
  final String message;
  final String stackTrace;

  factory ApiFailure.fromException(e) {
    return ApiFailure(message: e.message, stackTrace: e.s);
  }

  ApiFailure({required this.message, required this.stackTrace});

  String get errorMessage => "An error occurred $message";
}
