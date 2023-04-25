

import 'api_repo.dart';

class ApiRepoImp extends ApiRepo {
  @override
  Future getGetApiResponse(String url) async {
    try {
      dynamic response = await apiService.getGetApiResponse(url);
    return response;
    } catch (e) {
      rethrow;
    }

  }
}
