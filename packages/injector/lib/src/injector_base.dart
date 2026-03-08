class Injector {
  static final Injector _instance = Injector._({});

  final Map<Type, Injectable> _injectables;

  const Injector._(this._injectables);

  static Injector get instance => _instance;

  void singleton<T extends Object>(T value) {
    if (_injectables.containsKey(T)) {
      throw Exception('Instance already exists for type $T');
    }
    _injectables[T] = Instance(T, value);
  }

  void lazySingleton<T extends Object>(T Function() builder) {
    if (_injectables.containsKey(T)) {
      throw Exception('Instance already exists for type $T');
    }
    _injectables[T] = Builder(T, builder, false);
  }

  void factory<T extends Object>(T Function() builder) {
    if (_injectables.containsKey(T)) {
      throw Exception('Instance already exists for type $T');
    }
    _injectables[T] = Builder(T, builder, true);
  }

  T call<T extends Object>() => get<T>();

  T get<T extends Object>() {
    switch (_injectables[T]) {
      case Instance i:
        if (i.type != T) throw Exception('Instance type mismatch');
        return i.value as T;
      case Builder b:
        if (b.type != T) throw Exception('Builder type mismatch');
        final instance = b.builder();
        if (b.factory) return instance as T;
        _injectables[T] = Instance(T, instance);
        return instance as T;
      default:
        throw Exception('No instance found for type $T');
    }
  }

  void setModule(Module module) {
    module.bind(this);
    module.modules.forEach(setModule);
  }

  void reset() => _injectables.clear();
}

sealed class Injectable<T extends Object> {
  final Type type;

  const Injectable(this.type);
}

final class Instance<T extends Object> extends Injectable<T> {
  final T value;
  const Instance(super.type, this.value);
}

final class Builder<T extends Object> extends Injectable<T> {
  final T Function() builder;
  final bool factory;
  const Builder(super.type, this.builder, this.factory);
}

abstract class Module {
  void bind(Injector i) {}
  List<Module> get modules => [];
}
