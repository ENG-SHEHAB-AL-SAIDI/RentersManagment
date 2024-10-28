// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/components/build_card.dart';
import 'package:renters_management_front_end/app/components/custom_text.dart';
import 'package:renters_management_front_end/app/components/drawer.dart';
import 'package:renters_management_front_end/app/globals.dart';

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
        foregroundColor: AppColors.mainIconColor,
        title: MainText("Renters Management"),
        leading: Icon(
          Icons.home,
          color: AppColors.mainIconColor,
        ),
      ),
      endDrawer: CustomDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.add,
        backgroundColor: AppColors.inverseCardColor,
        child: Icon(
          Icons.add,
          color: AppColors.mainIconColor,
        ),
      ),
      body: Padding(
          padding: EdgeInsets.all(width * 0.05),
          child: Obx(() => (!(controller.lodeState.value))
              ? (controller.builds.value.isEmpty)
                  ? Center(
                      child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MainText(
                          controller.errorMessage.value,
                          textColor: AppColors.inverseSecTextColor,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        IconButton(
                            onPressed: controller.refresh,
                            icon: Icon(
                              Icons.refresh,
                              color: AppColors.inverseIconColor,
                              size: 50,
                            )),
                        // MainText(
                        //   "Refresh",
                        //   textColor: AppColors.inverseSecTextColor,
                        // ),
                      ],
                    ))
                  : RefreshIndicator(
                      onRefresh: controller.refresh,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height * 0.01,
                          ),
                          SecText(
                            "Your Builds:",
                            textColor: AppColors.inverseSecTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: Utils.fontSizeScale(20),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Expanded(child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            controller: controller.scrollController,
                            child: Column(
                              children: [
                                for (int i = 0;
                                i < controller.builds.value.length;
                                i++) ...[
                                  BuildCard(
                                    buildInfo: controller.builds.value[i],
                                    height: height * 0.16,
                                    type: 1,
                                  ),
                                  SizedBox(
                                    height: height * 0.03,
                                  ),
                                ]
                              ],
                            ),
                          ))
                        ],
                      ),
                    )
              : const Center(
                  child: CircularProgressIndicator(),
                ))),
    );
  }
}
