import 'package:flutter/material.dart';
import 'package:g_logo_animation/const.dart';
import 'package:rive/rive.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}


late SMITrigger _start;

void _load(Artboard artboard) async {
  final controller =
      StateMachineController.fromArtboard(artboard, stateMachineName);
  artboard.addController(controller!);

  _start = controller.findSMI(smiStart);
}

void _startAnimation() => _start.fire();

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
                _startAnimation();
            },
            icon: const Icon(
              Icons.start,
              color: Colors.blue,
            ),
          ),
          IconButton(
            onPressed: () {
              _load((_start.controller.artboard)!);
            },
            icon: const Icon(
              Icons.restart_alt,
              color: Colors.blue,
            ),
          ),
              ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: const RiveAnimation.asset(
          rive,
          onInit: _load,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
