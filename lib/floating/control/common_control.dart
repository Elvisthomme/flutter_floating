import 'package:flutter_floating/floating/assist/point.dart';

/// @name：common_control
/// @package：
/// @author：345 QQ:1831712732
/// @time：2023/04/17 20:29
/// @des： Generic callbacks

class CommonControl {
  Function(bool isHide)? _hideControl;
  Function(bool isScroll)? _startScroll;
  Point<double> point = Point(0, 0);
  Function(Point<double> point)? _floatingPoint;
  bool _initIsScroll = false;

  ///Setting the Floating position listener
  setFloatingPoint(Function(Point<double> point) floatingPoint) {
    _floatingPoint = floatingPoint;
  }

  /// Get Floating Location
  Point<double> getFloatingPoint() {
    _floatingPoint?.call(point);
    return point;
  }

  ///Sets whether sliding is possible at initialization
  setInitIsScroll(bool initIsScroll) {
    _initIsScroll = initIsScroll;
  }

  ///Get the state of whether the initialiZation is slidable or not
  bool getInitIsScroll() {
    return _initIsScroll;
  }

  ///Set whether to listen for sliding
  setIsStartScrollListener(Function(bool isScroll) fun) {
    _startScroll = fun;
  }

  ///Set whether to slide
  setIsStartScroll(bool isScroll) {
    _startScroll?.call(isScroll);
  }

  ///Setting the hidden state
  setFloatingHide(bool isHide) {
    _hideControl?.call(isHide);
  }

  ///Setting up a hidden listener
  setHideControlListener(Function(bool isHide) hideControl) {
    _hideControl = hideControl;
  }
}
