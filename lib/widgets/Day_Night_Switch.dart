import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

// ignore: camel_case_types
class Day_Night_Switch extends StatefulWidget {
  @override
  _Day_Night_SwitchState createState() => _Day_Night_SwitchState();
}

// ignore: camel_case_types
class _Day_Night_SwitchState extends State<Day_Night_Switch> {
  void _togglePlay() {
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
        FloatingActionButton(
          onPressed: _togglePlay,
          tooltip: isPlaying ? 'Pause' : 'Play',
          child: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ]),
    );
  }
}
