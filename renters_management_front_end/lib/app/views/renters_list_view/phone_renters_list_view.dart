import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/custom_text.dart';
import '../../components/pop_up_cards/add_build_card.dart';
import '../../components/pop_up_cards/delete_confirmation_message_card.dart';
import '../../components/text_field.dart';
import '../../globals.dart';

class PhoneRentersListView extends StatelessWidget {
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
      body: Column(
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
                  itemCount: 10 * 2,
                  itemBuilder: (BuildContext ctx, int i) {
                    if (i.isOdd) return const Divider();
                    final index = i ~/ 2 + 1;
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                      horizontalTitleGap: 5,
                      leading: CircleAvatar(
                        backgroundColor: AppColors.inverseIconColor,
                        radius: 40,
                        child: MainText(
                          "$index",
                        ),
                      ),
                      title: MainText(
                        "ncxjksacjcjkdskb$i",
                        textColor: AppColors.inverseMainTextColor,
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SecText("Status"),
                          SecText(" last payment date")
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
      ),
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
