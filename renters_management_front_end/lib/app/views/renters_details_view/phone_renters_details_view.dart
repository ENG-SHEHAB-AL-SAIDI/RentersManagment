import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                width: double.infinity,
                color: AppColors.backColor,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.maxFinite,
                            child: Card(
                              color: AppColors.inverseCardColor,
                              elevation: 20,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 15),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SecText("Phone:",
                                                    textColor: AppColors
                                                        .mainTextColor,fontWeight: FontWeight.bold,),
                                                const SizedBox(width: 10,),
                                                DropdownButton<String>(
                                                  value: controller
                                                      .selectedPhone.value,
                                                  elevation: 6,
                                                  icon: Icon(
                                                      Icons
                                                          .arrow_drop_down_sharp,
                                                      color: AppColors
                                                          .mainIconColor),
                                                  underline: const SizedBox(),
                                                  dropdownColor: AppColors
                                                      .inverseCardColor,
                                                  onChanged: controller
                                                      .changeSelectedPhone,
                                                  items:
                                                      controller.phones.value,
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
                                                      color: AppColors
                                                          .mainIconColor,
                                                    )),
                                                IconButton(
                                                    onPressed: () {
                                                      // _sendSMS();
                                                    },
                                                    icon: Icon(
                                                        Icons.sms_outlined,
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
                                          if (controller.renter?.rent?.value != null) ...[
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
                                                    textColor: AppColors.mainTextColor),
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
                                                SecText(
                                                    "Unknown",
                                                    textColor: AppColors.mainTextColor),
                                              ],
                                            ),
                                          ],
                                          Row(
                                            children: [
                                              SecText("Year:    ",
                                                  textColor:
                                                      AppColors.mainTextColor),
                                              DropdownButton<String>(
                                                value: "selectYear",
                                                elevation: 6,
                                                icon: Icon(
                                                    Icons.arrow_drop_down_sharp,
                                                    color: AppColors
                                                        .mainIconColor),
                                                underline: const Divider(),
                                                dropdownColor:
                                                    AppColors.mainIconColor,
                                                onChanged: (dynamic) {
                                                  if (dynamic != null) {}
                                                },
                                                items: year,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 20,
                            child: Container(),
                            // child: (widget.name.isNotEmpty &&
                            //         selectYear != null)
                            //     ? MyTable(widget.name, selectYear)
                            //     : (selectYear != null)
                            //         ? SizedBox.expand(
                            //             child: Card(
                            //                 textColor: AppColors.cardColor,
                            //                 elevation: 20,
                            //                 margin: const EdgeInsets.symmetric(
                            //                     horizontal: 30, vertical: 15),
                            //                 shape: RoundedRectangleBorder(
                            //                     borderRadius:
                            //                         BorderRadius.circular(24)),
                            //                 child: Center(
                            //                     child: SecText(
                            //                         "قم بأختيار مستاجر ",
                            //                         fontWeight: FontWeight.bold,
                            //                         fontSize: 28,
                            //                         textColor: AppColors
                            //                             .mainTextColor))),
                            //           )
                            //         : SizedBox.expand(
                            //             child: Card(
                            //                 textColor: AppColors.cardColor,
                            //                 elevation: 20,
                            //                 margin: const EdgeInsets.symmetric(
                            //                     horizontal: 30, vertical: 15),
                            //                 shape: RoundedRectangleBorder(
                            //                     borderRadius:
                            //                         BorderRadius.circular(24)),
                            //                 child: Center(
                            //                     child: SecText(
                            //                         "قم بأضافة سنة للمستاجر اولاً  ",
                            //                         fontWeight: FontWeight.bold,
                            //                         fontSize: 28,
                            //                         textColor: AppColors
                            //                             .mainTextColor))),
                          ),
                          const Expanded(
                            child: SizedBox(),
                          )
                        ],
                      ),
                    ),
                  ],
                ))
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
