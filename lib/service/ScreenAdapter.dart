import 'package:flutter_screenutil/screenutil.dart';

class ScreenAdapter {
  static init(context) {
    ScreenUtil.init(context, width: 750, height: 1334);
  }

  static setWidth(double width) {
    return ScreenUtil().setWidth(width);
  }

  static setHeight(double height) {
    return ScreenUtil().setHeight(height);
  }

  static getScreenWidth() {
    return ScreenUtil.screenWidthDp;
  }

  static getScreenHeight() {
    return ScreenUtil.screenHeightDp;
  }

  static size(value) {
    return ScreenUtil().setSp(value);
  }
}
