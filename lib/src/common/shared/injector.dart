typedef Injectable<T> = (Type type, T value);

class Injector {
  final Set<Injectable> _instances = {};
  final Map<Type, Function> _builders = {};
  static final _isntance = Injector._();

  Injector._();

  static Injector get instance => _isntance;

  T get<T>() {
    if (!_contains<T>()) throw Exception('Instance $T not found!');
    if (_builders.containsKey(T)) {
      final instance = _builders[T]?.call();
      _instances.add((T, instance));
      _builders.remove(T);
      return instance as T;
    }
    return _instances.where((e) => e.$1 == T).first.$2 as T;
  }

  void set<T extends Object>(T value) {
    if (_contains<T>()) throw Exception('Instance $T already exists!');
    _instances.add((T, value));
  }

  void lazySet<T extends Object>(T Function() builder) {
    if (_contains<T>()) throw Exception('Instance $T already exists!');
    _builders[T] = builder;
  }

  void batch(void Function(Injector injector) builder) => builder(this);

  void replace<T>(T value) {
    if (!_contains<T>()) throw Exception('Instance $T not found!');
    if (_builders.containsKey(T)) {
      _builders[T] = () => value;
      return;
    }
    _instances.removeWhere((e) => e.$1 == T);
    _instances.add((T, value));
  }

  bool _contains<T>() =>
      _instances.where((e) => e.$1 == T).isNotEmpty || _builders.containsKey(T);
}
