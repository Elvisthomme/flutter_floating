import 'package:flutter/material.dart';
import 'package:flutter_floating/floating_icon.dart';
import 'package:flutter_floating/floating_scroll.dart';
import 'button_widget.dart';
import 'floating/assist/floating_slide_type.dart';
import 'floating/assist/slide_stop_type.dart';
import 'floating/floating.dart';
import 'floating/listener/event_listener.dart';
import 'floating/manager/floating_manager.dart';
import 'floating_increment.dart';
import 'page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: globalKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Floating'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Floating floatingOne;
  late Floating floatingTwo;

  @override
  void initState() {
    super.initState();

    //Delayed by one frame because it gets the height of the status bar
    floatingOne = floatingManager.createFloating(
        "1",
        Floating(const FloatingIcon(),
            slideType: FloatingSlideType.onRightAndBottom,
            isShowLog: false,
            isSnapToEdge: false,
            isPosCache: true,
            moveOpacity: 1,
            left: 100,
            bottom: 100,
            slideBottomHeight: 100));

    floatingTwo = floatingManager.createFloating(
        "2",
        Floating(
          const FloatingScroll(),
          slideType: FloatingSlideType.onPoint,
          isShowLog: false,
          right: 50,
          isSnapToEdge: true,
          snapToEdgeSpace: 50,
          top: 100,
          slideStopType: SlideStopType.slideStopAutoType,
        ));
    var twoListener = FloatingEventListener()
      ..closeListener = () {
        // var point = floatingTwo.getFloatingPoint();
        // print('Close  ${point.x}      --         ${point.y}');
      }
      ..hideFloatingListener = () {
        // var point = floatingTwo.getFloatingPoint();
        // print('Hide  ${point.x}      --         ${point.y}');
      }
      ..moveEndListener = (point) {
        // var point = floatingTwo.getFloatingPoint();
        // print('End move  ${point.x}      --         ${point.y}');
      };
    floatingTwo.addFloatingListener(twoListener);
  }

  void _startCustomPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const CustomPage();
    }));
  }

  var isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 30),
              ButtonWidget(
                "Show/close the hover window in the upper left corner that doesn't bounce back",
                () {
                  var floating = floatingManager.getFloating("1");
                  floating.isShowing
                      ? floating.close()
                      : floating.open(context);
                },
              ),
              ButtonWidget("Shows a floating window in the upper right corner",
                  () {
                if (!isOpen) {
                  floatingTwo.open(context);
                  isOpen = true;
                } else {
                  floatingTwo.showFloating();
                }
              }),
              ButtonWidget("Hide the upper-right corner hover window", () {
                floatingTwo.hideFloating();
              }),
              ButtonWidget("Adding a hover window without motion animation",
                  () {
                floatingManager
                    .createFloating(
                        DateTime.now().millisecondsSinceEpoch,
                        Floating(const FloatingIcon(),
                            slideType: FloatingSlideType.onLeftAndTop,
                            left: 0,
                            isShowLog: false,
                            isPosCache: true,
                            moveOpacity: 1,
                            top: floatingManager.floatingSize() * 80))
                    .open(context);
              }),
              ButtonWidget(
                  "Add hover window to disable swiping to status bar and bottom",
                  () {
                floatingManager
                    .createFloating(
                        DateTime.now().millisecondsSinceEpoch,
                        Floating(const FloatingIncrement(),
                            slideType: FloatingSlideType.onRightAndBottom,
                            right: 100,
                            bottom: floatingManager.floatingSize() * 80,
                            //Disable swiping to the status bar
                            slideTopHeight: MediaQuery.of(context).padding.top,
                            slideBottomHeight: 60))
                    .open(context);
              }),
              ButtonWidget("jump page", () => _startCustomPage()),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startCustomPage,
        tooltip: 'Increment',
        child: const Text("skip over"),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    super.dispose();
    floatingTwo.close();
  }
}
