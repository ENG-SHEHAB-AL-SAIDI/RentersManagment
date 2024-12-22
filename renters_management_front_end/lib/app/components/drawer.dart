import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/components/calculator.dart';
import 'package:renters_management_front_end/app/controllers/home_controller.dart';
import 'package:renters_management_front_end/app/globals.dart';
import 'package:renters_management_front_end/app/services/user_services.dart';
import 'custom_text.dart';

class CustomDrawer extends GetView<HomeController> {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.backColor,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.inverseCardColor),
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                SizedBox(
                  width: double.maxFinite,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(controller
                              .user?.profileImage?.value ??
                          "https://instructor-academy.onlinecoursehost.com/content/images/size/w2000/2023/05/How-to-Create-an-Online-Course-For-Free--Complete-Guide--6.jpg"),
                      radius: 32,
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.04,
                        ),
                        MainText(
                          controller.user?.name?.value ?? "",
                          fontWeight: FontWeight.bold,
                          fontSize: Utils.fontSizeScale(18),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        MainText(controller.user?.email?.value ?? "",
                            fontSize: Utils.fontSizeScale(18),
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          ListTile(
            title: SecText("Calculator"),
            onTap: () {
              Get.bottomSheet(
                  Calculator()
              );
            },
          ),
          ListTile(
            title: SecText("LogOut"),
            onTap: UserServices.userLogout,
          )
        ],
      ),
    );
  }
}
