import '../constants/constants.dart';
class Util {
  static String orEmpty(dynamic constant) {
    if (constant != null && constant is String) {
      return constant;
    } else {
      return Constants.empty;
    }
  }
}
