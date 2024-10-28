import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:renters_management_front_end/app/models/build_model.dart';
import 'package:renters_management_front_end/app/models/result.dart';
import 'package:renters_management_front_end/app/services/build_services.dart';

import '../models/rent_payments_model.dart';
import '../models/renter_model.dart';
import 'http_provider/http_provider.dart';

class YearServices {
  static Future<Result<List<Renter>>> fetchRenters(int buildId,
      {bool hardFetch = false}) async {
    Result<Build> res = await BuildServices.fetchBuild(id: buildId);
    if (res.data != null && res.data?.renters != null && !hardFetch) {
      return Result(
          data: res.data!.renters,
          statusCode: 200,
          hasError: false,
          message: "successful");
    }
    Response? response;
    try {
      response = await HttpProvider.get("user/builds/$buildId/renters");
      if (response?.statusCode == 200) {
        List result = response?.data["Renters"];
        List<Renter> renters = [];
        for (int i = 0; i < result.length; i++) {
          renters.add(Renter.fromJson(result[i]));
        }
        BuildServices.setBuildRenters(buildId, renters);
        return Result(
            data: renters,
            hasError: false,
            statusCode: response?.statusCode,
            message: "successful");
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return Result(
          hasError: true,
          statusCode: 621,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: response?.statusCode ?? 623,
        message: response?.data["message"] ?? "some thing wrong",
        data: null);
  }

  static Future<Result<bool>> addYearToRenter(
      {required int buildId,
      required int renterId,
      required Map<String, dynamic> data,
      bool hardFetch = false}) async {
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
          statusCode: 626,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: response?.statusCode ?? 623,
        message: response?.data["message"] ?? "some thing wrong",
        data: null);
  }

  static Future<Result<bool>> deleteYearFromRenter(
      {required int buildId,
      required int renterId,
      required Map<String, dynamic> data,
      bool hardFetch = false}) async {
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
          statusCode: 627,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: response?.statusCode ?? 700,
        message: response?.data["message"] ?? "some thing wrong",
        data: null);
  }
}
