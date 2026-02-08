import 'package:go_router/go_router.dart';

extension GoRouterExt on GoRouterState {
  int getPathParam(String key) {
    return int.parse(pathParameters[key] ?? '0');
  }
}
