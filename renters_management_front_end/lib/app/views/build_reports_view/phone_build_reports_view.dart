import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/custom_text.dart';
import '../../controllers/build_reports_controller.dart';
import '../../globals.dart';

class PhoneBuildReportsView extends GetView<BuildReportsController> {
   const PhoneBuildReportsView({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.inverseCardColor,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_outlined,
              color: AppColors.mainIconColor,
            )),
        title: MainText("Build Report"),
        actions: [
          PopupMenuButton<String>(
            onSelected:controller.more,
            color: AppColors.inverseCardColor,
            itemBuilder: (ctx) => [
              PopupMenuItem(
                  value: "print",
                  child: SecText(
                    "Print",
                    textColor:
                    AppColors.mainTextColor,
                  )),
            ],
            child: Icon(Icons.more_vert_outlined,
                color: AppColors.mainTextColor),
          ),
          SizedBox(width: 10,)
        ],
      ),

    );
  }
}
