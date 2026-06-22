import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:renters_management_front_end/app/models/result.dart';
import 'package:renters_management_front_end/app/models/statement_model.dart';
import '../components/loading_card.dart';
import '../models/build_model.dart';
import '../models/renter_model.dart';
import '../services/http_provider/http_provider.dart';
import 'package:get/get.dart' as get_x;

class BuildServices {
  static List<Build> _builds = [];

  static Future<Result<List<Build>>> fetchBuilds(
      {bool hardFetch = false}) async {
    if (_builds.isNotEmpty && !hardFetch) {
      return Result(
          data: _builds,
          statusCode: 200,
          hasError: false,
          message: "successful");
    }
    Response? response;
    try {
      _builds = [];
      response = await HttpProvider.get("user/builds");
      List result = response?.data["Builds"];
      for (int i = 0; i < result.length; i++) {
        _builds.add(Build.fromJson(result[i]));
      }
      return Result(
          data: _builds,
          hasError: false,
          statusCode: response?.statusCode,
          message: "successful");
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return Result(
          hasError: true,
          statusCode: response?.statusCode?? 700,
          message: response?.data["message"]?? "some thing wrong",
          data: null);
    }
  }

  static Future<Result<Build>> fetchBuild(
      {required int id, bool hardFetch = false}) async {
    Build build0;
    if (_builds.isNotEmpty && !hardFetch) {
      for (Build build in _builds) {
        if (build.id.value == id) {
          return Result(
              data: build,
              statusCode: 200,
              hasError: false,
              message: "successful");
        }
      }
    }

    Response? response;
    try {
      for (Build build in _builds) {
        if (build.id.value == id) {
          _builds.remove(build);
        }
      }

      response = await HttpProvider.get("user/builds/$id");
      build0 = Build.fromJson(response?.data);
      _builds.add(build0);
      return Result(
          data: build0,
          hasError: false,
          statusCode: response?.statusCode,
          message: "successful");
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return Result(
          hasError: true,
          statusCode: response?.statusCode?? 700,
          message: response?.data["message"]?? "some thing wrong",
          data: null);
    }
  }

  static Future<Result<Build>> storeBuild(
      {required Map<String, dynamic> data, bool hardFetch = false}) async {
    get_x.Get.dialog(const PopUpLoadingCard(),barrierDismissible: false);
    Response? response;
    try {
      response = await HttpProvider.post("user/builds", data: data);
      if (response?.statusCode == 200) {
        Build build0 = Build.fromJson(response?.data["Build"]);
        _builds.add(build0);
        return Result(
            data: build0,
            statusCode: response?.statusCode,
            hasError: false,
            message: "successful");
      }
    }  catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return Result(
          hasError: true,
          statusCode: 613,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: response?.statusCode?? 700,
        message: response?.data.toString()?? "some thing wrong",
        data: null);
  }


  static Future<Result<Build>> updateBuild(
      {required int id,
      required Map<String, dynamic> data,
      bool hardFetch = false}) async {
    get_x.Get.dialog(const PopUpLoadingCard(),barrierDismissible: false);
    Response? response;
    try {
      response =
          await HttpProvider.patch("user/builds/$id", data: data);
      if (response?.statusCode == 200) {
        Build build0 = Build.fromJson(response?.data["Build"]);
        _builds[_builds.indexWhere((element) => element.id.value == id)] =
            build0;

        return Result(
            data: build0,
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
          statusCode: 614,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: response?.statusCode?? 700,
        message: response?.data["message"]?? "some thing wrong",
        data: null);
  }

  static Future<Result<Build>> deleteBuild(
      {required int id, bool hardFetch = false}) async {
    get_x.Get.dialog(const PopUpLoadingCard(),barrierDismissible: false);
    Response? response;
    try {
      response = await HttpProvider.delete("user/builds/$id");
      if (response?.statusCode == 200) {
        _builds.removeWhere((element) => element.id.value == id);
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
          statusCode: 615,
          message: error.toString(),
          data: null);
    }
    return Result(
        hasError: true,
        statusCode: response?.statusCode?? 700,
        message: response?.data["message"]?? "some thing wrong",
        data: null);
  }

  static Future<List<String>> getBuildYears(int buildId) async{
    List<String> years = [];
    Build? build = await fetchBuild(id: buildId).then((res)=>res.data);
    for (Renter renter in (build?.renters??[])) {
      for (String year in (renter.rentPayments?.keys??[])) {
        if(!years.contains(year)){
          years.add(year);
        }
      }
    }
    return years;
  }



  static void setBuildRenters(int buildId, List<Renter> renters) {
    for (int i = 0; i < _builds.length; i++) {
      if (_builds[i].id.value == buildId) {
        _builds[i].renters = renters;
      }
    }
  }

  static void setBuildStatements(int buildId, Map<String,List<Statement>> statements) {
    for (int i = 0; i < _builds.length; i++) {
      if (_builds[i].id.value == buildId) {
        _builds[i].statements = statements;
      }
    }
  }

}
