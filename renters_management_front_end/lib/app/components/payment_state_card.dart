// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/models/build_model.dart';
import 'package:renters_management_front_end/app/models/rent_payments_model.dart';

import '../controllers/home_controller.dart';
import '../globals.dart';
import 'custom_text.dart';

class RentPaymentCard extends StatelessWidget {
  RentPayment rentPayment;
  double height;
  double type;

  RentPaymentCard({
    super.key,
    required this.rentPayment,
    required this.height,
    required this.type,
  });

  HomeController controller = Get.put<HomeController>(HomeController());

  @override
  Widget build(BuildContext context) {
    (height < 200) ? height = 240 : null;
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
            )
          ],
        ));
  }
}
