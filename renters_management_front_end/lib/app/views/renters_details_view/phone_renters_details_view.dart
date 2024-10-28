import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/components/custom_text.dart';
import 'package:renters_management_front_end/app/components/payment_state_card.dart';
import 'package:renters_management_front_end/app/controllers/renter_details_controller.dart';

import '../../globals.dart';

class PhoneRentersDetailsView extends GetView<RenterDetailsController> {
  PhoneRentersDetailsView({super.key});

  List<DropdownMenuItem<String>> year = [];
  List<DropdownMenuItem<String>> phones = [];

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
          title: MainText("Renters Details"),
        ),
        body: Obx(() => (!controller.loadingState.value)
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      child: Obx(() => Card(
                            color: AppColors.inverseCardColor,
                            elevation: 20,
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                                side: BorderSide(
                                    color: AppColors.mainCardColor,
                                    width: 5,
                                    strokeAlign: -1)),
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SecText(
                                            "Name:",
                                            textColor: AppColors.mainTextColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          const SizedBox(width: 10),
                                          SecText(
                                              controller.renter?.name?.value ??
                                                  "Unknown",
                                              textColor:
                                                  AppColors.mainTextColor),
                                        ],
                                      ),
                                      PopupMenuButton<String>(

                                        onSelected:controller.more,
                                        color: AppColors.inverseCardColor,
                                        itemBuilder: (ctx) => [
                                          PopupMenuItem(
                                            value: "edit",
                                            child: SecText(
                                              "Edit",
                                              textColor:
                                                  AppColors.mainTextColor,
                                            ),
                                          ),
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
                                    ],
                                  ),
                                  Obx(() => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SecText(
                                                "Phones:",
                                                textColor:
                                                    AppColors.mainTextColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              (controller
                                                      .phones.value.isNotEmpty)
                                                  ? DropdownButton<String>(
                                                      value: controller
                                                          .selectedPhone.value,
                                                      elevation: 6,
                                                      icon: Icon(
                                                          Icons
                                                              .arrow_drop_down_rounded,
                                                          color: AppColors
                                                              .mainIconColor),
                                                      underline:
                                                          const SizedBox(),
                                                      dropdownColor: AppColors
                                                          .inverseCardColor,
                                                      onChanged: controller
                                                          .changeSelectedPhone,
                                                      items: controller
                                                          .phones.value,
                                                    )
                                                  : IconButton(
                                                      onPressed: () => controller
                                                          .changeSelectedPhone(
                                                              ""),
                                                      icon: Icon(Icons.add,
                                                          color: AppColors
                                                              .mainIconColor)),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                  onPressed:
                                                      controller.deletePhone,
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color:
                                                        AppColors.mainTextColor,
                                                  )),
                                              IconButton(
                                                  onPressed: () {
                                                    // _callrenter();
                                                  },
                                                  icon: Icon(
                                                    Icons.phone,
                                                    color:
                                                        AppColors.mainIconColor,
                                                  )),
                                              IconButton(
                                                  onPressed: () {
                                                    // _sendSMS();
                                                  },
                                                  icon: Icon(Icons.sms_outlined,
                                                      color: AppColors
                                                          .mainIconColor))
                                            ],
                                          ),
                                        ],
                                      )),
                                  Row(
                                    children: [
                                      SecText(
                                        "Activity:",
                                        textColor: AppColors.mainTextColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      const SizedBox(width: 10),
                                      SecText(
                                          controller.renter?.jobDomain?.value ??
                                              "Unknown",
                                          textColor: AppColors.mainTextColor),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (controller.renter?.rent?.value !=
                                            null) ...[
                                          Row(
                                            children: [
                                              SecText(
                                                "Rent:",
                                                textColor:
                                                    AppColors.mainTextColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              const SizedBox(width: 10),
                                              SecText(
                                                  "${controller.renter?.rent?.value} YR",
                                                  textColor:
                                                      AppColors.mainTextColor),
                                            ],
                                          ),
                                        ] else ...[
                                          Row(
                                            children: [
                                              SecText(
                                                "Rent:",
                                                textColor:
                                                    AppColors.mainTextColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              const SizedBox(width: 10),
                                              SecText("Unknown",
                                                  textColor:
                                                      AppColors.mainTextColor),
                                            ],
                                          ),
                                        ],
                                        Obx(
                                          () => Row(
                                            children: [
                                              SecText("Year:    ",
                                                  textColor:
                                                      AppColors.mainTextColor),
                                              DropdownButton<String>(
                                                value: controller
                                                    .selectedYear.value,
                                                elevation: 6,
                                                icon: Icon(
                                                    Icons.arrow_drop_down_sharp,
                                                    color: AppColors
                                                        .mainIconColor),
                                                underline: const SizedBox(),
                                                dropdownColor:
                                                    AppColors.inverseCardColor,
                                                onChanged: controller
                                                    .changeSelectedYear,
                                                items: controller.years.value,
                                              ),
                                              IconButton(
                                                  onPressed:
                                                  controller.deleteYear,
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color:
                                                    AppColors.mainTextColor,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (int i = 0;
                                i <
                                    (controller
                                            .renter
                                            ?.rentPayments?[
                                                controller.selectedYear.value]
                                            ?.length ??
                                        0);
                                i++) ...[
                              Obx(() => RentPaymentCard(
                                    rentPayment:
                                        controller.renter?.rentPayments![
                                            controller.selectedYear.value]?[i],
                                    height: 10,
                                    type: 1,
                                    initiallyExpanded: (i == 0) ? true : false,
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                            ]
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              )));
  }

// void _callrenter() async {
//   if (DataCollection.rentersInfo[widget.name]?.phone != null) {
//     final phoneUri = Uri(
//         scheme: 'tel', path: DataCollection.rentersInfo[widget.name]!.phone);
//     await launchUrl(phoneUri);
//   }
// }
//
// void _sendSMS() async {
//   if (DataCollection.rentersInfo[widget.name]?.phone != null) {
//     final smsUri = Uri(
//         scheme: 'sms', path: DataCollection.rentersInfo[widget.name]!.phone);
//     await launchUrl(smsUri);
//   }
// }
}
