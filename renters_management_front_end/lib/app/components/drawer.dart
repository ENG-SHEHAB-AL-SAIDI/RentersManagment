import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      child:Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.inverseCardColor
            ),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                      NetworkImage(controller.user?.profileImage?.value??"https://instructor-academy.onlinecoursehost.com/content/images/size/w2000/2023/05/How-to-Create-an-Online-Course-For-Free--Complete-Guide--6.jpg"),
                      radius: 35,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                        MainText(controller.user?.name?.value??"",
                          fontWeight: FontWeight.bold,
                          fontSize: Utils.fontSizeScale(18),),
                        SizedBox(
                          height: 5,
                        ),
                        MainText(controller.user?.email?.value??"",
                            fontSize: Utils.fontSizeScale(18),
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                  ],
                ),
              ],

            ),
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
