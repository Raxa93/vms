

import 'package:flutter/cupertino.dart';
import '../../../data/base/base_vm.dart';
import '../../../data/models/brewry_model.dart';
import '../../../data/repositories/api_repo/api_repo_imp.dart';
import '../../../data/response/api_response.dart';
import '../../../locator.dart';
import '../../constants/app_strings.dart';

class BreweryVm extends BaseVm{

  final ApiRepoImp _repo = locator<ApiRepoImp>();
  List<BreweryModel> breweryList = [];
  ApiResponse<BreweryModel> breweryResponse = ApiResponse.loading();

  setBreweryList(ApiResponse<BreweryModel> response) {
    breweryResponse = response;
    notifyListeners();
  }

  Future<void> fetchBreweryList() async {

    setBreweryList(ApiResponse.loading());

    _repo.getGetApiResponse(AppUrls.baseUrl).then((value) {

      for(var element in value){
        // print('This is element i got ${elemnt}');
        breweryList.add(BreweryModel.fromJson(element));
      }
      debugPrint('This is length ${breweryList.length}');

      setBreweryList(ApiResponse.completed());

    }).onError((error, stackTrace)
    {
      setBreweryList(ApiResponse.error(error.toString()));
    });
  }



}