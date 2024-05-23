import 'package:fluttertoast/fluttertoast.dart';
import 'package:jetcare/src/core/constants/app_colors.dart';

class DefaultToast {
  static Future<bool?> showMyToast(String msg,
      {bool? isError, Toast? toastLength}) async {
    return await Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength ??
          (msg.length > 60 ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT),
      gravity: ToastGravity.BOTTOM,
      backgroundColor: isError == true ? AppColors.red : null,
      textColor: AppColors.white,
      fontSize: 14.0,
    );
  }
}
