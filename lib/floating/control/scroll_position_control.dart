/// @name：change_position_listener
/// @package：
/// @author：345 QQ:1831712732
/// @time：2023/03/28 17:47
/// @des：
class ScrollPositionControl {
  /// Slide time
  int timeMillisecond = 300;

  /// Slide from the current position to the distance from top
  Function(double top)? _scrollTop;

  /// Slide from the current position to the left [left] position
  Function(double left)? _scrollLeft;

  /// Scroll from the current position to the right.
  Function(double right)? _scrollRight;

  /// Scroll from the current position to the bottom.
  Function(double bottom)? _scrollBottom;

  /// Scroll from the current position to the top and left.
  Function(double top, double left)? _scrollTopLeft;

  /// Scroll from the current position to the top and the right.
  Function(double bottom, double left)? _scrollBottomLeft;

  /// Scroll from the current position to the bottom [bottom] and the right [right].
  Function(double top, double right)? _scrollTopRight;

  /// Scroll from the current position to the bottom [bottom] and the right [right].
  Function(double bottom, double right)? _scrollBottomRight;

  setScrollTime(int timeMillisecond) {
    this.timeMillisecond = timeMillisecond;
  }

  getScrollTime() {
    return timeMillisecond;
  }

  setScrollTop(Function(double top) scrollTop) {
    _scrollTop = scrollTop;
  }

  setScrollLeft(Function(double left) scrollLeft) {
    _scrollLeft = scrollLeft;
  }

  setScrollRight(Function(double right) scrollRight) {
    _scrollRight = scrollRight;
  }

  setScrollBottom(Function(double bottom) scrollBottom) {
    _scrollBottom = scrollBottom;
  }

  setScrollTopLeft(Function(double top, double left) scrollTopLeft) {
    _scrollTopLeft = scrollTopLeft;
  }

  setScrollBottomLeft(Function(double bottom, double left) scrollBottomLeft) {
    _scrollBottomLeft = scrollBottomLeft;
  }

  setScrollTopRight(Function(double top, double right) scrollTopRight) {
    _scrollTopRight = scrollTopRight;
  }

  setScrollBottomRight(
      Function(double bottom, double right) scrollBottomRight) {
    _scrollBottomRight = scrollBottomRight;
  }

  scrollTop(double top) {
    _scrollTop?.call(top);
  }

  scrollLeft(double left) {
    _scrollLeft?.call(left);
  }

  scrollRight(double right) {
    _scrollRight?.call(right);
  }

  scrollBottom(double bottom) {
    _scrollBottom?.call(bottom);
  }

  scrollTopLeft(double top, double left) {
    _scrollTopLeft?.call(top, left);
  }

  scrollBottomLeft(double bottom, double left) {
    _scrollBottomLeft?.call(bottom, left);
  }

  scrollTopRight(double top, double right) {
    _scrollTopRight?.call(top, right);
  }

  scrollBottomRight(double bottom, double right) {
    _scrollBottomRight?.call(bottom, right);
  }
}
