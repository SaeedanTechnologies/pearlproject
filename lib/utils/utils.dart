import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static fluttertoast({required String msg}) {
    Fluttertoast.showToast(msg: msg, gravity: ToastGravity.TOP);
  }
}
