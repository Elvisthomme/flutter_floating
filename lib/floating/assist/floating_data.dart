import 'package:flutter_floating/floating/assist/point.dart';

import 'floating_slide_type.dart';

/// @name：floating_data
/// @package：
/// @author：345 QQ:1831712732
/// @time：2022/02/10 17:35
/// @des：Hover window data logging

class FloatingData {
  double? left;

  double? top;

  double? right;

  double? bottom;

  double snapToEdgeSpace = 0;

  Point<double>? point;

  FloatingSlideType slideType;

  FloatingData(
    this.slideType, {
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.point,
    this.snapToEdgeSpace = 0,
  });
}
