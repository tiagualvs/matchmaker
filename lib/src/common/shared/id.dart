import 'package:uuid/uuid.dart';
import 'package:uuid/v7.dart';

class Id {
  const Id._();

  static String generate() => const UuidV7().generate();

  static String min() => '00000000-0000-0000-0000-000000000000';

  static String max() => 'ffffffff-ffff-ffff-ffff-ffffffffffff';

  static bool valid(String id) => _isUuidV7Valid(id);

  static bool lt(String a, String b) {
    if (!valid(a) || !valid(b)) return false;

    return a.compareTo(b) < 0;
  }

  static bool lte(String a, String b) {
    if (!valid(a) || !valid(b)) return false;

    return a.compareTo(b) <= 0;
  }

  static bool gt(String a, String b) {
    if (!valid(a) || !valid(b)) return false;

    return a.compareTo(b) > 0;
  }

  static bool gte(String a, String b) {
    if (!valid(a) || !valid(b)) return false;

    return a.compareTo(b) >= 0;
  }

  static bool _isUuidV7Valid(String id) {
    if (!Uuid.isValidUUID(fromString: id)) return false;

    final version = id.split('-')[2][0];

    return version == '7';
  }
}
