// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/components/pop_up_cards/delete_confirmation_message_card.dart';
import 'package:renters_management_front_end/app/components/pop_up_cards/update_build_card.dart';
import 'package:renters_management_front_end/app/models/build_model.dart';
import '../globals.dart';
import 'custom_text.dart';

class BuildCard extends StatelessWidget {
  Build buildInfo;
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
    (height < 200) ? height = 200 : null;
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
              color: Colors.black38,
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 5),
            )
          ],
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              height: ((height - 2) * 0.6),
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: (Get.width - rightPadding) * 0.6,
                        child: Row(
                          children: [
                            SecText(
                              "Build Name:  ",
                              textColor: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                            SecText(
                              buildInfo.name?.value??"Unknown",
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
                                onPressed: edit,
                                icon: Icon(
                                  Icons.edit,
                                  color: textColor,
                                )),
                            IconButton(
                                onPressed: delete,
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
                              buildInfo.city?.value??"Unknown",
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
                              buildInfo.address?.value??"Unknown",
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
                              buildInfo.numRenters?.value.toString()??'0' ,
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
            Container(
              height: (height - 2) * 0.2,
              width: double.maxFinite,
              color: color2,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Center(
                    child: TextButton(
                      onPressed: rentersListRoute,
                      child: SecText(
                        "Renters List",
                        textColor: color1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: rentersListRoute,
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: color1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Container(
              height: (height - 2) * 0.2,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: color2,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Center(
                    child: TextButton(
                      onPressed: buildReportRoute,
                      child: SecText(
                        "Build Reports ",
                        textColor: color1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: buildReportRoute,
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: color1,
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  void edit() {

    Get.dialog(const PopUpIUpdateBuildCard());
  }

  void delete() {
    Get.dialog(PopUpMessageCard(
            "did you sure want delete this build that will delete all data relative to it."));
  }

  void rentersListRoute() {
    Get.toNamed("/rentersList");
  }

  void buildReportRoute() {
    Get.toNamed("/buildReports");
  }
}
