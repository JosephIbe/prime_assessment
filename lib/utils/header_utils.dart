import 'dart:io';
import 'dart:developer';

import 'package:primed_health/common/db_constants.dart';

import 'package:hive/hive.dart';

class HeaderUtils {

  Map<String, String> getNonTokenatedHeaders() {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Charset": "utf-8"
    };
    return headers;
  }

  Future<dynamic> getTokenatedHeaders() async {

    final box = Hive.box(DBConstants.appBoxName);
    String? token = box.get(DBConstants.jwtToken);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Charset": "utf-8"
    };
    log('token in headers:\n$token');

    if(token!.isNotEmpty){
      headers.addAll({
        HttpHeaders.authorizationHeader: 'Bearer $token'
      });
    }

    return headers;
  }

  Future<dynamic> getMultipartTokenHeaders() async {

    final box = Hive.box(DBConstants.appBoxName);
    String? token = box.get(DBConstants.jwtToken);

    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      "Charset": "utf-8"
    };
    log('token in multipart headers:\n$token');

    if(token!.isNotEmpty){
      headers.addAll({
        HttpHeaders.authorizationHeader: 'Bearer $token'
      });
    }

    return headers;
  }

}