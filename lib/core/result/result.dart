abstract class Result<T extends Object> {
  const Result();

  // Using TearsOff constructors

  factory Result.ok(T value) = Ok._;
  factory Result.error(Exception error) = Error._;
}

class Ok<T extends Object> extends Result<T> {
  const Ok._(this.value);
  final T value;
}

class Error<T extends Object> extends Result<T> {
  const Error._(this.error);
  final Exception error;
}

extension ResultExtension on Object {
  Result ok() {
    return Result.ok(this);
  }
}

extension ResultErrorExtension on Exception {
  Result error() {
    return Result.error(this);
  }
}

extension ResultCasting<T extends Object> on Result<T> {
  Ok<T> get asOk => this as Ok<T>;

  Error<T> get asError => this as Error<T>;
}