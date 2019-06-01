import 'dart:math';

class Unique {
  ///创建唯一标识
  static String create() {
    int millisecondsSinceEpoch = new DateTime.now().millisecondsSinceEpoch;
    String unique = "$millisecondsSinceEpoch";
    int random = Random().nextInt(5);
    unique = "$unique$random";
    return unique;
  }
}
