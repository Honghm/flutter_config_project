import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common/color_config.dart';

class TextConfigs {
  static final kTextConfig = TextStyle(
    fontSize: ScreenUtil().setSp(40),
    fontWeight: FontWeight.normal,
    color: ColorConfigs.kColor1,
  );
  static final kText80Bold_2 = kTextConfig.copyWith(
    fontSize: ScreenUtil().setSp(80),
    fontWeight: FontWeight.w700,
    color: ColorConfigs.kColor2,
  );
  static final kText35Normal_3 = kTextConfig.copyWith(
    fontSize: ScreenUtil().setSp(35),
    color: ColorConfigs.kColor3,
  );
  static final kText40Normal_2 = kTextConfig.copyWith(
    fontSize: ScreenUtil().setSp(40),
    color: ColorConfigs.kColor2,
  );
  static final kText40Normal_4 = kTextConfig.copyWith(
    fontSize: ScreenUtil().setSp(40),
    color: ColorConfigs.kColor4,
  );
  static final kText72Bold_2 = kTextConfig.copyWith(
    fontSize: ScreenUtil().setSp(72),
    color: ColorConfigs.kColor2,
  );
}
