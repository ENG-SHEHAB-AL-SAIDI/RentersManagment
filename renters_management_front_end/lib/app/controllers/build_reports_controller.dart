import 'package:get/get.dart';
import 'package:renters_management_front_end/app/services/build_services.dart';

import '../models/build_model.dart';
import '../models/rent_payments_model.dart';
import '../models/renter_model.dart';


class BuildReportsController extends GetxController {
  int buildId = -1;
  String selectedYear = '';
  String selectedMonth = '';
  String year = "";
  int month = -1;
  RxDouble monthTotalRent = 0.0.obs;
  RxInt rentersCount = 0.obs;

  RxDouble payedTotalRent = 0.0.obs;
  RxInt payedRentersCount = 0.obs;

  RxDouble partiallyPayedTotalRent = 0.0.obs;
  RxInt partiallyPayedRentersCount = 0.obs;

  RxDouble notPayedTotalRent = 0.0.obs;
  RxInt notPayedRentersCount = 0.obs;


  @override
  void onInit() {
    buildId = Get.arguments["buildId"];
    year = Get.arguments["year"];
    month = Get.arguments["month"];
    calcBuildStatement();
    super.onInit();
  }
  void more(String val) {
    if (val == "print") {
      print(val);
    }
  }


  void calcBuildStatement() async{

    Build? build = await BuildServices.fetchBuild(id: buildId).then((res)=>res.data);
    for (Renter renter in (build?.renters??[])) {
      for(RentPayment rentPayment in renter.rentPayments?[year]??[]){
        if(rentPayment.month?.value == month.toString()){
          monthTotalRent.value += renter.rent?.value??0;
          rentersCount.value+=1;
          if(rentPayment.state?.value == "payed"){
            payedTotalRent.value += renter.rent?.value??0;
            payedRentersCount.value+=1;
          }
          else if(rentPayment.state?.value == "partially_payed"){
            partiallyPayedTotalRent.value += rentPayment.payedAmount?.value??0;
            partiallyPayedRentersCount.value++;
          }
          else if(rentPayment.state?.value == "not_payed"){
            notPayedTotalRent.value += rentPayment.remainAmount?.value??0;
            notPayedRentersCount.value++;
          }

        }
      }
    }
  }

}
