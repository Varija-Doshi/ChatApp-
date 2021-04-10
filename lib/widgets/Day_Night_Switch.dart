import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class Day_Night_Switch extends StatefulWidget {
  @override
  _Day_Night_SwitchState createState() => _Day_Night_SwitchState();
}

class _Day_Night_SwitchState extends State<Day_Night_Switch> {
  /*void _togglePlay() {
    setState(() => _controller.isActive = !_controller.isActive);
  }

  bool get isPlaying => _controller?.isActive ?? false;

  Artboard _riveArtboard;
  RiveAnimationController _controller;

  @override
  void initState() {
    super.initState();

    rootBundle.load('Assets/Rive_Animations/Day_Night.riv').then(
      (data) async {
        final _file = RiveFile();

        if (_file.import(data)) {
          // The artboard is the root of the animation and gets drawn in the
          // Rive widget.
          final artboard = _file.mainArtboard;
          // Add a controller to play back a known animation on the main/default
          // artboard.We store a reference to it so we can toggle playback.
          artboard.addController(_controller = SimpleAnimation('Animation 1'));
          setState(() => _riveArtboard = artboard);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: <Widget>[
        Center(
          child: _riveArtboard == null
              ? const SizedBox()
              : Rive(artboard: _riveArtboard),
        ),
      ]),
    );
  }
}
*/
  bool toggleValue = false;
  toggleButton() {
    setState(() {
      toggleValue = !toggleValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 400),
          height: 40,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color:
                toggleValue ? Colors.yellow : Colors.blue[900].withOpacity(0.5),
          ),
          child: Stack(
            children: <Widget>[
              AnimatedPositioned(
                curve: Curves.easeIn,
                duration: Duration(milliseconds: 500),
                top: 3,
                left: toggleValue ? 60.0 : 0,
                right: toggleValue ? 0 : 60,
                child: InkWell(
                  onTap: toggleButton,
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return RotationTransition(
                        turns: animation,
                        child: child,
                      );
                    },
                    child: toggleValue
                        ? Icon(Icons.check_circle,
                            color: Colors.green, size: 35, key: UniqueKey())
                        : Icon(
                            Icons.remove_circle_outline,
                            color: Colors.red,
                            size: 35,
                            key: UniqueKey(),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
