import 'dart:developer' as debug;

import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesEncoder<T> {
  String identifier(T value);
  String encode(T value);
  T? decode(String source);
}

abstract class SharedPreferencesService {
  Future<bool> put<T>(T value);
  T? find<T>(bool Function(T value) where);
  List<T> findMany<T>([bool Function(T value)? where]);
  Future<bool> delete<T>(T value);

  static Future<SharedPreferencesService> create({
    Set<SharedPreferencesEncoder>? encoders,
  }) async {
    return _SharedPreferencesService.create(encoders: encoders);
  }

  static Future<SharedPreferencesService> test({
    Set<SharedPreferencesEncoder>? encoders,
  }) async {
    return _SharedPreferencesServiceMock.create(encoders: encoders);
  }
}

class _SharedPreferencesService implements SharedPreferencesService {
  final SharedPreferencesAsync _prefs;
  final Map<String, Object?> _cache;
  final Set<SharedPreferencesEncoder> _encoders;
  const _SharedPreferencesService(
    this._prefs,
    this._cache,
    this._encoders,
  );

  static Future<_SharedPreferencesService> create({
    Set<SharedPreferencesEncoder>? encoders,
  }) async {
    final prefs = SharedPreferencesAsync();
    final cache = await prefs.getAll();
    return _SharedPreferencesService(prefs, cache, encoders ?? {});
  }

  @override
  Future<bool> put<T>(T value) async {
    try {
      final encoder = _getEncoder<T>();
      if (encoder == null) return false;
      final key = _key<T>(encoder.identifier(value));
      await _prefs.setString(key, encoder.encode(value));
      _cache[key] = encoder.encode(value);
      return true;
    } on Exception catch (e) {
      debug.log(e.toString(), name: 'SharedPreferencesService.put');
      return false;
    }
  }

  @override
  T? find<T>(bool Function(T value) where) {
    final encoder = _getEncoder<T>();
    if (encoder == null) return null;
    final list = _getList<T>();
    return list.firstWhereOrNull(where);
  }

  @override
  List<T> findMany<T>([bool Function(T value)? where]) {
    final encoder = _getEncoder<T>();
    if (encoder == null) return [];
    return _getList<T>().where(where ?? (value) => true).toList();
  }

  @override
  Future<bool> delete<T>(T value) async {
    try {
      final encoder = _getEncoder<T>();
      if (encoder == null) return false;
      final key = _key<T>(encoder.identifier(value));
      await _prefs.remove(key);
      _cache.remove(key);
      return true;
    } on Exception catch (e) {
      debug.log(e.toString(), name: 'SharedPreferencesService.delete');
      return false;
    }
  }

  List<T> _getList<T>() {
    final encoder = _getEncoder<T>();
    if (encoder == null) return [];
    return _cache.keys
        .where((key) => key.startsWith(_key<T>('')))
        .map(_cache.getString)
        .whereType<String>()
        .map(encoder.decode)
        .whereType<T>()
        .toList();
  }

  String _key<T>(String key) => '${T.toString()}-$key';

  SharedPreferencesEncoder<T>? _getEncoder<T>() {
    final index = _encoders.toList().indexWhere(
      (encoder) => encoder is SharedPreferencesEncoder<T>,
    );
    if (index == -1) return null;
    return _encoders.elementAt(index) as SharedPreferencesEncoder<T>;
  }
}

class _SharedPreferencesServiceMock implements SharedPreferencesService {
  final Map<String, Object?> _values;
  final Set<SharedPreferencesEncoder> _encoders;

  _SharedPreferencesServiceMock(this._values, this._encoders);

  static Future<_SharedPreferencesServiceMock> create({
    Set<SharedPreferencesEncoder>? encoders,
  }) async {
    return _SharedPreferencesServiceMock({}, encoders ?? {});
  }

  @override
  T? find<T>(bool Function(T value) where) {
    final encoder = _getEncoder<T>();
    if (encoder == null) return null;
    final list = _getList<T>();
    return list.firstWhereOrNull(where);
  }

  @override
  List<T> findMany<T>([bool Function(T value)? where]) {
    return _getList<T>().where(where ?? (value) => true).toList();
  }

  @override
  Future<bool> put<T>(T value) async {
    try {
      final encoder = _getEncoder<T>();
      if (encoder == null) return false;
      final key = _key<T>(encoder.identifier(value));
      _values[key] = encoder.encode(value);
      return true;
    } on Exception catch (e) {
      debug.log(e.toString(), name: 'SharedPreferencesService.put');
      return false;
    }
  }

  @override
  Future<bool> delete<T>(T value) async {
    try {
      final encoder = _getEncoder<T>();
      if (encoder == null) return false;
      final key = _key<T>(encoder.identifier(value));
      _values.remove(key);
      return true;
    } on Exception catch (e) {
      debug.log(e.toString(), name: 'SharedPreferencesService.delete');
      return false;
    }
  }

  List<T> _getList<T>() {
    final encoder = _getEncoder<T>();
    if (encoder == null) return [];
    return _values.keys
        .where((key) => key.startsWith(_key<T>('')))
        .map(_values.getString)
        .whereType<String>()
        .map(encoder.decode)
        .whereType<T>()
        .toList();
  }

  String _key<T>(String key) => '${T.toString()}-$key';

  SharedPreferencesEncoder<T>? _getEncoder<T>() {
    final index = _encoders.toList().indexWhere(
      (encoder) => encoder is SharedPreferencesEncoder<T>,
    );
    if (index == -1) return null;
    return _encoders.elementAt(index) as SharedPreferencesEncoder<T>;
  }
}

extension _IterableExt<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

extension _MapExt on Map<String, Object?> {
  String? getString(String key) => this[key] as String?;
}
