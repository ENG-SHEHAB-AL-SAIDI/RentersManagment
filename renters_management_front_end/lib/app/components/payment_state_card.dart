// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/models/rent_payments_model.dart';

import '../controllers/home_controller.dart';
import '../globals.dart';
import 'buttons.dart';
import 'custom_text.dart';

class RentPaymentCard extends StatelessWidget {
  RentPayment? rentPayment;
  double height;
  double type;
  Map<String, String> months = {
    '1': 'January',
    '2': 'February',
    '3': 'March',
    '4': 'April',
    '5': 'May',
    '6': 'June',
    '7': 'July',
    '8': 'August',
    '9': 'September',
    '10': 'October',
    '11': 'November',
    '12': 'December'
  };

  RentPaymentCard({
    super.key,
    required this.rentPayment,
    required this.height,
    required this.type,
  });

  HomeController controller = Get.put<HomeController>(HomeController());
  Rx<List<DropdownMenuItem<String>>> status = Rx([]);

  @override
  Widget build(BuildContext context) {
    (height < 200) ? height = 240 : null;
    Color color1;
    Color color2;
    Color textColor;
    double rightPadding = 70;
    if (type == 0) {
      color1 = AppColors.mainCardColor;
      color2 = AppColors.inverseCardColor;
      textColor = AppColors.secTextColor;
    } else {
      color1 = AppColors.inverseCardColor;
      color2 = AppColors.backColor;
      textColor = AppColors.mainTextColor;
    }
    status.value = [
      DropdownMenuItem<String>(
        value: 'payed',
        child: Row(
          children: [
            const Icon(
              Icons.check,
              color: Colors.greenAccent,
            ),
            const SizedBox(
              width: 6,
            ),
            SecText('Payed', textColor: color2)
          ],
        ),
      ),
      DropdownMenuItem<String>(
        value: 'partially_payed',
        child: Row(
          children: [
            const Icon(
              Icons.pie_chart_rounded,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 6,
            ),
            SecText('Partially Payed', textColor: color2),
          ],
        ),
      ),
      DropdownMenuItem<String>(
        value: 'not_payed',
        child: Row(
          children: [
            const Icon(
              Icons.close,
              color: Colors.red,
            ),
            const SizedBox(
              width: 6,
            ),
            SecText('Not Payed', textColor: color2),
          ],
        ),
      )
    ];
    RxString? selectedState = rentPayment?.state;
    return Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: color1,
          border: Border(
            top: BorderSide(color: color2, width: 5, strokeAlign: 1),
            bottom: BorderSide(color: color2, width: 5, strokeAlign: 1),
            right: BorderSide(color: color2, width: 5, strokeAlign: 1),
            left: BorderSide(color: color2, width: 5, strokeAlign: 1),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 5),
            )
          ],
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    children: [
                      SecText(
                        "Month:",
                        textColor: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SecText(
                        (rentPayment?.month?.value != null)
                            ? "${months[rentPayment?.month?.value]} (${rentPayment?.month?.value})"
                            : "Unknown",
                        textColor: textColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      SecText(
                        "State:",
                        textColor: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: color2, width: 1),
                          // Border color and width
                          borderRadius: BorderRadius.circular(
                              16), // Rounded corners (optional)
                        ),
                        height: 30,
                        child: DropdownButton<String>(
                          value: selectedState?.value,
                          elevation: 6,
                          icon: Icon(Icons.arrow_drop_down_sharp, color: color2),
                          underline: const SizedBox(),
                          dropdownColor: color1,
                          borderRadius:
                          const BorderRadius.all(Radius.circular(24)),
                          onChanged: (value) {},
                          items: status.value,
                        ),
                      ),

                      // SecText(
                      //   rentPayment?.state?.value ?? "Unknown",
                      //   textColor: textColor,
                      // ),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      SecText(
                        "payedAmount:",
                        textColor: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SecText(
                        "${rentPayment?.payedAmount?.value ?? 0}",
                        textColor: textColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      SecText(
                        "remainAmount:",
                        textColor: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SecText(
                        "${rentPayment?.remainAmount?.value ?? 0}",
                        textColor: textColor,
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: color2,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: ExpansionTile(
                iconColor: color1,
                collapsedIconColor: color1,
                title: SecText(
                  "Rent Payments Installment",
                  textColor: color1,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                childrenPadding: const EdgeInsets.all(16),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SecText(
                        "Date",
                        textColor: color1,
                      ),
                      SecText(
                        "Amount",
                        textColor: color1,
                      ),
                      SecText(
                        "Note",
                        textColor: color1,
                      ),
                      Icon(
                        Icons.delete,
                        color: color2,
                      )
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SecText(
                        "2024-3-1",
                        textColor: color1,
                      ),
                      SecText(
                        "100,000",
                        textColor: color1,
                      ),
                      TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            padding: WidgetStateProperty.all<EdgeInsets>(
                                EdgeInsets.zero),
                            alignment: Alignment.centerRight),
                        child: SecText(
                          "show",
                          textColor: color1,
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete,
                            color: color1,
                          ))
                    ],
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomButton(
                    onPress: () {},
                    text: "Add Installment",
                    color: color1,
                    textColor: color2,
                    size: const Size(150, 40),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

//
// Padding(
// padding: const EdgeInsets.symmetric(vertical: 4),
// child: Card(
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(24)),
// color: AppColors.inverseCardColor,
// child: Padding(
// padding: const EdgeInsets.all(24),
// child: Column(
// crossAxisAlignment:
// CrossAxisAlignment.start,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// SecText(
// "month",
// textColor: AppColors.mainTextColor,
// ),
// SecText(
// "state",
// textColor: AppColors.mainTextColor,
// ),
// SecText(
// "payedAmount",
// textColor: AppColors.mainTextColor,
// ),
// SecText(
// "remainAmount",
// textColor: AppColors.mainTextColor,
// ),
// ],
// ),
// Divider(),
// Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// children: [
// SecText(
// controller
//     .renter
//     ?.rentPayments?[controller
//     .selectedYear
//     .value]?[i]
//     .month
//     ?.value ??
// "",
// textColor:
// AppColors.mainTextColor,
// ),
// SecText(
// controller
//     .renter
//     ?.rentPayments?[controller
//     .selectedYear
//     .value]?[i]
//     .state
//     ?.value ??
// "unknown",
// textColor:
// AppColors.mainTextColor,
// ),
// SecText(
// "${controller.renter?.rentPayments?[controller.selectedYear.value]?[i].payedAmount?.value ?? "unknown"}",
// textColor:
// AppColors.mainTextColor,
// ),
// SecText(
// "${controller.renter?.rentPayments?[controller.selectedYear.value]?[i].remainAmount?.value ?? "unknown"}",
// textColor:
// AppColors.mainTextColor,
// ),
// ],
// ),
// Divider(),
// ExpansionTile(
// tilePadding:
// const EdgeInsets.symmetric(
// horizontal: 0),
// iconColor: AppColors.mainTextColor,
// collapsedIconColor:
// AppColors.mainTextColor,
// title: SecText(
// "Rent Payments Installment",
// textColor: AppColors.mainTextColor,
// textAlign: TextAlign.start,
// ),
// shape: RoundedRectangleBorder(
// borderRadius:
// BorderRadius.circular(24)),
// childrenPadding: const EdgeInsets.all(8),
// children: [
//
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// SecText(
// "Date",
// textColor: AppColors.mainTextColor,
// ),
// SecText(
// "Amount",
// textColor: AppColors.mainTextColor,
// ),
// SecText(
// "Note",
// textColor: AppColors.mainTextColor,
// ),
// ],
// ),
// const Divider(),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// SecText(
// "2024-3-1",
// textColor: AppColors.mainTextColor,
// ),
// SecText(
// "100,000",
// textColor: AppColors.mainTextColor,
// ),
// TextButton(onPressed: (){},
// style: ButtonStyle(
// padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
// alignment: Alignment.centerRight
//
// ),
// child: SecText(
// "show",
// textColor: AppColors.mainTextColor,
// ),
// )
// ],
// ),
// const Divider(),
// const SizedBox(height: 16,),
// CustomButton(onPress: (){},text: "Add Installment",color: AppColors.mainTextColor,textColor: AppColors.inverseMainTextColor,size:const Size(150,30) ,)
// ],
// ),
// ],
// ),
// )),
// );
