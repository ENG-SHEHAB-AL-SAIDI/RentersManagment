import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:renters_management_front_end/app/models/build_model.dart';
import 'package:renters_management_front_end/app/models/rent_payments_installment_model.dart';
import 'package:renters_management_front_end/app/models/rent_payments_model.dart';
import 'package:renters_management_front_end/app/models/result.dart';
import 'package:renters_management_front_end/app/services/build_services.dart';
import 'package:renters_management_front_end/app/services/renter_services.dart';

import '../models/renter_model.dart';
import 'http_provider/http_provider.dart';

class RentPaymentServices {
  static Future<Result<Map<String, List<RentPayment>>>> fetchRentPayments(
      {required int buildId,
      required int renterId,
      bool hardFetch = false}) async {
    Result<Renter> res = await RenterServices.fetchRenter(buildId, renterId);
    if (res.data != null && res.data?.rentPayments != null && !hardFetch) {
      return Result(
          data: res.data!.rentPayments,
          statusCode: 200,
          hasError: false,
          message: "successful");
    }

    late Response? response;
    try {
      response =
          await HttpProvider.get("user/renters/$renterId/rent_payments/");
      if(response?.statusCode == 200){
        Map<String, dynamic> result = response?.data["grouped_rent_payments"];
        Map<String, RxList<RentPayment>> rentPayments = {};
        if (result.isNotEmpty) {
          for (String key in result.keys) {
            List<RentPayment> rentPaymentsItems = [];
            for (var item in result[key]) {
              rentPaymentsItems.add(RentPayment.fromJson(item));
            }
            rentPayments[key]?.value = rentPaymentsItems;
          }
        }
        res.data?.rentPayments = RxMap<String, RxList<RentPayment>>(rentPayments);
        return Result(
            data: rentPayments,
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
          statusCode: 641,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: response?.statusCode?? 700,
        message: response?.data["message"]?? "some thing wrong",
        data: null);
  }

  static Future<Result<RentPayment>> fetchRentPayment(
      {required int buildId,
      required int renterId,
      required int rentPaymentID,
      bool hardFetch = false}) async {
    Result<Renter> res = await RenterServices.fetchRenter(buildId, renterId);
    if (res.data != null && res.data?.rentPayments != null && !hardFetch) {
      for (String key in res.data?.rentPayments?.keys ?? {}) {
        for (RentPayment rentPayment in res.data?.rentPayments?[key] ?? []) {
          if (rentPayment.id.value == rentPaymentID) {
            return Result(
                data: rentPayment,
                statusCode: 200,
                hasError: false,
                message: "successful");
          }
        }
      }
    }

    late Response? response;
    try {
      response = await HttpProvider.post(
          "user/renters/$renterId/rent_payments/$rentPaymentID");

      Map<String, dynamic> result = response?.data["rent_payment"];
      RentPayment rentPayment = RentPayment.fromJson(result);

      int? index = res.data?.rentPayments?[rentPayment.year?.value]
          ?.indexWhere((e) => e.id == rentPayment.id);
      if (index != null) {
        res.data?.rentPayments?[rentPayment.year?.value]?[index] = rentPayment;
      } else {
        res.data?.rentPayments?[rentPayment.year?.value]?.add(rentPayment);
      }

      return Result(
          data: rentPayment,
          hasError: false,
          statusCode: response?.statusCode,
          message: "successful");
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      Result(
          hasError: true,
          statusCode: 642,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: response?.statusCode?? 700,
        message: response?.data["message"]?? "some thing wrong",
        data: null);
  }


  static Future<Result<RentPayment>> updateRentPayment(
      {required int renterId,
      required int rentPaymentId,
      required Map<String, dynamic> data,
      bool hardFetch = false}) async {
    Response? response;
    try {
      response = await HttpProvider.patch(
          "user/renters/$renterId/rent_payments/$rentPaymentId",
          data: data);
      if (response?.statusCode == 200) {
        RentPayment rentPayment = RentPayment.fromJson(response?.data["rent_payment"]);
        return Result(
            data: rentPayment,
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
          statusCode: 644,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: response?.statusCode?? 700,
        message: response?.data["message"]?? "some thing wrong",
        data: null);
  }


  static Future<Result<Build>> deleteRenter(
      {required int buildId,
      required int renterId,
      bool hardFetch = false}) async {
    Result<Build> res = await BuildServices.fetchBuild(id: buildId);
    Response? response;
    try {
      response = await HttpProvider.delete(
          "user/builds/$buildId/renters/$renterId");
      if (response?.statusCode == 200) {
        res.data?.renters
            ?.removeWhere((element) => element.id.value == renterId);
        return Result(
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
          statusCode: 645,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: 625,
        message: "some thing wrong",
        data: null);
  }

  static Future<Result<bool>> rentPaymentAddInstallment(
      {required int buildId,
      required int renterId,
      required int rentPaymentId,
      required Map<String, dynamic> data,
      bool hardFetch = false}) async {
    Result<RentPayment> rentPayment = await fetchRentPayment(
        buildId: buildId, renterId: renterId, rentPaymentID: rentPaymentId);
    Response? response;
    try {
      response = await HttpProvider.post(
          "user/rent_payments/$rentPaymentId/installments",
          data: data);
      if (response?.statusCode == 200) {
        RentPaymentsInstallment installment =
            RentPaymentsInstallment.fromJson(response?.data["installment"]);
        rentPayment.data?.remainAmount?.value =
            double.tryParse(response?.data["remain_amount"])??0;
        rentPayment.data?.payedAmount?.value =
            double.tryParse(response?.data["payed_amount"])??0;
        rentPayment.data?.state?.value = response?.data["state"];
        rentPayment.data?.rentPaymentsInstallment?.add(installment);
        return Result(
            hasError: false,
            statusCode: response?.statusCode,
            message: response?.statusMessage,
            data: true);
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return Result(
          hasError: true,
          statusCode: 646,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: response?.statusCode?? 700,
        message: response?.data["message"]?? "some thing wrong",
        data: null);
  }

  static Future<Result<bool>> rentPaymentDeleteInstallment(
      {required int buildId,
      required int renterId,
      required int rentPaymentId,
      required int installmentId,
      bool hardFetch = false}) async {
    Result<RentPayment> rentPayment = await fetchRentPayment(
        buildId: buildId, renterId: renterId, rentPaymentID: rentPaymentId);
    Response? response;
    try {
      response = await HttpProvider.delete(
          "user/rent_payments/$rentPaymentId/installments/$installmentId");
      if (response?.statusCode == 200) {
        rentPayment.data?.remainAmount?.value =
            double.tryParse(response?.data["remain_amount"])??0;
        rentPayment.data?.payedAmount?.value =
            double.tryParse(response?.data["payed_amount"])??0;
        rentPayment.data?.state?.value = response?.data["state"];
        rentPayment.data?.rentPaymentsInstallment
            ?.removeWhere((e) => e.id.value == installmentId);
        return Result(
            hasError: false,
            statusCode: response?.statusCode,
            message: response?.statusMessage,
            data: true);
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return Result(
          hasError: true,
          statusCode: 647,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: response?.statusCode?? 700,
        message: response?.data["message"]?? "some thing wrong",
        data: null);
  }
}
