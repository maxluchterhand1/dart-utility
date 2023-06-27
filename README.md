# Utility (Dart)

This package contains utility classes used in our Dart projects.

## Option
`Option`  represents an optional value: every `Option`  is either `Some` and contains a value, or  `None`, and does not.  `Option` types are very common in functional programming, as they have a number of uses:

-   Initial values
-   Return values for functions that are not defined over their entire input range (partial functions)
-   Return value for otherwise reporting simple errors, where `None` is returned on error
-   Optional fields

`Option`s are commonly paired with pattern matching to query the presence of a value and take action, always accounting for the  `None` case.

## Result
`Result<T, E>` is the type used for returning and propagating errors. It is a sealed class with the variants, `Success(T)`, representing success and containing a value, and `Failure(E)`, representing error and containing an error value. Functions return `Result` whenever errors are expected and recoverable.

`Result`s are commonly paired with pattern matching to query the presence of a value and take action, always accounting for the  `Failure` case.
