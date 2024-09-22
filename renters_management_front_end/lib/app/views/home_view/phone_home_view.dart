// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/components/build_card.dart';
import 'package:renters_management_front_end/app/components/custom_text.dart';
import 'package:renters_management_front_end/app/globals.dart';

import '../../components/pop_up_cards/add_build_card.dart';
import '../../controllers/home_controller.dart';

class PhoneHomeView extends GetView<HomeController> {
  PhoneHomeView({super.key});

  double height = Get.height;
  double width = Get.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: MainText("Renters Management"),
        leading: Icon(
          Icons.home,
          color: AppColors.mainIconColor,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(const PopUpIAddBuildCard());
        },
        backgroundColor: AppColors.inverseCardColor,
        child: Icon(
          Icons.add,
          color: AppColors.mainIconColor,
        ),
      ),
      body: Padding(
          padding: EdgeInsets.all(width * 0.05),
          child: Obx(()=>(controller.builds.value!.isEmpty)
              ? Center(
            child: MainText(
              "No Builds yet\n add some ",
              textColor: AppColors.inverseSecTextColor,
            ),
          )
              : SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.01,
                ),
                SecText(
                  "Your Builds",
                  textColor: AppColors.inverseSecTextColor,
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                for (int i = 0;
                i < controller.builds.value!.length;
                i++) ...[
                  BuildCard(
                    buildInfo: controller.builds.value![i],
                    height: height * 0.16,
                    type: 1,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                ]
              ],
            ),
          ))),
    );
  }
}
