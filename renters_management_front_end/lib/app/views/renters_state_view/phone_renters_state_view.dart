import 'package:flutter/material.dart';
import 'package:renters_management_front_end/app/components/custom_text.dart';

import '../../globals.dart';

class PhoneRentersStateView extends StatelessWidget {
  const PhoneRentersStateView({super.key});

  // void setYearlist() {
  //   if (widget.name.isNotEmpty) {
  //     year = [];
  //     DataCollection.rentersInfo[widget.name]!.year!.keys.map((element) {
  //       year.add(DropdownMenuItem<String>(
  //           value: element.toString(),
  //           child: SecText(element.toString(),
  //               color: AppColors.secondaryTextColor)));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.inverseCardColor,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
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
                Card(
                  color: AppColors.inverseCardColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: () async {
                              // await Navigator.of(context).push(HeroDialogRoute(
                              //     builder: (ctx) =>
                              //         PopUpAddYearCard(widget.name)));
                              // setYearlist();
                              //
                            },
                            icon: Icon(Icons.post_add_sharp),
                            color: AppColors.mainIconColor,
                          ),
                          SecText("أضافة سنة", textColor: AppColors.mainTextColor,)
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () async {
                              // String? result = await Navigator.of(context).push(
                              //     HeroDialogRoute(
                              //         builder: (ctx) =>
                              //             const PopUpSelectCard()));
                              // WidgetsBinding.instance
                              //     .addPostFrameCallback((timeStamp) {
                              //   setState(() {
                              //     if (result != null) {
                              //       widget.name = result;
                              //       setYearlist();
                              //     }
                              //   });
                              // });
                            },
                            icon: Icon(Icons.add_to_home_screen),
                            color: AppColors.mainIconColor,
                          ),
                          SecText(
                            "اختيار مستاجر",textColor: AppColors.mainTextColor,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () async {
                              // if (DataCollection.rentersInfo.isNotEmpty &&
                              //     widget.name.isNotEmpty) {
                              //   String newName = await Navigator.of(context)
                              //       .push(HeroDialogRoute(
                              //           builder: (ctx) =>
                              //               PopUpUpdateCard(widget.name)))
                              //       .whenComplete(() => null);
                              //   setState(() {
                              //     widget.name = newName;
                              //   });
                              // } else {
                              //   Navigator.of(context).push(HeroDialogRoute(
                              //       builder: (ctx) => PopUpErrorAlertCard(
                              //           "لاتوجد بيانات لتعديلها؟؟")));
                              // }
                            },
                            icon: Icon(Icons.edit),
                            color: AppColors.mainIconColor,
                          ),
                          SecText(
                            "تعديل البيانات",textColor: AppColors.mainTextColor,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () async {
                              // bool flag = await Navigator.of(context).push(
                              //     HeroDialogRoute(
                              //         builder: (ctx) => PopUpMessageCard(
                              //             "هل انت متاكد انك تريد حذف المستاجر ${widget.name}")));
                              // if (flag) {
                              //   String newName =
                              //       await MyControl().deleteRenter(widget.name);
                              //   setState(() {
                              //     print(newName);
                              //     if (newName != "failed") {
                              //       widget.name = newName;
                              //       setYearlist();
                              //     } else {
                              //       Navigator.of(context).push(HeroDialogRoute(
                              //         builder: (ctx) => PopUpErrorAlertCard(
                              //             "فشلة عملية الحذف"),
                              //       ));
                              //     }
                              //   });
                              // }
                            },
                            icon: Icon(Icons.delete_rounded),
                            color: AppColors.mainIconColor,
                          ),
                          SecText(
                            "حذف",textColor: AppColors.mainTextColor,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                // Expanded(
                //   child: Container(
                //     width: (cons.maxHeight > 567) ? 560 : double.maxFinite,
                //     child: Column(
                //       children: [
                //         SizedBox(
                //           width: double.maxFinite,
                //           child: Card(
                //             color: AppColors.mainCardColor,
                //             elevation: 20,
                //             margin: const EdgeInsets.symmetric(
                //                 horizontal: 30, vertical: 15),
                //             shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(24)),
                //             child: Padding(
                //               padding: const EdgeInsets.all(24.0),
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   if (DataCollection.rentersInfo.isNotEmpty &&
                //                       widget.name != "") ...[
                //                     SecText(
                //                         "الاسم : ${DataCollection.rentersInfo[widget.name]?.name}",
                //                         color: AppColors.secondaryTextColor),
                //                     Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.spaceBetween,
                //                       children: [
                //                         SecText(
                //                             "الجوال :  ${DataCollection.rentersInfo[widget.name]?.phone}",
                //                             color:
                //                                 AppColors.secondaryTextColor),
                //                         Row(
                //                           mainAxisSize: MainAxisSize.min,
                //                           children: [
                //                             IconButton(
                //                                 onPressed: () {
                //                                   _callrenter();
                //                                 },
                //                                 icon: Icon(
                //                                   Icons.phone,
                //                                   color: AppColors.bodyColor,
                //                                 )),
                //                             IconButton(
                //                                 onPressed: () {
                //                                   _sendSMS();
                //                                 },
                //                                 icon: Icon(Icons.sms_outlined,
                //                                     color: AppColors.bodyColor))
                //                           ],
                //                         ),
                //                       ],
                //                     ),
                //                     SecText(
                //                         "النشاط التجاري  :  ${DataCollection.rentersInfo[widget.name]?.activityType}",
                //                         color: AppColors.secondaryTextColor),
                //                     if (DataCollection
                //                             .rentersInfo[widget.name]?.rent ==
                //                         "") ...[
                //                       SecText(
                //                           "الايجار : ${DataCollection.rentersInfo[widget.name]?.rent} ",
                //                           color: AppColors.secondaryTextColor),
                //                     ] else ...[
                //                       SecText(
                //                           "الايجار : ${DataCollection.rentersInfo[widget.name]?.rent} YR",
                //                           color: AppColors.secondaryTextColor)
                //                     ],
                //                     Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.spaceBetween,
                //                       children: [
                //                         Row(
                //                           children: [
                //                             SecText("السنة    :    ",
                //                                 color: AppColors
                //                                     .secondaryTextColor),
                //                             DropdownButton<String>(
                //                               value: selectYear,
                //                               elevation: 6,
                //                               icon: Icon(
                //                                   Icons.arrow_drop_down_sharp,
                //                                   color: AppColors.bodyColor),
                //                               underline: const Divider(),
                //                               dropdownColor:
                //                                   AppColors.appbarColor,
                //                               onChanged: (dynamic) {
                //                                 if (dynamic != null) {
                //                                   setState(() =>
                //                                       selectYear = dynamic);
                //                                 }
                //                               },
                //                               items: year,
                //                             ),
                //                           ],
                //                         ),
                //                         IconButton(
                //                             onPressed: () async {
                //                               bool flag = await Navigator.of(
                //                                       context)
                //                                   .push(HeroDialogRoute(
                //                                       builder: (ctx) =>
                //                                           PopUpMessageCard(
                //                                               "هل انت متاكد انك تريد حذف السنة $selectYear من كشف المستاجر $widget.name ")));
                //                               if (flag) {
                //                                 String newName =
                //                                     await MyControl()
                //                                         .deleteYear(widget.name,
                //                                             selectYear!);
                //                                 setYearlist();
                //                                 setState(() {
                //                                   if (newName != "failed") {
                //                                   } else {
                //                                     Navigator.of(context)
                //                                         .push(HeroDialogRoute(
                //                                       builder: (ctx) =>
                //                                           PopUpErrorAlertCard(
                //                                               "فشلة عملية الحذف"),
                //                                     ));
                //                                   }
                //                                 });
                //                               }
                //                             },
                //                             icon: Icon(
                //                               Icons.delete_forever,
                //                               color: AppColors.bodyColor,
                //                             )),
                //                         SizedBox(
                //                           width: 5,
                //                         )
                //                       ],
                //                     )
                //                   ] else ...[
                //                     SecText("الاسم : -----------------",
                //                         color: AppColors.secondaryTextColor),
                //                     SecText("الجوال : -----------------",
                //                         color: AppColors.secondaryTextColor),
                //                     SecText("النشاط التجاري : -----------------",
                //                         color: AppColors.secondaryTextColor),
                //                     Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.spaceBetween,
                //                       children: [
                //                         SecText("الايجار : -----------------",
                //                             color:
                //                                 AppColors.secondaryTextColor),
                //                         SecText("السنة : ------- ",
                //                             color: AppColors.secondaryTextColor)
                //                       ],
                //                     )
                //                   ]
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ),
                //         Expanded(
                //             flex: 20,
                //             child: (widget.name.isNotEmpty &&
                //                     selectYear != null)
                //                 ? MyTable(widget.name, selectYear)
                //                 : (selectYear != null)
                //                     ? SizedBox.expand(
                //                         child: Card(
                //                             color: AppColors.cardColor,
                //                             elevation: 20,
                //                             margin: const EdgeInsets.symmetric(
                //                                 horizontal: 30, vertical: 15),
                //                             shape: RoundedRectangleBorder(
                //                                 borderRadius:
                //                                     BorderRadius.circular(24)),
                //                             child: Center(
                //                                 child: SecText(
                //                                     "قم بأختيار مستاجر ",
                //                                     fontWeight: FontWeight.bold,
                //                                     fontSize: 28,
                //                                     color: AppColors
                //                                         .secondaryTextColor))),
                //                       )
                //                     : SizedBox.expand(
                //                         child: Card(
                //                             color: AppColors.cardColor,
                //                             elevation: 20,
                //                             margin: const EdgeInsets.symmetric(
                //                                 horizontal: 30, vertical: 15),
                //                             shape: RoundedRectangleBorder(
                //                                 borderRadius:
                //                                     BorderRadius.circular(24)),
                //                             child: Center(
                //                                 child: SecText(
                //                                     "قم بأضافة سنة للمستاجر اولاً  ",
                //                                     fontWeight: FontWeight.bold,
                //                                     fontSize: 28,
                //                                     color: AppColors
                //                                         .secondaryTextColor))),
                //                       )),
                //         const Expanded(
                //           child: Text(""),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
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
