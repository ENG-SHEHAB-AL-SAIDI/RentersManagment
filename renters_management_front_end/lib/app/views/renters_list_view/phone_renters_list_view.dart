import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/custom_text.dart';
import '../../components/pop_up_cards/add_and_update_build_card.dart';
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
        onPressed: controller.add,
        backgroundColor: AppColors.inverseCardColor,
        child: Icon(
          Icons.add,
          color: AppColors.mainIconColor,
        ),
      ),
      body: Obx(() => (controller.renters.value.isEmpty)
          ? Center(
              child: MainText(
              "No renters yet ${controller.renters.value.length}",
              textColor: AppColors.inverseSecTextColor,
            ))
          : RefreshIndicator(
              onRefresh: controller.refresh,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: CustomTextFormField(
                      icon: Icons.search_rounded,
                      onChange: controller.searching,
                      labelText: "Search",
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: (controller.renters.value.isNotEmpty)
                              ? ((controller.renters.value.length) * 2)
                              : 0,
                          itemBuilder: (BuildContext ctx, int i) {
                            final index = (i ~/ 2) + 1;
                            if (i.isOdd) return const Divider();
                            return ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              leading: CircleAvatar(
                                backgroundColor: AppColors.inverseIconColor,
                                child: MainText(
                                  "$index",
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              title: MainText(
                                controller
                                        .renters.value[(i ~/ 2)].name?.value ??
                                    "Unknown",
                                textColor: AppColors.inverseMainTextColor,
                                textAlign: TextAlign.start,
                              ),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SecText(" last payment date: 2024-4-5")
                                ],
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: AppColors.inverseIconColor,
                                ),
                                onPressed: ()=>controller.delete(controller
                                    .renters.value[(i ~/ 2)].id.value),
                              ),
                              onTap: () => controller.rentersDetailsRoute(i),
                            );
                          }))
                ],
              ))),
    );
  }
}
