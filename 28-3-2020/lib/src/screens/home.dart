import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'cat.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {

  Animation<double> _animation;
  AnimationController _animationController;

  Animation<double> _boxAnimation;
  AnimationController _boxController;

  @override
  void initState() {
    super.initState();

    _boxController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65).animate(
      CurvedAnimation(
        parent: _boxController,
        curve: Curves.linear
      )
    );

    _boxController.forward();
    _boxController.addStatusListener((status) {
      if(status == AnimationStatus.completed)
        _boxController.reverse();
      else if(status == AnimationStatus.dismissed)
        _boxController.forward();
    });


    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200)
    );
    _animation = Tween(begin: -30.0, end: -80.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        child: Center(
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              catAnimation(),
              boxBuilder(),
              buildLeftFlap(),
              buildRightFlap()
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget boxBuilder() {
    return Container(
      width: 200,
      height: 200,
      color: Colors.brown,
    );
  }

  Widget catAnimation() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned(
          child: child,
          top: _animation.value,
          right: 0,
          left: 0,
        );
      },
      child: Cat(),
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
      left: 7,
      top: 3,
      child: AnimatedBuilder(
        animation: _boxAnimation,
        child: Container(
          height: 10,
          width: 125,
          color: Colors.brown,
        ),
        builder: (context, child) {
          return Transform.rotate(
            angle: _boxAnimation.value,
            alignment: Alignment.topLeft,
            child: child,
          );
        }
      ),
    );
  }

  Widget buildRightFlap() {
    return Positioned(
      right: 7,
      top: 4,
      child: AnimatedBuilder(
          animation: _boxAnimation,
          child: Container(
            height: 10,
            width: 125,
            color: Colors.brown,
          ),
          builder: (context, child) {
            return Transform.rotate(
              angle: -_boxAnimation.value,
              alignment: Alignment.topRight,
              child: child,
            );
          }
      ),
    );
  }

  onTap() {
    if(_animation.status == AnimationStatus.completed) {
      _boxController.forward();
      _animationController.reverse();
    } else if(_animation.status == AnimationStatus.dismissed) {
      _boxController.stop();
      _animationController.forward();
    }
  }
}
