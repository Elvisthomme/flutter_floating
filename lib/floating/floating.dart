import 'package:flutter/cupertino.dart';
import 'package:flutter_floating/floating/assist/point.dart';
import 'package:flutter_floating/floating/assist/slide_stop_type.dart';
import 'package:flutter_floating/floating/control/common_control.dart';
import 'package:flutter_floating/floating/listener/event_listener.dart';
import 'package:flutter_floating/floating/manager/scroll_position_manager.dart';
import 'package:flutter_floating/floating/utils/floating_log.dart';
import 'package:flutter_floating/floating/view/floating_view.dart';

import 'assist/floating_data.dart';
import 'assist/floating_slide_type.dart';
import 'control/scroll_position_control.dart';

/// @name：floating
/// @package：
/// @author：345 QQ:1831712732
/// @time：2022/02/10 14:23
/// @des：

class Floating {
  late OverlayEntry _overlayEntry;

  late FloatingView _floatingView;

  late FloatingData _floatingData;

  late ScrollPositionControl _scrollPositionControl;
  late ScrollPositionManager _scrollPositionManager;

  late CommonControl _commonControl;

  final List<FloatingEventListener> _listener = [];

  late FloatingLog _log;
  String logKey = "";

  ///Whether the floating window is currently being displayed
  bool get isShowing => _isShowing;
  bool _isShowing = false;

  ///[child] widget that needs to be hovered.
  ///[slideType]，see [FloatingSlideType]
  ///
  ///[top],[left],[left],[bottom] corresponds to [slideType]，
  ///For example to set [slideType] to [FloatingSlideType.onRightAndBottom], you need to pass [bottom] and [right]
  ///
  ///[isPosCache] when enabled, when [Floating.close] is called and [Floating.open] is called again, it will keep the previous position.
  ////[isSnapToEdge] if or not automatically snap to the edge, default is true, please note that moving has transparent animation by default, if you need to turn off the transparent animation.
  //// Please change [moveOpacity] to 1.
  ///[slideTopHeight] The distance to the top of the slide.
  ///[slideBottomHeight] the distance to the bottom of the slide.
  ///[slideStopType] where to stop back after a move [lideStopType]
  Floating(
    Widget child, {
    FloatingSlideType slideType = FloatingSlideType.onRightAndBottom,
    double? top,
    double? left,
    double? right,
    double? bottom,
    Point<double>? point,
    double moveOpacity = 0.3,
    bool isPosCache = true,
    bool isShowLog = true,
    bool isSnapToEdge = true,
    bool isStartScroll = true,
    double slideTopHeight = 0,
    double slideBottomHeight = 0,
    double snapToEdgeSpace = 0,
    SlideStopType slideStopType = SlideStopType.slideStopAutoType,
  }) {
    _floatingData = FloatingData(slideType,
        left: left,
        right: right,
        top: top,
        bottom: bottom,
        point: point,
        snapToEdgeSpace: snapToEdgeSpace);
    _log = FloatingLog(isShowLog);
    _commonControl = CommonControl();
    _commonControl.setInitIsScroll(isStartScroll);
    _scrollPositionControl = ScrollPositionControl();
    _scrollPositionManager = ScrollPositionManager(_scrollPositionControl);
    _floatingView = FloatingView(
      child,
      _floatingData,
      isPosCache,
      isSnapToEdge,
      _listener,
      _scrollPositionControl,
      _commonControl,
      _log,
      moveOpacity: moveOpacity,
      slideTopHeight: slideTopHeight,
      slideBottomHeight: slideBottomHeight,
      slideStopType: slideStopType,
    );
  }

  /// Open the floating window.
  /// Use this method with [close] method, calling this method after [close] will lose Floating state.
  /// Otherwise please use [hideFloating] to hide and [showFloating] to show instead of [close].
  open(BuildContext context) {
    if (_isShowing) return;
    _overlayEntry = OverlayEntry(builder: (context) {
      return _floatingView;
    });
    Overlay.of(context).insert(_overlayEntry);
    _isShowing = true;
    _notifyOpen();
  }

  ///Close the floating window.
  close() {
    if (!_isShowing) return;
    _overlayEntry.remove();
    _isShowing = false;
    _notifyClose();
  }

  /// Hide the hover window and keep its state
  /// Only available when the hover window is displayed, otherwise the call is invalid
  hideFloating() {
    if (!_isShowing) return;
    _commonControl.setFloatingHide(true);
    _isShowing = false;
    _notifyHideFloating();
  }

  /// Show the hover window and restore its state
  /// Only available if the hover window is hidden, otherwise the call is invalid
  showFloating() {
    if (_isShowing) return;
    _commonControl.setFloatingHide(false);
    _isShowing = true;
    _notifyShowFloating();
  }

  ///Adding a Listener
  addFloatingListener(FloatingEventListener listener) {
    _listener.contains(listener) ? null : _listener.add(listener);
  }

  /// Sets whether or not to enable hover window scrolling.
  ///[isScroll] true means enable, otherwise disable
  setIsStartScroll(bool isScroll) {
    _commonControl.setIsStartScroll(isScroll);
  }

  ///Sets the [FloatingLog] flag.
  setLogKey(String key) {
    _log.logKey = key;
  }

  /// Get scroll manager
  ScrollPositionManager getScrollManager() {
    return _scrollPositionManager;
  }

  ///Get the floating window position [Size.width] means distance from left, [Size.height] means distance from top.
  Point getFloatingPoint() {
    return _commonControl.getFloatingPoint();
  }

  _notifyClose() {
    _log.log("Close");
    for (var listener in _listener) {
      listener.closeListener?.call();
    }
  }

  _notifyOpen() {
    _log.log("Open");
    for (var listener in _listener) {
      listener.openListener?.call();
    }
  }

  _notifyHideFloating() {
    _log.log("Hide");
    for (var listener in _listener) {
      listener.hideFloatingListener?.call();
    }
  }

  _notifyShowFloating() {
    _log.log("Show");
    for (var listener in _listener) {
      listener.showFloatingListener?.call();
    }
  }
}
