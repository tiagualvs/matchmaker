typedef AsyncResult<T> = Future<Result<T>>;

sealed class Result<T> {
  const Result();
  const factory Result.value(T value) = Value<T>._;
  const factory Result.error(Exception error) = Error<T>._;
  bool get hasValue => this is Value<T>;
  bool get hasError => this is Error<T>;
  T get value => (this as Value<T>)._value;
  Exception get error => (this as Error<T>)._error;
  S fold<S>(S Function(T value) onValue, S Function(Exception error) onError) {
    return switch (this) {
      Value<T> v => onValue(v._value),
      Error<T> e => onError(e._error),
    };
  }
}

final class Value<T> extends Result<T> {
  final T _value;
  const Value._(this._value);
}

final class Error<T> extends Result<T> {
  final Exception _error;
  const Error._(this._error);
}
