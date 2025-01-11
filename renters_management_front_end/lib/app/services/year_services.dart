import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:renters_management_front_end/app/models/build_model.dart';
import 'package:renters_management_front_end/app/models/result.dart';
import 'package:renters_management_front_end/app/services/build_services.dart';
import 'package:get/get.dart' as get_x;
import '../components/loading_card.dart';
import '../models/rent_payments_model.dart';
import '../models/statement_model.dart';
import 'http_provider/http_provider.dart';

class YearServices {

  static Future<Result<bool>> addYearToRenter(
      {required int buildId,
      required int renterId,
      required Map<String, dynamic> data,
      bool hardFetch = false}) async {
    get_x.Get.dialog(const PopUpLoadingCard(),barrierDismissible: false);
    Result<Build> res = await BuildServices.fetchBuild(id: buildId);
    Response? response;
    try {
      response =
          await HttpProvider.post("user/year/renters/$renterId", data: data);
      if (response?.statusCode == 200) {
        Map<String, List<RentPayment>> rentPayments = {};
        if ((response?.data["grouped_rent_payments"] ?? []).isNotEmpty) {
          for (String key in response?.data["grouped_rent_payments"].keys) {
            List<RentPayment> rentPaymentsItems = [];
            for (Map<String, dynamic> item
                in response?.data["grouped_rent_payments"][key]) {
              rentPaymentsItems.add(RentPayment.fromJson(item));
            }
            rentPayments[key] = rentPaymentsItems;
          }
        }
        Map<String,List<Statement>> statements = {};
        if((response?.data["grouped_statements"]??[]).isNotEmpty){
          for (String key in response?.data["grouped_statements"].keys) {
            List<Statement> statementsList = [];
            for(Map<String,dynamic> item in response?.data["grouped_statements"][key]){
              statementsList.add(Statement.fromJson(item));
            }
            statements[key] = statementsList;
          }
        }
        res.data?.statements?.addAll(statements);
        res.data?.renters
            ?.firstWhere((e) => e.id.value == renterId)
            .rentPayments
            ?.addAll(rentPayments);

        return Result(hasError: false, statusCode: res.statusCode, data: true);
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return Result(
          hasError: true,
          statusCode: 651,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: response?.statusCode ?? 704,
        message: response?.data["message"] ?? "some thing wrong",
        data: null);
  }

  static Future<Result<bool>> deleteYearFromRenter(
      {required int buildId,
      required int renterId,
      required Map<String, dynamic> data,
      bool hardFetch = false}) async {
    get_x.Get.dialog(const PopUpLoadingCard(),barrierDismissible: false);
    Result<Build> res = await BuildServices.fetchBuild(id: buildId);
    Response? response;
    try {
      response =
          await HttpProvider.delete("user/year/renters/$renterId", data: data);
      if (response?.statusCode == 200) {
        res.data?.renters
            ?.firstWhere((e) => e.id.value == renterId)
            .rentPayments
            ?.remove(data["year"]);

        return Result(hasError: false, statusCode: res.statusCode, data: true);
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return Result(
          hasError: true,
          statusCode: 652,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: response?.statusCode ?? 704,
        message: response?.data["message"] ?? "some thing wrong",
        data: null);
  }
}
