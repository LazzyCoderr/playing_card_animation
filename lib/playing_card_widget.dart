import 'dart:math';

import 'package:flutter/material.dart';

class PlayingCardAnimation extends StatefulWidget {
  final int? cardLength;
  final List<Color> colors;

  PlayingCardAnimation({Key? key, this.cardLength = 3, required this.colors})
      : assert(cardLength! < 4),

        ///
        assert(colors.length < 4),
        super(key: key);

  @override
  _PlayingCardAnimationState createState() => _PlayingCardAnimationState();
}

class _PlayingCardAnimationState extends State<PlayingCardAnimation>
    with TickerProviderStateMixin {
  final List<AnimationController> _listController = [];
  final List<Animation<double>> _listAnimation = [];
  bool _isCardShow = false;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.cardLength!; i++) {
      _listController.add(
        AnimationController(
          vsync: this,
          duration: const Duration(
            milliseconds: 500,
          ),
        ),
      );
    }

    for (int i = 0; i < widget.cardLength!; i++) {
      _listAnimation.add(
        Tween<double>(begin: 0.0, end: pi * (i / (2 * 10))).animate(
          _listController[i],
        ),
      );
    }
  }

  @override
  void dispose() {
    for (var controller in _listController) {
      controller.dispose();
    }
    super.dispose();
  }

  void _toggleFold() {
    if (_isCardShow) {
      for (var controller in _listController) {
        controller.reverse();
      }
    } else {
      for (var controller in _listController) {
        controller.forward();
      }
    }

    setState(() {
      _isCardShow = !_isCardShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Playing Card Animation"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedPadding(
              duration: const Duration(milliseconds: 500),
              padding: EdgeInsets.only(
                left: _isCardShow ? 0 : 16,
                top: 16,
                right: _isCardShow ? 32 : 16,
                bottom: 16,
              ),
              child: Stack(
                children: List.generate(widget.cardLength!, (index) {
                  return AnimatedBuilder(
                    animation: _listAnimation[index],
                    builder: (context, child) {
                      return Transform(
                        alignment: Alignment.bottomCenter,
                        transform: Matrix4.identity()
                          ..setEntry(2, 3, 0.005)
                          ..rotateZ(_listAnimation[index].value),
                        child: child,
                      );
                    },
                    child: Container(
                      width: 200.0,
                      height: 300.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: widget.colors[index],
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () {
                _toggleFold();
              },
              child: Text(
                _isCardShow ? "Hide Card" : "Show Card",
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
