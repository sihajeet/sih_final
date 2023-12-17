import 'dart:math';

import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:sih_final/pages/auth/authscreen.dart';
import 'package:sih_final/pages/auth/login.dart';

import '../../constant/constant.dart';

class ItemData {
  final Color color;
  final String image;
  final String text1;
  final String text2;

  ItemData(
      {required this.color,
      required this.image,
      required this.text1,
      required this.text2});
}

/// Example of LiquidSwipe with itemBuilder
class WithBuilder extends StatefulWidget {
  @override
  _WithBuilder createState() => _WithBuilder();
}

class _WithBuilder extends State<WithBuilder> {
  int page = 0;
  late LiquidController liquidController;
  late UpdateType updateType;

  List<ItemData> data = [
    // ItemData(Colors.green, "assets/onboarding/on_boarding_image_2.jpg", "Liked?", tOnBoardingTitle1, tOnBoardingSubTitle1),
    ItemData(
        color: Colors.green,
        image: 'assets/onboarding/on_boarding_image_1.jpg',
        text1: tOnBoardingTitle1,
        text2: tOnBoardingSubTitle1),

    ItemData(
        color: Colors.red,
        image: 'assets/onboarding/on_boarding_image_2.jpg',
        text1: tOnBoardingTitle2,
        text2: tOnBoardingSubTitle2),

    ItemData(
        color: Colors.blue,
        image: 'assets/onboarding/on_boarding_image_3.jpg',
        text1: tOnBoardingTitle3,
        text2: tOnBoardingSubTitle3),
  ];

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return Container(
      width: 25.0,
      child: Center(
        child: Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: SizedBox(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            LiquidSwipe.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  color: data[index].color,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image.asset(
                        data[index].image,
                        height: 300,
                        fit: BoxFit.contain,
                      ),
                      Padding(
                        padding: EdgeInsets.all(index != 4 ? 24.0 : 0),
                      ),
                      index == 4
                          ? const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 70.0),
                              child: ExampleSlider(),
                            )
                          : const SizedBox.shrink(),
                      Column(
                        children: <Widget>[
                          Text(
                            data[index].text1,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            data[index].text2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              positionSlideIcon: 0.8,
              slideIconWidget: const Icon(Icons.arrow_back_ios),
              onPageChangeCallback: pageChangeCallback,
              waveType: WaveType.liquidReveal,
              liquidController: liquidController,
              fullTransitionValue: 880,
              enableSideReveal: true,
              preferDragFromRevealedArea: true,
              enableLoop: true,
              ignoreUserGestureWhileAnimating: true,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  const Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(data.length, _buildDot),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextButton(
                  onPressed: () {
                    liquidController.animateToPage(
                        page: data.length - 1, duration: 700);
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.01),
                      foregroundColor: Colors.black),
                  child: const Text("Skip to End"),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextButton(
                  onPressed: () {
                    if (liquidController.currentPage + 1 > data.length - 1 ) {
                      // Navigate to a new screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AuthScreen(),
                        ),
                      );
                    }
                    liquidController.jumpToPage(
                        page: liquidController.currentPage + 1 > data.length - 1
                            ? 0
                            : liquidController.currentPage + 1);
                  },
                  child: const Text("Next"),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.01),
                      foregroundColor: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
    // Check if we should navigate to a new screen
    if (page + 1 > data.length ) {
      // Navigate to a new screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }
  }
}

class ExampleSlider extends StatefulWidget {
  const ExampleSlider({Key? key}) : super(key: key);

  @override
  State<ExampleSlider> createState() => _ExampleSliderState();
}

class _ExampleSliderState extends State<ExampleSlider> {
  double sliderVal = 0;

  @override
  Widget build(BuildContext context) {
    return Slider(
        value: sliderVal,
        activeColor: Colors.white,
        inactiveColor: Colors.red,
        onChanged: (val) {
          setState(() {
            sliderVal = val;
          });
        });
  }
}
