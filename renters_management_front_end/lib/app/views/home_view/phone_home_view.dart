// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/components/build_card.dart';
import 'package:renters_management_front_end/app/components/custom_text.dart';
import 'package:renters_management_front_end/app/globals.dart';

class PhoneHomeView extends StatelessWidget {
   PhoneHomeView({super.key});

  double height = Get.height;
  double width = Get.width;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: MainText("Renters Management"),
        leading:  Icon(Icons.home,color: AppColors.mainIconColor,),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        backgroundColor: AppColors.inverseCardColor,
        child:  Icon(Icons.add,color: AppColors.mainIconColor,),
      ),
      body: Padding(
        padding: EdgeInsets.all(width*0.02),
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height*0.01,),
              SecText("Builds",textColor: AppColors.inverseSecTextColor,),
              SizedBox(height: height*0.03,),
              for(int i = 0;i<5;i++)...[
                BuildCard(buildInfo: "buildInfo", height: height*0.16,type: i%2,),
                SizedBox(height: height*0.03,)
              ]
            ],
          ),
        )
      ),
    );
  }
}
