import 'package:flutter_floating/floating/assist/point.dart';

/// @name：FloatingListener
/// @package：
/// @author：345 QQ:1831712732
/// @time：2022/02/11 23:16
/// @des：

class FloatingEventListener {
  ///Called when opening the Floating window
  Function? openListener;

  ///Called when closing the Floating window
  Function? closeListener;

  ///Called when hiding the Floating Window
  Function? hideFloatingListener;

  ///Called when showing Floating Window
  Function? showFloatingListener;

  ///Called when pressing down the Floating Window
  Function(Point<double>)? downListener;

  /// Called when pressing up the Floating Window
  Function(Point<double>)? upListener;

  /// Called when moving the Floating Window
  Function(Point<double>)? moveListener;

  /// Called on moving end the Floating Window
  Function(Point<double>)? moveEndListener;
}
