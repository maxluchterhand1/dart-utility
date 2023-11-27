/// Option represents an optional value: every Option is either Some and
/// contains a value, or None, and does not.
sealed class Option<T> {
  const Option();

  T operator ~() {
    switch (this) {
      case Some(value: final value):
        return value;
      case None():
        throw None();
    }
  }

  @override
  String toString() {
    switch (this) {
      case Some(value: final value):
        return 'Some($value)';
      case None():
        return 'None';
    }
  }
}

/// Some value of type T.
class Some<T> extends Option<T> {
  const Some(this.value);

  final T value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Some && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;
}

/// No value.
class None<T> extends Option<T> {
  const None();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is None && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

Option<T> bailOnNone<T>(Option<T> Function() f) {
  try {
    return f();
  } on None catch (_) {
    return const None();
  }
}

Future<Option<T>> bailOnNoneAsync<T>(Future<Option<T>> Function() f) async {
  try {
    return await f();
  } on None catch (_) {
    return const None();
  }
}
