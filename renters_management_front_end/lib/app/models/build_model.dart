
import 'package:dio/dio.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:renters_management_front_end/app/models/structures/build_structure.dart';
import 'api/api_end_points.dart';
import 'api/http_provider.dart';

class BuildModel{

  static List<Build>? _builds;
  static Future<List<Build>> fetchBuilds({bool hardFetch = false}) async {
    if(_builds!=null && !hardFetch){
      return _builds!;
    }
    try{
      Response response;
      response = await HttpProvider.get(EndPoints.getBuilds);
      List builds = response.data["Builds"];
      _builds = [];
      for(int i=0;i<builds.length;i++){
        _builds?.add(buildResponseToBuild(builds[i]));
      }
    }catch(erorr){
      throw erorr;
    }
    return _builds!;
  }

  static void fetchBuild(int id){

  }


  static Build buildResponseToBuild(Map<String, dynamic> response) {
    Build build = Build(
      id: RxInt(response['id'] ?? 0),
      name: RxString(response['name'] ?? ""),
      city: RxString(response['city'] ?? ""),
      address: RxString(response['address'] ?? ""),
      deletedAt: RxString(response['deleted_at'] ?? ""),
      createdAt: RxString(response['created_at'] ?? ""),
      updatedAt: RxString(response['updated_at'] ?? ""),
    );
    return build;
  }

}