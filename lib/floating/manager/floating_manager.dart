import 'package:flutter/cupertino.dart';

import '../floating.dart';

/// @name：floating_manager
/// @package：
/// @author：345 QQ:1831712732
/// @time：2022/02/11 14:50
/// @des：[Floating] administrator

FloatingManager floatingManager = FloatingManager();

class FloatingManager {
  FloatingManager._single();

  static final FloatingManager _manager = FloatingManager._single();

  factory FloatingManager() => _manager;

  final Map<Object, Floating> _floatingCache = {};

  static TransitionBuilder init({TransitionBuilder? builder}) {
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(context, child);
      }
      return Container(child: child);
    };
  }

  ///Creating a globally manageable [Floating]
  Floating createFloating(Object key, Floating floating) {
    bool contains = _floatingCache.containsKey(key);
    if (!contains) {
      _floatingCache[key] = floating..setLogKey(key.toString());
    }
    return _floatingCache[key]!;
  }

  ///Get the corresponding [Floating] from [key].
  Floating getFloating(Object key) {
    return _floatingCache[key]!;
  }

  ///Close [Floating] for [key].
  closeFloating(Object key) {
    var floating = _floatingCache[key];
    floating?.close();
    _floatingCache.remove(key);
  }

  ///Close all [Floating]
  closeAllFloating() {
    _floatingCache.forEach((key, value) => value.close());
    _floatingCache.clear();
  }

  ///Number of floating windows
  int floatingSize() {
    return _floatingCache.length;
  }
}
