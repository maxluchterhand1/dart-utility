/// Option represents an optional value: every Option is either Some and
/// contains a value, or None, and does not.
sealed class Option<T> {}

/// Some value of type T.
class Some<T> implements Option<T> {
  const Some(this.value);

  final T value;
}

/// No value.
class None<T> implements Option<T> {
  const None();
}
