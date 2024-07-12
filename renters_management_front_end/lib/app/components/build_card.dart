// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../globals.dart';
import 'custom_text.dart';

class BuildCard extends StatelessWidget {
  late var buildInfo;
  double height;
  double type;

  BuildCard({
    super.key,
    required this.buildInfo,
    required this.height,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    Color color1;
    Color color2;
    Color textColor;
    double rightPadding = 70;
    if (type == 0) {
      color1 = AppColors.mainCardColor;
      color2 = AppColors.inverseCardColor;
      textColor = AppColors.secTextColor;
    } else {
      color1 = AppColors.inverseCardColor;
      color2 = AppColors.backColor;
      textColor = AppColors.mainTextColor;
    }
    return Container(
        height: height,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: color1,
          border: Border(
            top: BorderSide(color: color2, width: 5, strokeAlign: 1),
            bottom: BorderSide(color: color2, width: 5, strokeAlign: 1),
            right: BorderSide(color: color2, width: 5, strokeAlign: 1),
            left: BorderSide(color: color2, width: 5, strokeAlign: 1),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 5),
            )
          ],
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: (Get.width - rightPadding) * 0.6,
                        child: Row(
                          children: [
                            SecText(
                              "Builb Name:  ",
                              textColor: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                            SecText(
                              "Name",
                              textColor: textColor,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: (Get.width - rightPadding) * 0.30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.edit,
                                  color: textColor,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.delete,
                                  color: textColor,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: (Get.width - rightPadding) * 0.4,
                        child: Row(
                          children: [
                            SecText(
                              "city:  ",
                              textColor: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                            SecText(
                              "Ibb",
                              textColor: textColor,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            SecText(
                              "address:  ",
                              textColor: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                            SecText(
                              "Arwa Street",
                              textColor: textColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: (Get.width - rightPadding) * 0.4,
                        child: Row(
                          children: [
                            SecText(
                              "No.Renters:  ",
                              textColor: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                            SecText(
                              "20",
                              textColor: textColor,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            SecText(
                              "Total Rent:  ",
                              textColor: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                            SecText(
                              "100,000,000",
                              textColor: textColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: height,
                decoration: BoxDecoration(
                  color: color2,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: color1,
                  ),
                  highlightColor: (type==0)?Colors.white38:Colors.black38,
                ),
              ),
            )
          ],
        ));
  }
}
