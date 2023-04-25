


import '../../base/base_repo.dart';

abstract class ApiRepo extends BaseRepo {

  Future<dynamic> getGetApiResponse(String url);

}