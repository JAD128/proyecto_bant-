import 'package:uuid/uuid.dart';

class GeneradorIds {
  static const Uuid _uuid = Uuid();

  static String nuevo() => _uuid.v4();
}
