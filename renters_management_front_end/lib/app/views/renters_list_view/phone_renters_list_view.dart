import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/custom_text.dart';
import '../../components/pop_up_cards/add_build_card.dart';
import '../../components/pop_up_cards/delete_confirmation_message_card.dart';
import '../../components/text_field.dart';
import '../../controllers/renter_list_controller.dart';
import '../../globals.dart';

class PhoneRentersListView extends GetView<RenterListController> {
  const PhoneRentersListView({super.key});

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
        title: MainText("Renters List"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.sort_outlined,
                color: AppColors.mainIconColor,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert_outlined,
                color: AppColors.mainIconColor,
              )),
        ],
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
      body: Obx(() => (controller.renters.value == null)
          ? Center(
              child: MainText(
              "No renters yet ${controller.renters.value?.length}",
              textColor: AppColors.inverseSecTextColor,
            ))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: CustomTextFormField(
                    icon: Icons.search_rounded,
                    labelText: "Search",
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: controller.renters.value?.length ?? 0 * 2,
                        itemBuilder: (BuildContext ctx, int i) {
                          if (i.isOdd) return const Divider();
                          final index = i ~/ 2 + 1;
                          return ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 0),
                            leading: CircleAvatar(
                              backgroundColor: AppColors.inverseIconColor,
                              child: MainText(
                                "$index",textAlign: TextAlign.start,
                              ),
                            ),
                            title: MainText(
                              controller.renters.value?[i].name?.value ??
                                  "Unknown",
                              textColor: AppColors.inverseMainTextColor,
                              textAlign: TextAlign.start,
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SecText("Status:Active"),
                                SecText(" last payment date:2024-4-5")
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: AppColors.inverseIconColor,
                              ),
                              onPressed: delete,
                            ),
                            onTap: rentersListRoute,
                          );
                        }))
              ],
            )),
    );
  }

  void rentersListRoute() {
    Get.toNamed("/rentersState");
  }

  void delete() {
    Get.dialog(PopUpMessageCard(
        "did you sure want delete this renter that will delete all data relative to it."));
  }
}
