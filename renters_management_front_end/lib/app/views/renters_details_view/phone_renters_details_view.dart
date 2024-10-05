import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/components/buttons.dart';
import 'package:renters_management_front_end/app/components/custom_text.dart';
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
          title: MainText("Renters List"),
        ),
        body: Obx(() => (!controller.loadingState.value)
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      child: Card(
                        color: AppColors.inverseCardColor,
                        elevation: 20,
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                      textColor: AppColors.mainTextColor),
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
                                            textColor: AppColors.mainTextColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          DropdownButton<String>(
                                            value:
                                                controller.selectedPhone.value,
                                            elevation: 6,
                                            icon: Icon(
                                                Icons.arrow_drop_down_rounded,
                                                color: AppColors.mainIconColor),
                                            underline: const SizedBox(),
                                            dropdownColor:
                                                AppColors.inverseCardColor,
                                            onChanged:
                                                controller.changeSelectedPhone,
                                            items: controller.phones.value,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                // _callrenter();
                                              },
                                              icon: Icon(
                                                Icons.phone,
                                                color: AppColors.mainIconColor,
                                              )),
                                          IconButton(
                                              onPressed: () {
                                                // _sendSMS();
                                              },
                                              icon: Icon(Icons.sms_outlined,
                                                  color:
                                                      AppColors.mainIconColor))
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
                                            textColor: AppColors.mainTextColor,
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
                                            textColor: AppColors.mainTextColor,
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
                                            value:
                                                controller.selectedYear.value,
                                            elevation: 6,
                                            icon: Icon(
                                                Icons.arrow_drop_down_sharp,
                                                color: AppColors.mainIconColor),
                                            underline: const SizedBox(),
                                            dropdownColor:
                                                AppColors.inverseCardColor,
                                            onChanged:
                                                controller.changeSelectedYear,
                                            items: controller.years.value,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SecText(
                            "month",
                            textColor: AppColors.inverseSecTextColor,
                          ),
                          SecText(
                            "state",
                            textColor: AppColors.inverseSecTextColor,
                          ),
                          SecText(
                            "payedAmount",
                            textColor: AppColors.inverseSecTextColor,
                          ),
                          SecText(
                            "remainAmount",
                            textColor: AppColors.inverseSecTextColor,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 20,
                      child: ListView.builder(
                          itemCount: controller
                                  .renter
                                  ?.rentPayments?[controller.selectedYear.value]
                                  ?.length ??
                              0,
                          itemBuilder: (ctx, int i) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24)),
                                  color: AppColors.inverseCardColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(24),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SecText(
                                              controller
                                                      .renter
                                                      ?.rentPayments?[controller
                                                          .selectedYear
                                                          .value]?[i]
                                                      .month
                                                      ?.value ??
                                                  "",
                                              textColor:
                                                  AppColors.mainTextColor,
                                            ),
                                            SecText(
                                              controller
                                                      .renter
                                                      ?.rentPayments?[controller
                                                          .selectedYear
                                                          .value]?[i]
                                                      .state
                                                      ?.value ??
                                                  "unknown",
                                              textColor:
                                                  AppColors.mainTextColor,
                                            ),
                                            SecText(
                                              "${controller.renter?.rentPayments?[controller.selectedYear.value]?[i].payedAmount?.value ?? "unknown"}",
                                              textColor:
                                                  AppColors.mainTextColor,
                                            ),
                                            SecText(
                                              "${controller.renter?.rentPayments?[controller.selectedYear.value]?[i].remainAmount?.value ?? "unknown"}",
                                              textColor:
                                                  AppColors.mainTextColor,
                                            ),
                                          ],
                                        ),
                                        ExpansionTile(
                                          tilePadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 0),
                                          iconColor: AppColors.mainTextColor,
                                          collapsedIconColor:
                                              AppColors.mainTextColor,
                                          title: SecText(
                                            "Rent Payments Installment",
                                            textColor: AppColors.mainTextColor,
                                            textAlign: TextAlign.start,
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(24)),
                                          childrenPadding: const EdgeInsets.all(8),
                                          children: [

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SecText(
                                                  "Date",
                                                  textColor: AppColors.mainTextColor,
                                                ),
                                                SecText(
                                                  "Amount",
                                                  textColor: AppColors.mainTextColor,
                                                ),
                                                SecText(
                                                  "Note",
                                                  textColor: AppColors.mainTextColor,
                                                ),
                                              ],
                                            ),
                                            const Divider(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SecText(
                                                  "2024-3-1",
                                                  textColor: AppColors.mainTextColor,
                                                ),
                                                SecText(
                                                  "100,000",
                                                  textColor: AppColors.mainTextColor,
                                                ),
                                                TextButton(onPressed: (){},
                                                  style: ButtonStyle(
                                                      padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                                                      alignment: Alignment.centerRight

                                                  ),
                                                  child: SecText(
                                                    "show",
                                                    textColor: AppColors.mainTextColor,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const Divider(),
                                            const SizedBox(height: 16,),
                                            CustomButton(onPress: (){},text: "Add Installment",color: AppColors.mainTextColor,textColor: AppColors.inverseMainTextColor,size:const Size(150,30) ,)
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            );
                          }),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    )
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
