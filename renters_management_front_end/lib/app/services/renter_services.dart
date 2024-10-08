import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:renters_management_front_end/app/models/build_model.dart';
import 'package:renters_management_front_end/app/models/result.dart';
import 'package:renters_management_front_end/app/services/build_services.dart';

import '../models/renter_model.dart';
import 'api/api_end_points.dart';
import 'api/http_provider.dart';

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

    late Response response;
    try {
      response = await HttpProvider.get(
          "${EndPoints.getBuilds}/$buildId/${EndPoints.getRenters}");
      List result = response.data["Renters"];
      List<Renter> renters = [];
      for (int i = 0; i < result.length; i++) {
        renters.add(Renter.fromJson(result[i]));
      }
      BuildServices.setBuildRenters(buildId, renters);
      return Result(
          data: renters,
          hasError: false,
          statusCode: response.statusCode,
          message: "successful");
    } on DioException catch (error) {
      if (error.response != null) {
        return Result(
            hasError: true,
            statusCode: error.response?.statusCode,
            data: error.response?.data);
      }
      return Result(hasError: true, message: error.message);
    }
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

    late Response response;
    try {
      response = await HttpProvider.post(
          "${EndPoints.getBuilds}/$buildId/ ${EndPoints.getRenters}/$renterId");
      Map<String, dynamic> result = response.data["Renter"];
      List<Renter>? renters = res.data?.renters ?? [];
      Renter renter = Renter.fromJson(result);
      renters.add(renter);
      BuildServices.setBuildRenters(buildId, renters);
      return Result(
          data: renter,
          hasError: false,
          statusCode: response.statusCode,
          message: "successful");
    } on DioException catch (error) {
      if (error.response != null) {
        return Result(
            hasError: true,
            statusCode: error.response?.statusCode,
            data: error.response?.data);
      }
      return Result(hasError: true, statusCode: 600, message: error.message);
    }
  }

  static Future<Result<Renter>> storeRenter(
      {required int buildId,
      required Map<String, dynamic> data,
      bool hardFetch = false}) async {
    Result<Build> res = await BuildServices.fetchBuild(id: buildId);
    Response response;
    try {
      response = await HttpProvider.post(
          "${EndPoints.getBuilds}/$buildId/${EndPoints.getRenters}",
          data: data);
      if (response.statusCode == 200) {
        Renter renter0 = Renter.fromJson(response.data["Renter"]);
        res.data?.renters?.add(renter0);
        res.data?.numRenters?.value += 1;
        return Result(
            data: renter0,
            statusCode: response.statusCode,
            hasError: false,
            message: "successful");
      }
    } on DioException catch (error) {
      if (error.response != null) {
        return Result(
            hasError: true,
            statusCode: error.response?.statusCode,
            message: error.message);
      }
      return Result(hasError: true, message: error.message);
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    return Result(hasError: true, statusCode: 600, message: "some thing wrong");
  }

  static Future<Result<Renter>> updateRenter(
      {required int buildId,
        required int renterId,
        required Map<String, dynamic> data,
        bool hardFetch = false}) async {
    Result<Build> res = await BuildServices.fetchBuild(id: buildId);
    Response response;
    try {
      response = await HttpProvider.patch(
          "${EndPoints.getBuilds}/$buildId/${EndPoints.getRenters}/$renterId",
          data: data);
      if (response.statusCode == 200) {
        Renter renter0 = Renter.fromJson(response.data["Renter"]);
        if(res.data?.renters?.indexWhere((e)=>e.id.value == renterId)!=null){
          res.data?.renters?[res.data!.renters!.indexWhere((e)=>e.id.value == renterId)] = renter0;
        }
        return Result(
            data: renter0,
            statusCode: response.statusCode,
            hasError: false,
            message: "successful");
      }
    } on DioException catch (error) {
      if (error.response != null) {
        return Result(
            hasError: true,
            statusCode: error.response?.statusCode,
            message: error.message);
      }
      return Result(hasError: true, message: error.message);
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    return Result(hasError: true, statusCode: 600, message: "some thing wrong");
  }

  static Future<Result<bool>> renterAddPhone(
      {required int buildId,
      required int renterId,
      required Map<String, dynamic> data,
      bool hardFetch = false}) async {

    Result<Build> res = await BuildServices.fetchBuild(id: buildId);
    Response response;
    try {
      if (!(res.data?.renters
          ?.firstWhere((e) => e.id.value == renterId)
          .phones!
          .contains(RxString(data['phone'])) ??
          false)){
        response = await HttpProvider.post("user/renters/$renterId", data: data);
        if (response.statusCode == 200) {
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
              data: true,
              statusCode: response.statusCode,
              hasError: false,
              message: "successful");
        }
        return Result(
            data: false,
            statusCode: 600,
            hasError: false,
            message: "this phone already exist");
      }
    } on DioException catch (error) {
      if (error.response != null) {
        return Result(
            data: false,
            hasError: true,
            statusCode: error.response?.statusCode,
            message: error.response?.data.toString());
      }
      return Result(data: false, hasError: true, message: error.message);
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    return Result(
        data: false,
        hasError: true,
        statusCode: res.statusCode,
        message: res.message);
  }



  static Future<Result<bool>> renterDeletePhone(
      {required int buildId,
        required int renterId,
        required Map<String, dynamic> data,
        bool hardFetch = false}) async {

    Result<Build> res = await BuildServices.fetchBuild(id: buildId);
    Response response;
    try {
        response = await HttpProvider.delete("user/renters/$renterId", data: data);
        if (response.statusCode == 200) {
            res.data?.renters
                ?.firstWhere((e) => e.id.value == renterId)
                .phones
                ?.removeWhere((e)=>e.value == data['phone']);
          return Result(
              data: true,
              statusCode: response.statusCode,
              hasError: false,
              message: "successful");
        }

    } on DioException catch (error) {
      if (error.response != null) {
        return Result(
            data: false,
            hasError: true,
            statusCode: error.response?.statusCode,
            message: error.type.name);
      }
      return Result(data: false, hasError: true, message: error.message);
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }


    return Result(
        data: false,
        hasError: true,
        statusCode: res.statusCode,
        message: res.message);
  }


  static Future<Result<Build>> deleteRenter(
      {required int buildId,
      required int renterId,
      bool hardFetch = false}) async {
    Result<Build> res = await BuildServices.fetchBuild(id: buildId);
    Response response;
    try {
      response = await HttpProvider.delete(
          "${EndPoints.getBuilds}/$buildId/${EndPoints.getRenters}/$renterId");
      if (response.statusCode == 200) {
        res.data?.renters
            ?.removeWhere((element) => element.id.value == renterId);
        return Result(
            hasError: false,
            statusCode: response.statusCode,
            message: "successful");
      }
    } on DioException catch (error) {
      if (error.response != null) {
        return Result(
            hasError: true,
            statusCode: error.response?.statusCode,
            message: error.message);
      }
      return Result(hasError: true, message: error.message);
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    return Result(hasError: true, statusCode: 600, message: "some thing wrong");
  }
}
