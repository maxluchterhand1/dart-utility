/// Result<E, T> is used for returning and propagating errors.
/// It is a sealed class with the variants, Success(T), representing success
/// and containing a value, and Failure(E), representing error and containing
/// an optional error value.
sealed class Result<E, T> {
  const Result();

  T operator ~() {
    switch (this) {
      case Success(value: final value):
        return value;
      case Failure(value: final failure):
        throw Failure<E, T>(failure);
    }
  }

  @override
  String toString() {
    switch (this) {
      case Success(value: final value):
        return 'Success($value)';
      case Failure(value: final value):
        switch (value) {
          case null:
            return 'Failure';
          default:
            return 'Failure($value)';
        }
    }
  }
}

/// Contains the success value.
class Success<E, T> extends Result<E, T> {
  const Success(this.value);

  final T value;

  static Success<E, void> empty<E>() => Success<E, void>(null);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Success &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

/// Optionally contains the error value.
class Failure<E, T> extends Result<E, T> {
  const Failure([this.value]);

  final E? value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

Result<E, T> bailOnFail<E, T>(Result<E, T> Function() f) {
  try {
    return f();
  } on Failure catch (failure) {
    switch (failure) {
      case Failure(value: final failure):
        if (failure case final E e) return Failure(e);
    }
    return const Failure();
  }
}

Future<Result<E, T>> bailOnFailAsync<E, T>(
  Future<Result<E, T>> Function() f,
) async {
  try {
    return await f();
  } on Failure catch (failure) {
    switch (failure) {
      case Failure(value: final failure):
        if (failure case final E e) return Failure(e);
    }
    return const Failure();
  }
}
