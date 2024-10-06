import 'package:dio/dio.dart';
import 'package:renters_management_front_end/app/models/build_model.dart';
import 'package:renters_management_front_end/app/models/result.dart';
import 'package:renters_management_front_end/app/services/build_services.dart';
import '../models/renter_model.dart';
import 'api/api_end_points.dart';
import 'api/http_provider.dart';

class RenterServices {


  static Future<Result<List<Renter>>> fetchRenters(int buildId,{bool hardFetch = false}) async {
    Result<Build> res = await BuildServices.fetchBuild(id: buildId);
    if (res.data != null && res.data?.renters != null && !hardFetch) {
      return Result(data: res.data!.renters, statusCode: 200,hasError: false, message: "successful");
    }

    late Response response;
    try {
      response = await HttpProvider.get("${EndPoints.getBuilds}/$buildId/${EndPoints.getRenters}");
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

  static Future<Result<Renter>> fetchRenter(int buildId, int renterId,{bool hardFetch = false}) async {
    Result<Build> res = await BuildServices.fetchBuild(id: buildId);
    if (res.data != null && res.data?.renters != null && !hardFetch) {
      for(Renter renter in res.data?.renters??[]){
        if(renter.id.value == renterId){
           return Result(data: renter,statusCode: 200, hasError: false, message: "successful");
        }
      }
    }

    late Response response;
    try {
      response = await HttpProvider.post("${EndPoints.getBuilds}/$buildId/ ${EndPoints.getRenters}/$renterId");
      Map<String,dynamic> result = response.data["Renter"];
      List<Renter>? renters = res.data?.renters??[];
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
      return Result(hasError: true, statusCode: 600,message: error.message);
    }
  }



  static void write() {}
}
