import 'package:dio/dio.dart';
import 'package:renters_management_front_end/app/models/result.dart';
import '../models/build_model.dart';
import 'api/api_end_points.dart';
import 'api/http_provider.dart';

class BuildModel{

  static final List<Build> _builds = [];

  static Future<Result<List<Build>>> fetchBuilds({bool hardFetch = false}) async {
    if(_builds.isNotEmpty && !hardFetch){
      return Result(data: _builds,hasError: false,message: "successful");
    }
    Response? response;
    try{
      response = await HttpProvider.get(EndPoints.getBuilds);
      List result = response.data["Builds"];
      for(int i=0;i<result.length;i++){
        _builds.add(Build.fromJson(result[i]));
      }
    }catch(error){
      return Result(data: _builds,hasError: true, statusCode: response?.statusCode,message: response?.data["message"]);
    }
    return Result(data: _builds,hasError: false, statusCode: response.statusCode,message: "successful");
  }

  static Future<Build?> fetchBuild(int id,{bool hardFetch = false}) async {
    Build build0;
    if(_builds.isNotEmpty && !hardFetch){
      for (Build build in _builds){
        if(build.id.value == id){
          return build;
        }
      }
    }
    Response response;
    try{
      response = await HttpProvider.get("${EndPoints.getBuild}/$id");
      build0 = Build.fromJson(response.data);
      _builds.add(build0);
      return build0;
    }catch(error){
      print(error);
    }
    return null;
  }



}