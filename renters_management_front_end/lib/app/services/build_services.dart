import 'package:dio/dio.dart';
import '../models/build_model.dart';
import 'api/api_end_points.dart';
import 'api/http_provider.dart';

class BuildModel{

  static List<Build> _builds = [];
  static Future<List<Build>?> fetchBuilds({bool hardFetch = false}) async {
    if(_builds.isNotEmpty && !hardFetch){
      return _builds;
    }
    Response response;
    try{
      response = await HttpProvider.get(EndPoints.getBuilds);
      List result = response.data["Builds"];
      for(int i=0;i<result.length;i++){
        _builds.add(Build.fromJson(result[i]));
      }
      return _builds;

    }catch(error){
      print(error);
    }
    return null;
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