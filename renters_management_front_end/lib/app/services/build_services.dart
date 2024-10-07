import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:renters_management_front_end/app/models/result.dart';

import '../models/build_model.dart';
import '../models/renter_model.dart';
import 'api/api_end_points.dart';
import 'api/http_provider.dart';

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
    Response response;
    try {
      _builds = [];
      response = await HttpProvider.get(EndPoints.getBuilds);
      List result = response.data["Builds"];

      for (int i = 0; i < result.length; i++) {
        _builds.add(Build.fromJson(result[i]));
      }
      return Result(
          data: _builds,
          hasError: false,
          statusCode: response.statusCode,
          message: "successful");
    } on DioException catch (error) {
      if (error.response != null) {
        return Result(
            hasError: true,
            statusCode: error.response?.statusCode,
            message: error.response?.data);
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
    return Result(hasError: true, statusCode: 600, message: "some thing wrong");
  }

  static Future<Result<Build>> fetchBuild(
      {required int id,bool hardFetch = false}) async {
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

    Response response;
    try {
      for (Build build in _builds) {
        if (build.id.value == id) {
          _builds.remove(build);
        }
      }

      response = await HttpProvider.get("${EndPoints.getBuilds}/$id");
      build0 = Build.fromJson(response.data);
      _builds.add(build0);
      return Result(
          data: build0,
          hasError: false,
          statusCode: response.statusCode,
          message: "successful");
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

  static Future<Result<Build>> storeBuild(
      {required Map<String, dynamic> data, bool hardFetch = false}) async {
    Response response;
    try {
      response =
          await HttpProvider.post(EndPoints.getBuilds, data: data);
      if (response.statusCode == 200) {
        Build build0 = Build.fromJson(response.data["Build"]);
        _builds.add(build0);

        return Result(
            data: build0,
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

  static Future<Result<Build>> updateBuild(
      {required int id ,required Map<String, dynamic> data, bool hardFetch = false}) async {
    Response response;
    try {
      response =
      await HttpProvider.patch("${EndPoints.getBuilds}/$id", data: data);
      if (response.statusCode == 200) {
        Build build0 = Build.fromJson(response.data["Build"]);
        _builds[_builds.indexWhere((element)=>element.id.value == id)] = build0;

        return Result(
            data: build0,
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

  static Future<Result<Build>> deleteBuild(
      {required int id, bool hardFetch = false}) async {
    Response response;
    try {
      response = await HttpProvider.delete("${EndPoints.getBuilds}/$id");
      if (response.statusCode == 200) {
        _builds.removeWhere((element) => element.id.value == id);
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

  static void setBuildRenters(int buildId, List<Renter> renters) {
    for (int i = 0; i < _builds.length; i++) {
      if (_builds[i].id.value == buildId) {
        _builds[i].renters = renters;
      }
    }
  }





}
