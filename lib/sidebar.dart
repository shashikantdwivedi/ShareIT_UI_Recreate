import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  AnimationController _animationController;
  StreamController<bool> ifsidebaropenStremController;
  Stream<bool> issidebarsteam;
  StreamSink<bool> isSidebarOpenedSink;

  final _animationDuraion = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuraion);
    ifsidebaropenStremController = PublishSubject<bool>();
  }

  @override
  void dispose() {
    _animationController.dispose();
    ifsidebaropenStremController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;

    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
       setState(){
         isSidebarOpenedSink = true;
       }

      _animationController.reverse();
    } else {
      setState(){
         isSidebarOpenedSink = false;
       }

      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder(
      initialData: false,
      stream: issidebarsteam,
      builder: (context, isSideBaropenAsync) {
        return AnimatedPositioned(
          duration: _animationDuraion,
          top: 0,
          bottom: 0,
          left: isSideBaropenAsync.data ? 0 : 0,
          right: isSideBaropenAsync.data ? 0 : screenWidth - 45,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Color(0xff333aaa),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: Container(
                    width: 35,
                    height: 100,
                    color: Color(0xff333aaa),
                    alignment: Alignment.centerLeft,
                    child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Colors.black,
                        size: 25),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
