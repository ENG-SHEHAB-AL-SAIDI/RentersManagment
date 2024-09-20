import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/components/custom_text.dart';

import '../../globals.dart';

class PhoneRentersStateView extends StatelessWidget {
  PhoneRentersStateView({super.key});

  // void setYearlist() {
  //   if (widget.name.isNotEmpty) {
  //     year = [];
  //     DataCollection.rentersInfo[widget.name]!.year!.keys.map((element) {
  //       year.add(DropdownMenuItem<String>(
  //           value: element.toString(),
  //           child: SecText(element.toString(),
  //               color: AppColors.mainTextColor)));
  //     }).toList();
  //     if (year.isNotEmpty) {
  //       if (widget.selectedYear != "") {
  //         print(year[1].value);
  //         selectYear = widget.selectedYear;
  //       } else
  //         selectYear = year[0].value;
  //     } else
  //       selectYear = null;
  //   }
  // }
  List<DropdownMenuItem<String>> year = [];

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
        body: Container(
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
                                SecText("Name : Unknown",
                                    textColor: AppColors.mainTextColor),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SecText("Phone : Unknown ",
                                        textColor: AppColors.mainTextColor),
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
                                                color: AppColors.mainIconColor))
                                      ],
                                    ),
                                  ],
                                ),
                                SecText("Activity: Unknown",
                                    textColor: AppColors.mainTextColor),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (true) ...[
                                        SecText("Rent:  Unknown",
                                            textColor: AppColors.mainTextColor),
                                      ] else ...[
                                        SecText("Rent : YR",
                                            textColor: AppColors.mainTextColor)
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
                                                color: AppColors.mainIconColor),
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
                        child: Text(""),
                      )
                    ],
                  ),
                ),
              ],
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
