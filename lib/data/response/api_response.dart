


import 'package:fu_vms/data/response/status.dart';

class ApiResponse<T> {


  Status? status;

  String? message;

  ApiResponse(this.status,this.message);

  ApiResponse.loading() : status = Status.LOADING;
  ApiResponse.completed() : status = Status.COMPLETED;
  ApiResponse.error(this.message) : status = Status.ERROR;


  @override
  String toString(){
    return "Status : $status \n Message : $message";
  }

}