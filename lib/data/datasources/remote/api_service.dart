import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../errors/app_exceptions.dart';

class ApiService {

  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnAuthorisedException(response.body.toString());
      default:
        throw FetchDataException('Something went wrong ${response.statusCode.toString()}');
    }
  }
}
