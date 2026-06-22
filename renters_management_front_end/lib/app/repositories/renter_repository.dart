import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:renters_management_front_end/app/models/build_model.dart';
import 'package:renters_management_front_end/app/models/result.dart';
import 'package:renters_management_front_end/app/repositories/build_repository.dart';
import 'package:get/get.dart' as get_x;

import '../components/loading_card.dart';
import '../models/renter_model.dart';
import '../services/http_provider/http_provider.dart';

class RenterServices {

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
        statusCode: response?.statusCode?? 623,
        message: response?.data["message"]?? "some thing wrong",
        data: null);

  }

  static Future<Result<Renter>> fetchRenter(int buildId, int renterId,
      {bool hardFetch = false}) async {
    Result<Build> res = await BuildServices.fetchBuild(id: buildId);
    if (res.data != null && res.data?.renters != null && !hardFetch) {
      for (Renter renter in res.data?.renters ?? []) {
        if (renter.id.value == renterId) {
          return Result(
              data: renter,
              statusCode: 200,
              hasError: false,
              message: "successful");
        }
      }
    }

    late Response? response;
    try {
      response =
          await HttpProvider.post("user/builds/$buildId/renters/$renterId");
      Map<String, dynamic> result = response?.data["Renter"];
      List<Renter>? renters = res.data?.renters ?? [];
      Renter renter = Renter.fromJson(result);
      renters.add(renter);
      BuildServices.setBuildRenters(buildId, renters);
      return Result(
          data: renter,
          hasError: false,
          statusCode: response?.statusCode,
          message: "successful");
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      Result(
          hasError: true,
          statusCode: 622,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: response?.statusCode?? 623,
        message: response?.data["message"]?? "some thing wrong",
        data: null);

  }

  static Future<List<Renter>> getRentersGroup(int buildId, List<int> ids,
      {bool hardFetch = false}) async {
    Result<Build> res = await BuildServices.fetchBuild(id: buildId);
    List<Renter> rentersGroup = [];
    res.data!.renters?.forEach((element){
      if(ids.contains(element.id.value)){
        rentersGroup.add(element);
      }
    });
    return rentersGroup;
  }

  static Future<Result<Renter>> storeRenter(
      {required int buildId,
      required Map<String, dynamic> data,
      bool hardFetch = false}) async {
    get_x.Get.dialog(const PopUpLoadingCard(),barrierDismissible: false);
    Result<Build> res = await BuildServices.fetchBuild(id: buildId);
    Response? response;
    try {
      response =
          await HttpProvider.post("user/builds/$buildId/renters", data: data);
      if (response?.statusCode == 200) {
        if (response?.data != null) {
          Renter renter0 = Renter.fromJson(response?.data["Renter"]);
          res.data?.renters?.add(renter0);
          res.data?.numRenters?.value += 1;
          return Result(
              data: renter0,
              statusCode: response?.statusCode,
              hasError: false,
              message: "successful");
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      Result(
          hasError: true,
          statusCode: 623,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: response?.statusCode?? 623,
        message: response?.data["message"]?? "some thing wrong",
        data: null);
  }

  static Future<Result<Renter>> updateRenter(
      {required int buildId,
      required int renterId,
      required Map<String, dynamic> data,
      bool hardFetch = false}) async {
    get_x.Get.dialog(const PopUpLoadingCard(),barrierDismissible: false);
    Result<Build> res = await BuildServices.fetchBuild(id: buildId);
    Response? response;
    try {
      response = await HttpProvider.patch(
          "user/builds/$buildId/renters/$renterId",
          data: data);
      if (response?.statusCode == 200) {
        Renter renter0 = Renter.fromJson(response?.data["Renter"]);
        if (res.data?.renters?.indexWhere((e) => e.id.value == renterId) !=
            null) {
          res.data?.renters?[res.data!.renters!
              .indexWhere((e) => e.id.value == renterId)] = renter0;
        }
        return Result(
            data: renter0,
            statusCode: response?.statusCode,
            hasError: false,
            message: "successful");
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return Result(
          hasError: true,
          statusCode: 624,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: response?.statusCode?? 623,
        message: response?.data["message"]?? "some thing wrong",
        data: null);
  }

  static Future<Result<Build>> deleteRenter(
      {required int buildId,
      required int renterId,
      bool hardFetch = false}) async {
    get_x.Get.dialog(const PopUpLoadingCard(),barrierDismissible: false);
    Result<Build> res = await BuildServices.fetchBuild(id: buildId);
    Response? response;
    try {
      response =
          await HttpProvider.delete("user/builds/$buildId/renters/$renterId");
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
          statusCode: 625,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: response?.statusCode?? 623,
        message: response?.data["message"]?? "some thing wrong",
        data: null);
  }

  static Future<Result<bool>> renterAddPhone(
      {required int buildId,
      required int renterId,
      required Map<String, dynamic> data,
      bool hardFetch = false}) async {
    get_x.Get.dialog(const PopUpLoadingCard(),barrierDismissible: false);
    Result<Build> res = await BuildServices.fetchBuild(id: buildId);
    Response? response;
    try {
      if (!(res.data?.renters
              ?.firstWhere((e) => e.id.value == renterId)
              .phones!
              .contains(RxString(data['phone'])) ??
          false)) {
        response =
            await HttpProvider.post("user/renters/$renterId/phones", data: data);
        if (response?.statusCode == 200) {
          if (!(res.data?.renters
                  ?.firstWhere((e) => e.id.value == renterId)
                  .phones!
                  .contains(RxString(data['phone'])) ??
              false)) {
            res.data?.renters
                ?.firstWhere((e) => e.id.value == renterId)
                .phones
                ?.insert(0, RxString(data['phone']));
          }
          return Result(
              hasError: true,
              statusCode: response?.statusCode,
              data: true);
        }
      } else {
        Result(
            hasError: true,
            statusCode: 701,
            message: "this phone already exist",
            data: null);
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
        statusCode: response?.statusCode?? 623,
        message: response?.data["message"]?? "some thing wrong",
        data: null);
  }

  static Future<Result<bool>> renterDeletePhone(
      {required int buildId,
      required int renterId,
      required Map<String, dynamic> data,
      bool hardFetch = false}) async {
    get_x.Get.dialog(const PopUpLoadingCard(),barrierDismissible: false);
    Result<Build> res = await BuildServices.fetchBuild(id: buildId);
    Response? response;
    try {
      response =
          await HttpProvider.delete("user/renters/$renterId/phones", data: data);
      if (response?.statusCode == 200) {
        res.data?.renters
            ?.firstWhere((e) => e.id.value == renterId)
            .phones
            ?.removeWhere((e) => e.value == data['phone']);
        return Result(
            data: true,
            statusCode: response?.statusCode,
            hasError: false,
            message: "successful");
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
        statusCode: response?.statusCode?? 700,
        message: response?.data["message"]?? "some thing wrong",
        data: null);
  }
}
