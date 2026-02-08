import 'package:flutter/material.dart';
import 'package:matchmaker/src/common/shared/result.dart';

abstract class Command<T> extends ChangeNotifier {
  bool _running = false;

  bool get running => _running;

  bool get completed => _result is Value<T>;

  bool get error => _result is Error<T>;

  Result<T>? _result;

  T getValue() {
    if (_result is Value<T>) {
      return (_result as Value<T>).value;
    }

    throw Exception('Theres no Value in this command!');
  }

  Exception getError() {
    if (_result is Error<T>) {
      return (_result as Error<T>).error;
    }

    throw Exception('Theres no Error in this command!');
  }

  S fold<S>(S Function(T value) onValue, S Function(Exception error) onError) {
    if (completed) return onValue(getValue());

    if (error) return onError(getError());

    throw Exception('Theres no Value or Error in this command!');
  }

  Future<void> _execute(Future<Result<T>> action) async {
    if (_running) return;

    _running = true;

    notifyListeners();

    _result = await action;

    _running = false;

    notifyListeners();
  }
}

class Command0<T> extends Command<T> {
  final Future<Result<T>> action;

  Command0(this.action);

  Future<void> call() async {
    return await _execute(action);
  }
}

class Command1<T, A> extends Command<T> {
  final Future<Result<T>> Function(A args) action;

  Command1(this.action);

  Future<void> call(A args) async {
    return await _execute(action(args));
  }
}
