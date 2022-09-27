import 'dart:math';

import 'package:winners/user_app/core/constants/assets.dart';
import 'package:winners/user_app/core/constants/extensions/widget_extensions.dart';

import 'package:winners/user_app/presentation/resources/fonts_manager.dart';
import 'package:winners/user_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class Wheel extends StatefulWidget {
  const Wheel({Key? key}) : super(key: key);

  @override
  State<Wheel> createState() => _WheelState();
}

class _WheelState extends State<Wheel> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Size size;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _animation =
        Tween<double>(begin: 0, end: pi / Random().nextDouble()).animate(
      _animationController,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  rotateChildContinuously() {
    _animation = Tween<double>(begin: 0, end: pi / Random().nextDouble())
        .animate(_animationController);
    _animationController.forward(from: 0);
  }

  Animation buildAnimation() {
    return _animation;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return _wheelView();
  }

  Widget _wheelView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                Assets.casinoBg,
                width: size.width - 30,
                height: size.height - 120,
                fit: BoxFit.fill,
              ),
              Image.asset(
                Assets.sunlight,
                width: size.width - 30,
                height: size.height - 120,
                fit: BoxFit.fill,
              ),
              Positioned(
                right: 0,
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  height: size.height - 115,
                 
                  padding: const EdgeInsets.only(top: 50, right: 54,bottom: 5),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        Assets.ring,
                        
                        fit: BoxFit.fill,
                      ),
                      AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Positioned(
                                child: Transform.rotate(
                              angle: _animation.value,
                              child: Image.asset(
                                Assets.wheelBg,
                                fit: BoxFit.fill,
                              ).padding(
                                  padding:
                                      const EdgeInsets.all(AppPadding.p12)),
                            ));
                          }),
                      Positioned(
                          child: GestureDetector(
                        onTap: rotateChildContinuously,
                        child: Image.asset(
                          Assets.wheelCenter,
                          width: 80,
                          fit: BoxFit.fill,
                        ),
                      )),
                      
                    ],
                  ),
                ),
              ),
              Stack(
                children: [
                  _payTable(),
                  Align(alignment: Alignment.topRight, child: _gamezTable())
                ],
              ),
              Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text("3544",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: FontSize.s16)),
                              Text(
                                "Game#",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: AppSize.s120,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text("BETS CLOSED",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: FontSize.s16)),
                              Text(
                                "NEXTROUND",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: AppSize.s50,
                          ),
                        ],
                      ).padding(
                          padding:
                              const EdgeInsets.only(bottom: AppPadding.p16)),
                      //             Center(
                      //               child: Container(
                      //                 width: 500,
                      //                 height: 290,
                      //                 padding:  EdgeInsets.only(right: 80,left: 5,bottom:  size.width /
                      //     (size.height / 47)),

                      //   child: Stack(
                      //     alignment: Alignment.center,
                      //     children: [
                      //       Image.asset(
                      //         Assets.ring,
                      //         width: 200,
                      //         height: 200,
                      //       ),
                      //       AnimatedBuilder(
                      //           animation: _animation,
                      //           builder: (context, child) {
                      //               return Positioned(
                      //                   child: Transform.rotate(
                      //                 angle: _animation.value,
                      //                 child: Image.asset(
                      //                   Assets.wheelBg,
                      //                 ).padding(
                      //                     padding: const EdgeInsets.all(AppPadding.p12)),
                      //               ));
                      //           }),
                      //       Positioned(
                      //           child: GestureDetector(
                      //         onTap: rotateChildContinuously,
                      //         child: Image.asset(
                      //           Assets.wheelCenter,
                      //           width: 60,
                      //           fit: BoxFit.fill,
                      //         ),
                      //       )),
                      //     ],
                      //   ),
                      // ),
                      //             ),
                    ],
                  ),
                ],
              ).padding(
                  padding: const EdgeInsets.only(
                      top: AppPadding.p14, bottom: AppPadding.p60))
            ],
          ),
        ],
      ),
    );
  }

  Widget _payTable() {
    return Padding(
      padding: const EdgeInsets.only(
          left: AppPadding.p12, top: AppPadding.p2, bottom: AppPadding.p2),
      child: Container(
        width: 150,
        constraints: BoxConstraints(maxHeight: size.height - 120),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.amber, width: 2)),
        child: ListView(children: [
          Container(
            decoration: BoxDecoration(color: Colors.grey.shade300),
            child: const Text(
              "PAY TABLE",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ).center().padding(padding: const EdgeInsets.all(AppPadding.p6)),
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Colors.amber, width: 1)),
                  child: const Text(
                    "Color",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: FontSize.s12),
                  )
                      .center()
                      .padding(padding: const EdgeInsets.all(AppPadding.p6)),
                ),
              ),
              Expanded(
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border.all(color: Colors.amber, width: 1)),
                  child: const Text(
                    "12",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: FontSize.s10),
                  )
                      .center()
                      .padding(padding: const EdgeInsets.all(AppPadding.p6)),
                ),
              ),
              Expanded(
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Colors.amber, width: 1)),
                  child: const Text(
                    "24",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: FontSize.s10),
                  )
                      .center()
                      .padding(padding: const EdgeInsets.all(AppPadding.p6)),
                ),
              ),
              Expanded(
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(color: Colors.amber, width: 1)),
                  child: const Text(
                    "12",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: FontSize.s10),
                  )
                      .center()
                      .padding(padding: const EdgeInsets.all(AppPadding.p6)),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      border: Border.all(color: Colors.amber, width: 1)),
                  child: const Text(
                    "6",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: FontSize.s12),
                  )
                      .center()
                      .padding(padding: const EdgeInsets.all(AppPadding.p6)),
                ),
              ),
              Expanded(
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border.all(color: Colors.amber, width: 1)),
                  child: const Text(
                    "6",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: FontSize.s10),
                  )
                      .center()
                      .padding(padding: const EdgeInsets.all(AppPadding.p6)),
                ),
              ),
              Expanded(
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(color: Colors.amber, width: 1)),
                  child: const Text(
                    "6",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: FontSize.s10),
                  )
                      .center()
                      .padding(padding: const EdgeInsets.all(AppPadding.p6)),
                ),
              ),
              Expanded(
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent.shade100,
                      border: Border.all(color: Colors.amber, width: 1)),
                  child: const Text(
                    "6",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: FontSize.s10),
                  )
                      .center()
                      .padding(padding: const EdgeInsets.all(AppPadding.p6)),
                ),
              ),
              Expanded(
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade800,
                      border: Border.all(color: Colors.amber, width: 1)),
                  child: const Text(
                    "6",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: FontSize.s10),
                  )
                      .center()
                      .padding(padding: const EdgeInsets.all(AppPadding.p6)),
                ),
              ),
              Expanded(
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      border: Border.all(color: Colors.amber, width: 1)),
                  child: const Text(
                    "6",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: FontSize.s10),
                  )
                      .center()
                      .padding(padding: const EdgeInsets.all(AppPadding.p6)),
                ),
              ),
            ],
          ),
          _numberView("NUMBER", "36"),
          _numberView("DOZENZ", "3"),
          _numberView("ODD/EVEN", "2"),
          _numberView("HOGH/LOW", "2"),
          _numberView("3 LINE", "18"),
          _numberView("CORNER", "12"),
        ]),
      ),
    );
  }

  Widget _numberView(String name, String number) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.amber, width: 1)),
      child: Row(
        children: [
          Expanded(
              child: Text(name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: FontSize.s12))
                  .center()),
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.green.shade900,
                border: Border.all(color: Colors.amber, width: 0.2)),
            child: Text(
              number,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: FontSize.s12),
            ).center(),
          ),
        ],
      ),
    );
  }

  Widget _gamezTable() {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p12),
      child: Container(
        width: 250,
        constraints: BoxConstraints(maxHeight: size.height - 120),
        //  height: 280,

        decoration:
            BoxDecoration(border: Border.all(color: Colors.amber, width: 2)),
        child: ListView(children: [
          _perviousGamez(),
          _frequencyLast(),
          _colorsLast(),
          _dozenzLast(),
          _hotLast()
        ]),
      ),
    );
  }

  Widget _perviousGamez() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              border: Border.all(color: Colors.amber, width: 2)),
          child: const Text(
            "PREVIOUS GAMES",
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: FontSize.s12),
          ).center().padding(padding: EdgeInsets.all(AppPadding.p4)),
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "64790#",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s12),
                )
                    .center()
                    .padding(padding: const EdgeInsets.all(AppPadding.p6)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "2",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s12),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p6)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.amber, width: 1)),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "64790#",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s12),
                )
                    .center()
                    .padding(padding: const EdgeInsets.all(AppPadding.p6)),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "17",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s12),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p6)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.amber, width: 1)),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "64790#",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s12),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p6)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "1",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s12),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p6)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.amber, width: 1)),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "64790#",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s12),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p6)),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "2",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s12),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p6)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.amber, width: 1)),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "64790#",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s12),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p6)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "4",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s12),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p6)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.amber, width: 1)),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "64790#",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s12),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p6)),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "35",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s12),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p6)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.amber, width: 1)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _colorsLast() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              border: Border.all(color: Colors.amber, width: 2)),
          child: const Text(
            "COLORS(LAST 200 DRAWS)",
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: FontSize.s12),
          ).center().padding(padding: const EdgeInsets.all(AppPadding.p4)),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "2",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s12),
                )
                    .center()
                    .padding(padding: const EdgeInsets.all(AppPadding.p6)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "109",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s10),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p6)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "89",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s10),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p6)),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "0",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s12),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p6)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "0",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s10),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p6)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "2",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s10),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p6)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.blueAccent.shade100,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "2",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s10),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p6)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "1",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s10),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p6)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "1",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s10),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p6)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _dozenzLast() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              border: Border.all(color: Colors.amber, width: 2)),
          child: const Text(
            "DOZENZ(LAST 200 DRAWS)",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: FontSize.s12),
          ).center().padding(padding: EdgeInsets.all(AppPadding.p4)),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "1/12",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s12),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p4)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.green.shade900,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "64",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s10),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p4)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "3/24",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s10),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p4)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.green.shade900,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "83",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s10),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p4)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "25/36",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s10),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p4)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.green.shade900,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "53",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s10),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p4)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _hotLast() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              border: Border.all(color: Colors.amber, width: 2)),
          child: const Text(
            "HOT/COLD(LAST 200 DRAWS)",
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: FontSize.s12),
          ).center().padding(padding: EdgeInsets.all(AppPadding.p4)),
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "HOT",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s12),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p4)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "36",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s10),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p6)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "34",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s10),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p6)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "0",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s10),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p6)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "6",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s10),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p6)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "11",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s10),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p6)),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "COLD",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s12),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p4)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "18",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s10),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p6)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "25",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s10),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p6)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "27",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s10),
                )
                    .center()
                    .padding(padding: const EdgeInsets.all(AppPadding.p6)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "7",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s10),
                )
                    .center()
                    .padding(padding: const EdgeInsets.all(AppPadding.p6)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(color: Colors.amber, width: 1)),
                child: const Text(
                  "29",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s10),
                ).center().padding(padding: EdgeInsets.all(AppPadding.p6)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _frequencyLast() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              border: const Border(
                top: const BorderSide(color: Colors.amber, width: 2),
              )),
          child: const Text(
            "FREQUENCY(LAST 200 DRAWS)",
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: FontSize.s12),
          ).center().padding(padding: EdgeInsets.all(AppPadding.p4)),
        ),
        _frequencyItem("1", "8", "13", "25"),
        _frequencyItem("2", "7", "14", "26"),
        _frequencyItem("3", "4", "15", "27"),
      ],
    );
  }

  Widget _frequencyItem(String red1, String green, String red2, String red3) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.red.shade600,
                    border: Border.all(color: Colors.amber, width: 2)),
                child: Text(
                  red1,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s12),
                )
                    .center()
                    .padding(padding: const EdgeInsets.all(AppPadding.p4)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.green.shade900,
                ),
                child: Text(
                  green,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s10),
                )
                    .center()
                    .padding(padding: const EdgeInsets.all(AppPadding.p4)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.red.shade600,
                    border: Border.all(color: Colors.amber, width: 2)),
                child: Text(
                  red2,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s10),
                )
                    .center()
                    .padding(padding: const EdgeInsets.all(AppPadding.p4)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.green.shade900,
                ),
                child: Text(
                  green,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s10),
                )
                    .center()
                    .padding(padding: const EdgeInsets.all(AppPadding.p4)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.red.shade600,
                    border: Border.all(color: Colors.amber, width: 2)),
                child: Text(
                  red3,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s10),
                )
                    .center()
                    .padding(padding: const EdgeInsets.all(AppPadding.p4)),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.green.shade900,
                ),
                child: Text(
                  green,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s10),
                )
                    .center()
                    .padding(padding: const EdgeInsets.all(AppPadding.p4)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
