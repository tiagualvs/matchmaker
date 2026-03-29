class Timestamp {
  const Timestamp._();

  static DateTime now() => DateTime.now().toUtc();

  static DateTime min() => DateTime(0);
}
