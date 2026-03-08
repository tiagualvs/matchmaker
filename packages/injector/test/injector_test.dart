import 'package:injector/injector.dart';
import 'package:test/test.dart';

class A extends Module {
  @override
  void bind(Injector i) {
    i.factory<int>(() => 1);
  }
}

class B extends Module {
  @override
  List<Module> get modules => [A()];
}

void main() {
  test('Should add and get an instance', () {
    final injector = Injector.instance..reset();
    injector.singleton<int>(1);
    expect(injector<int>(), 1);
  });

  test('Should add and get a lazy instance', () {
    final injector = Injector.instance..reset();
    injector.lazySingleton<int>(() => 1);
    expect(injector<int>(), 1);
  });

  test('Should throw an exception if the instance is not found', () {
    final injector = Injector.instance..reset();
    expect(() => injector<int>(), throwsA(isA<Exception>()));
  });

  test('Should throw an exception if the instance is already set', () {
    final injector = Injector.instance..reset();
    injector.singleton<int>(1);
    expect(() => injector.singleton<int>(1), throwsA(isA<Exception>()));
  });

  test('Should set a module', () {
    final injector = Injector.instance..reset();
    injector.setModule(B());
    expect(injector<int>(), 1);
  });

  test('Should get a factory instance', () {
    final injector = Injector.instance..reset();
    injector.factory<int>(() => 1);
    expect(injector<int>(), 1);
    expect(injector<int>(), 1);
  });
}
