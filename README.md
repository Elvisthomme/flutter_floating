# floating

![68747470733a2f2f67697465652e636f6d2f6c766b6e6167696e6973742f7069632d676f2d7069637572652d6265642f7261772f6d61737465722f696d616765732f32303232303231363138343530302e6a706567](https://raw.githubusercontent.com/LvKang-insist/PicGo/main/202206141432981.jpg)

**Floating** is a flexible and powerful floating window solution.



Features

- Global floating window management mechanism
- Support various callback listeners, such as movement, touch events, etc.
- Support customizing whether to save the position information of the floating window
- Support single-page and global usage, can insert multiple floating windows
- Support customizing prohibited sliding areas, such as sliding within the area 50 pixels from the top to the bottom
- Comprehensive logging system, can view logs for different floating windows
- Support customizing position orientation and various indicators of the floating window
- Support boundary rebound, automatic edge adsorption (whether to adsorb, adsorption position can be selected), multi-finger touch movement, adaptive screen rotation, and small window scenarios
- Adaptive floating window size
- Adapt to floating window animation, adjust the position when the size of the floating window changes
- Change the floating window position within the code
- .....

### How to Open

The project has been migrated to Flutter 3.0. The current SDK used is Flutter 3.0.3. Versions below 3.0 may not be compatible. Please upgrade your Flutter SDK manually.
```
flutter_floating:
  git: "https://github.com/Elvisthomme/flutter_floating.git" 
```
#### Renderings

|                   Overall situation                          |                        Small screen                          |                        Zoom screen                       |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| ![Full Screen Hover Window](https://cdn.jsdelivr.net/gh/LvKang-insist/PicGo/202202171737802.gif) | ![Small-screen hover window](https://cdn.jsdelivr.net/gh/LvKang-insist/PicGo/202202172155850.gif) | ![Zoom Screen](https://cdn.jsdelivr.net/gh/LvKang-insist/PicGo/202202172155135.gif) |
|                      Rotate screen                         |                           Multi-finger swipe                           |                                                              |
| ![Rotate the screen](https://cdn.jsdelivr.net/gh/LvKang-insist/PicGo/202202171740609.gif) | ![Multi-finger swipe](https://cdn.jsdelivr.net/gh/LvKang-insist/PicGo/202202171740850.gif) |                                                              |

### Freely controllable log viewing

When creating a floating window, `isShowLog` it is controlled through attributes. Different floating window Logs will be displayed through different keys.

```dart
I/flutter (24648): Floating_Log 1 ： Press down X:0.0 Y:150.0
I/flutter (24648): Floating_Log 1 ： Press up X:0.0 Y:150.0
I/flutter (24648): Floating_Log 1 ： Movement X:0.36363636363636687 Y:150.0
I/flutter (24648): Floating_Log 1 ： Movement X:0.36363636363636687 Y:149.63636363636363
I/flutter (24648): Floating_Log 1 ： Movement X:0.7272727272727337 Y:149.63636363636363
I/flutter (24648): Floating_Log 1 ： Movement X:1.0909090909091006 Y:149.27272727272725
I/flutter (24648): Floating_Log 1 ： Movement X:1.4545454545454675 Y:149.27272727272725
I/flutter (24648): Floating_Log 1 ： Movement X:1.4545454545454675 Y:148.90909090909088
I/flutter (24648): Floating_Log 1 ： Movement X:0.0 Y:145.9999999999999
I/flutter (24648): Floating_Log 1 ： End of move X:0.0 Y:145.9999999999999
```

```dart
I/flutter (24648): Floating_Log 1645091422285 ： Press down X:342.72727272727275 Y:480.9090909090909
I/flutter (24648): Floating_Log 1645091422285 ： Press up X:342.72727272727275 Y:480.9090909090909
I/flutter (24648): Floating_Log 1645091422285 ： Movement X:342.72727272727275 Y:480.5454545454545
I/flutter (24648): Floating_Log 1645091422285 ： Movement X:342.72727272727275 Y:480.18181818181813
I/flutter (24648): Floating_Log 1645091422285 ： Movement X:342.72727272727275 Y:479.81818181818176
I/flutter (24648): Floating_Log 1645091422285 ： Movement X:342.72727272727275 Y:479.4545454545454
I/flutter (24648): Floating_Log 1645091422285 ： Movement X:342.72727272727275 Y:479.090909090909
I/flutter (24648): Floating_Log 1645091422285 ： Movement X:342.72727272727275 Y:478.72727272727263
```



### How to use

#### Optional parameters

```dart
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
  double moveOpacity = 0.3,
  bool isPosCache = true,
  bool isShowLog = true,
  bool isSnapToEdge = true,
  this.slideTopHeight = 0,
  this.slideBottomHeight = 0,
  SlideStopType slideStopType = SlideStopType.slideStopAutoType,
})
```

#### Global floating window

Global floating windows are managed through FloatingManager

- Create a floating window

  ```dart
    floatingOne = floatingManager.createFloating(
          "1",///key
          Floating(const FloatingIncrement(),
              slideType: FloatingSlideType.onLeftAndTop,
              isShowLog: false,
              slideBottomHeight: 100));
  ```

- 通过 Obtain the floating window corresponding to the key through FloatingManager

  ```dart
  floatingManager.getFloating("1");
  ```

- Close the floating window corresponding to the key

  ```dart
  floatingManager.closeFloating("1");
  ```

- Close all floating windows

  ```dart
  floatingManager.closeAllFloating();
  ```

- .....

#### Single floating window creation

A single floating window can be used on a certain page and can be closed after exiting the page.

```dart
class CustomPage extends StatefulWidget {
  const CustomPage({Key? key}) : super(key: key);

  @override
  _CustomPageState createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> {
  late Floating floating;

  @override
  void initState() {
    super.initState();
    floating = Floating(const FloatingIncrement(),
        slideType: FloatingSlideType.onLeftAndTop,
        isShowLog: false,
        slideBottomHeight: 100);
    floating.open();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Function page"),
      ),
      body: Container(),
    );
  }

  @override
  void dispose() {
    floating.close();
    super.dispose();
  }
}
```


#### Add various callbacks for floating windows

```dart
var oneListener = FloatingListener()
  ..openListener = () {
    print('Display 1');
  }
  ..closeListener = () {
    print('Close 1');
  }
  ..downListener = (x, y) {
    print('Press down 1.');
  }
  ..upListener = (x, y) {
    print('Press up 1');
  }
  ..moveListener = (x, y) {
    print('Move $x $y 1');
  }
  ..moveEndListener = (x, y) {
    print('End of move $x  $y  1');
  };
floatingOne.addFloatingListener(oneListener);
```

### Other ways to use

- [How to use](https://github.com/Elvisthomme/flutter_floating/tree/master/lib/main.dart)
- [Corresponding method of floating window](https://github.com/Elvisthomme/flutter_floating/tree/master/lib/floating/floating.dart)
- [Corresponding method of global floating window management](https://github.com/Elvisthomme/flutter_floating/tree/master/lib/floating/manager/floating_manager.dart)
- [Modify the position of the floating window](https://github.com/Elvisthomme/flutter_floating/tree/master/lib/floating/manager/scroll_position_manager.dart)


