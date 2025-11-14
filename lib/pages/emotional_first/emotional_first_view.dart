import 'package:emotional_release/components/emotional_rating_selector.dart';
import 'package:emotional_release/components/emotional_tag_selector.dart';
import 'package:emotional_release/constants/emotional_constants.dart';
import 'package:emotional_release/main.dart';
import 'package:emotional_release/pages/emotional_first/emotional_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'bottle_painter.dart';
import 'smash_painter.dart';
import 'emotional_first_logic.dart';

class EmotionalFirstPage extends GetView<EmotionalFirstLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: <Widget>[
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: <Widget>[
                  const Text(
                    'Emotional release',
                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  <Widget>[
                    Expanded(
                        child: <Widget>[
                      Obx(() {
                        return Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                              color: controller.style.value == 0
                                  ? primaryColor
                                  : primaryColor.withAlpha(100),
                              borderRadius: BorderRadius.circular(17)),
                          alignment: Alignment.center,
                          child: const Text(
                            '1',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w900),
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(() {
                        return Text(
                          'Choosing emotions',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: controller.style.value == 0
                                  ? primaryColor
                                  : primaryColor.withAlpha(100)),
                        );
                      })
                    ].toColumn(mainAxisSize: MainAxisSize.min)),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: <Widget>[
                      Obx(() {
                        return Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                              color: controller.style.value == 1
                                  ? primaryColor
                                  : primaryColor.withAlpha(100),
                              borderRadius: BorderRadius.circular(17)),
                          alignment: Alignment.center,
                          child: const Text(
                            '2',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w900),
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(() {
                        return Text(
                          'Release ritual',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: controller.style.value >= 1 &&
                                      controller.style.value <= 2
                                  ? primaryColor
                                  : primaryColor.withAlpha(100)),
                        );
                      })
                    ].toColumn(mainAxisSize: MainAxisSize.min)),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: <Widget>[
                      Obx(() {
                        return Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                              color: controller.style.value == 2
                                  ? primaryColor
                                  : primaryColor.withAlpha(100),
                              borderRadius: BorderRadius.circular(17)),
                          alignment: Alignment.center,
                          child: const Text(
                            '3',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w900),
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(() {
                        return Text(
                          'Record feelings',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: controller.style.value == 3
                                  ? primaryColor
                                  : primaryColor.withAlpha(100)),
                        );
                      })
                    ].toColumn(mainAxisSize: MainAxisSize.min))
                  ].toRow(),
                  const SizedBox(
                    height: 30,
                  ),
                  
                  <Widget>[
                    Obx(() {
                      return Visibility(
                        visible: controller.style.value == 2 &&
                            controller.releaseType.value == 0,
                        child: Image.asset('assets/icon4.png'),
                      );
                    }),
                    Obx(() {
                      return Visibility(
                        visible: controller.style.value == 2 &&
                            controller.releaseType.value == 0,
                        child: Transform.rotate(
                          angle: controller.tiltAngle.value,
                          child: Container(
                            width: 150,
                            height: 250,
                            child: CustomPaint(
                              painter: BottlePainter(
                                waterLevel: controller.waterLevel.value,
                                tiltAngle: controller.tiltAngle.value,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    Obx(() {
                      return Visibility(
                        visible: controller.style.value == 2 &&
                            controller.releaseType.value == 0,
                        child: Image.asset('assets/icon5.png'),
                      );
                    }),
                  ]
                      .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
                      .marginSymmetric(horizontal: 20),
                  
                  <Widget>[
                    Obx(() {
                      return Visibility(
                        visible: controller.style.value == 2 &&
                            controller.releaseType.value == 1,
                        child: Image.asset('assets/icon4.png'),
                      );
                    }),
                    Obx(() {
                      return Visibility(
                        visible: controller.style.value == 2 &&
                            controller.releaseType.value == 1,
                        child: GestureDetector(
                          onTapDown: (details) {
                            
                            if (controller.smashProgress.value >= 1.0 ||
                                controller.isShowCheck.value) {
                              return;
                            }
                            controller.addSmash(details.localPosition);
                          },
                          child: Transform.rotate(
                            angle: 0, 
                            child: Container(
                              width: 150,
                              height: 250,
                              child: CustomPaint(
                                painter: SmashPainter(
                                  progress: controller.smashProgress.value,
                                  cracks: controller.cracks.toList(),
                                  waterLevel: controller.waterLevel.value,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    Obx(() {
                      return Visibility(
                        visible: controller.style.value == 2 &&
                            controller.releaseType.value == 1,
                        child: Image.asset('assets/icon5.png'),
                      );
                    }),
                  ]
                      .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
                      .marginSymmetric(horizontal: 20),
                  
                  Obx(() {
                    return Visibility(
                        visible: controller.style.value == 0,
                        child: <Widget>[
                          
                          Center(
                            child: Obx(() {
                              return Transform.rotate(
                                angle: controller.tiltAngle.value,
                                child: Container(
                                  width: 150,
                                  height: 250,
                                  child: Obx(() {
                                    return CustomPaint(
                                      painter: BottlePainter(
                                        waterLevel: controller.waterLevel.value,
                                        tiltAngle: controller.tiltAngle.value,
                                      ),
                                    );
                                  }),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 40),
                          
                          const Text(
                            'Choose Your Emotion',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.5),
                          ),
                          const SizedBox(height: 30),
                          
                          Wrap(
                              spacing: 30,
                              runSpacing: 30,
                              alignment: WrapAlignment.center,
                              children: List.generate(
                                  4,
                                  (idx) => InkWell(
                                        onTap: () {
                                          controller.style.value = 1;
                                          controller.type = idx;
                                        },
                                        child: <Widget>[
                                          Image.asset('assets/icon$idx.png'),
                                          Text(moodTypes[idx])
                                        ].toColumn(
                                            mainAxisSize: MainAxisSize.min),
                                      ))).marginOnly(top: 30),
                        ].toColumn(
                            mainAxisAlignment: MainAxisAlignment.center));
                  }),
                  
                  Obx(() {
                    final isValidType = controller.type >= 0 &&
                        controller.type < moodTypes.length;
                    return Visibility(
                        visible: controller.style.value == 1 && isValidType,
                        child: <Widget>[
                          
                          Container(
                            padding: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  primaryColor.withOpacity(0.1),
                                  primaryColor.withOpacity(0.05),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: <Widget>[
                              
                              Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: primaryColor.withOpacity(0.2),
                                      blurRadius: 15,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                    'assets/icon${controller.type}.png',
                                    width: 80,
                                    height: 80),
                              ),
                              const SizedBox(height: 20),
                              
                              Text(
                                isValidType ? moodTypes[controller.type] : '',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                    color: primaryColor),
                              ),
                              const SizedBox(height: 15),
                              
                              Container(
                                width: 50,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(height: 20),
                              
                              Container(
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: <Widget>[
                                  Icon(
                                    Icons.psychology_outlined,
                                    size: 24,
                                    color: primaryColor,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    isValidType
                                        ? (emotionalGuidance[controller.type] ??
                                            '')
                                        : '',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        height: 1.8,
                                        color: Color(0xff444444),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ].toColumn(),
                              ),
                            ].toColumn(),
                          ),
                          const SizedBox(height: 35),
                          
                          <Widget>[
                            Container(
                              width: 40,
                              height: 2,
                              color: primaryColor.withOpacity(0.3),
                            ),
                            const SizedBox(width: 15),
                            const Text(
                              'Choose Your Ritual',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.5),
                            ),
                            const SizedBox(width: 15),
                            Container(
                              width: 40,
                              height: 2,
                              color: primaryColor.withOpacity(0.3),
                            ),
                          ].toRow(mainAxisAlignment: MainAxisAlignment.center),
                          const SizedBox(height: 25),
                          
                          ...List.generate(2, (idx) {
                            return InkWell(
                              onTap: () {
                                controller.releaseType.value = idx;
                                controller.style.value = 2;
                                if (idx == 0) {
                                  controller.startListening();
                                } else {
                                  
                                  controller.waterLevel.value = 1.0;
                                  controller.smashProgress.value = 0.0;
                                  controller.cracks.clear();
                                }
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: double.infinity,
                                margin: const EdgeInsets.only(bottom: 15),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white,
                                      Colors.white,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(
                                      color: primaryColor.withOpacity(0.3),
                                      width: 2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primaryColor.withOpacity(0.08),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: <Widget>[
                                    
                                    Container(
                                      width: 90,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            primaryColor.withOpacity(0.1),
                                            primaryColor.withOpacity(0.05),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Icon(
                                        idx == 0
                                            ? Icons.water_drop_rounded
                                            : Icons.touch_app_rounded,
                                        size: 45,
                                        color: primaryColor,
                                      ),
                                    ),
                                    const SizedBox(width: 18),
                                    
                                    Expanded(
                                      child: <Widget>[
                                        Text(
                                          releaseTypes[idx],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900,
                                              color: primaryColor),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          releaseDescriptions[idx],
                                          style: const TextStyle(
                                              fontSize: 13,
                                              color: Color(0xff666666),
                                              height: 1.5),
                                        ),
                                      ].toColumn(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start),
                                    ),
                                    const SizedBox(width: 10),
                                    
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 20,
                                      color: primaryColor.withOpacity(0.5),
                                    ),
                                    const SizedBox(width: 5),
                                  ].toRow(),
                                ),
                              ),
                            );
                          }),
                        ]
                            .toColumn(
                                mainAxisAlignment: MainAxisAlignment.center)
                            .marginSymmetric(horizontal: 20));
                  }),
                  
                  Obx(() {
                    return Visibility(
                        visible: controller.style.value == 2 &&
                            controller.releaseType.value == 0,
                        child: <Widget>[
                          const Text(
                            'Tilt the phone left and right to pour water',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.w900),
                          ),
                          Obx(() {
                            return Text(
                                    '${((1 - controller.waterLevel.value) * 100).toStringAsFixed(1)} %',
                                    style: const TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w900))
                                .marginSymmetric(vertical: 15);
                          }),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Obx(() {
                              return LinearProgressIndicator(
                                value: 1 - controller.waterLevel.value,
                                backgroundColor: const Color(0xffcecece),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  primaryColor,
                                ),
                                minHeight: 20,
                                borderRadius: BorderRadius.circular(10),
                              );
                            }),
                          ),
                        ]
                            .toColumn(mainAxisSize: MainAxisSize.min)
                            .marginOnly(top: 30));
                  }),
                  
                  Obx(() {
                    return Visibility(
                        visible: controller.style.value == 2 &&
                            controller.releaseType.value == 1,
                        child: <Widget>[
                          const Text(
                            'Tap repeatedly to smash your emotions',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.w900),
                          ),
                          Obx(() {
                            return Text(
                                    '${(controller.smashProgress.value * 100).toStringAsFixed(1)} %',
                                    style: const TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w900))
                                .marginSymmetric(vertical: 15);
                          }),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Obx(() {
                              return LinearProgressIndicator(
                                value: controller.smashProgress.value,
                                backgroundColor: const Color(0xffcecece),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  primaryColor,
                                ),
                                minHeight: 20,
                                borderRadius: BorderRadius.circular(10),
                              );
                            }),
                          ),
                        ]
                            .toColumn(mainAxisSize: MainAxisSize.min)
                            .marginOnly(top: 30));
                  })
                ].toColumn(),
              ),
            ),
          ),
          Obx(() {
            return Visibility(
                visible: controller.isShowCheck.value,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: <Widget>[
                    Image.asset('assets/icon6.png'),
                    const Text(
                      'The water has been emptied',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    ).marginSymmetric(vertical: 20),
                    Container(
                      width: 260,
                      height: 76,
                      alignment: Alignment.center,
                      child: const Text(
                        'Start record',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                    )
                        .decorated(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(38))
                        .gestures(onTap: () {
                      controller.isShowCheck.value = false;
                      controller.style.value = 3;
                    })
                  ].toColumn(mainAxisAlignment: MainAxisAlignment.center),
                ).decorated(color: Colors.black.withAlpha(125)));
          }),
          Obx(() {
            return Visibility(
                visible: controller.style.value == 3,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: SafeArea(
                      child: <Widget>[
                    const Text(
                      'Start record',
                      style:
                          TextStyle(fontSize: 38, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      child: <Widget>[
                        
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: <Widget>[
                            const Text(
                              'How intense is your emotion?',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w900),
                            ),
                            const Text(
                              '(Required)',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            const SizedBox(height: 15),
                            Obx(() => EmotionalRatingSelector(
                                  selectedRating: controller.intensity.value,
                                  onRatingChanged: (rating) {
                                    controller.setIntensity(rating);
                                  },
                                )),
                          ].toColumn(
                              crossAxisAlignment: CrossAxisAlignment.start),
                        ),
                        const SizedBox(height: 20),
                        
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: <Widget>[
                            const Text(
                              'What triggered this emotion?',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w900),
                            ),
                            const Text(
                              '(Optional, select all that apply)',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            const SizedBox(height: 15),
                            Obx(() => EmotionalTagSelector(
                                  availableTags: triggerTags,
                                  selectedTags:
                                      controller.selectedTriggers.toList(),
                                  onTagsChanged: (tags) {
                                    controller.selectedTriggers.value = tags;
                                  },
                                  title: 'Triggers',
                                )),
                          ].toColumn(
                              crossAxisAlignment: CrossAxisAlignment.start),
                        ),
                        const SizedBox(height: 20),
                        
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: <Widget>[
                            const Text(
                              'Any physical sensations?',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w900),
                            ),
                            const Text(
                              '(Optional, select all that apply)',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            const SizedBox(height: 15),
                            Obx(() => EmotionalTagSelector(
                                  availableTags: physicalFeelings,
                                  selectedTags:
                                      controller.selectedFeelings.toList(),
                                  onTagsChanged: (tags) {
                                    controller.selectedFeelings.value = tags;
                                  },
                                  title: 'Physical Feelings',
                                )),
                          ].toColumn(
                              crossAxisAlignment: CrossAxisAlignment.start),
                        ),
                        const SizedBox(height: 20),
                        
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: <Widget>[
                            const Text(
                              'Additional notes',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w900),
                            ),
                            const Text(
                              '(Optional)',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            const SizedBox(height: 15),
                            EmotionalTextField(
                                padding: const EdgeInsets.all(12),
                                value: controller.content,
                                textAlign: TextAlign.start,
                                hintText: 'Record the feelings of release...',
                                maxLines: 10,
                                maxLength: 500,
                                onChange: (v) {
                                  controller.content = v;
                                }),
                          ].toColumn(
                              crossAxisAlignment: CrossAxisAlignment.start),
                        ),
                      ].toColumn(),
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    <Widget>[
                      Expanded(
                          child: Container(
                        height: 76,
                        alignment: Alignment.center,
                        child: const Text(
                          'Save',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w900),
                        ),
                      )
                              .decorated(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(38))
                              .gestures(onTap: () {
                        controller.addData();
                      })),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Container(
                        height: 76,
                        alignment: Alignment.center,
                        child: const Text(
                          'Restart',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w900),
                        ),
                      )
                              .decorated(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(38))
                              .gestures(onTap: () {
                        controller.restart();
                      }))
                    ].toRow().marginOnly(bottom: 10)
                  ].toColumn().marginSymmetric(horizontal: 20)),
                ).decorated(color: bgColor));
          })
        ].toStack(alignment: Alignment.topCenter),
      ),
    );
  }
}
