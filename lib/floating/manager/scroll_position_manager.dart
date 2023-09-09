import '../control/scroll_position_control.dart';

/// @name：scroll_position_manager
/// @package：
/// @author：345 QQ:1831712732
/// @time：2023/03/29 11:08
/// @des： Manually control the hover window scroll manager, get it via [Floating.scrollManager].

class ScrollPositionManager {
  final ScrollPositionControl _control;

  ScrollPositionManager(this._control);

  setScrollTime(int timeMillis) {
    _control.setScrollTime(timeMillis);
  }

  /// Slide from the current position to the distance [top] from the top.
  scrollTop(double top) {
    _control.scrollTop(top);
  }

  /// Slide from the current to the distance [left] from the left.
  scrollLeft(double left) {
    _control.scrollLeft(left);
  }

  /// Slide from the current to the distance [right] from the right.
  scrollRight(double right) {
    _control.scrollRight(right);
  }

  /// Slide from the current position to the distance [bottom] from the bottom.
  scrollBottom(double bottom) {
    _control.scrollBottom(bottom);
  }

  /// Slide from the current to the distance top from the [top] and left the [left].
  scrollTopLeft(double top, double left) {
    _control.scrollTopLeft(top, left);
  }

  /// Scroll from the current position to distance [top] from the top and [left] from the left.
  scrollTopRight(double top, double right) {
    _control.scrollTopRight(top, right);
  }

  /// Scroll from the current position to distance [bottom] from the bottom and [left] from the left.
  scrollBottomLeft(double bottom, double left) {
    _control.scrollBottomLeft(bottom, left);
  }

  /// Slide from the current to the distance [top] from the top and [right] from the right.
  scrollBottomRight(double bottom, double right) {
    _control.scrollBottomRight(bottom, right);
  }
}
