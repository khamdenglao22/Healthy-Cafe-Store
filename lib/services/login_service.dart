import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:store_app/constants/api_paths.dart';
import 'package:store_app/models/api_response.dart';
import 'package:store_app/services/app_exceptions.dart';
import 'package:store_app/services/base_service.dart';
import 'package:store_app/services/network_call.dart';

class LoginService extends BaseService {
  final storage = const FlutterSecureStorage();
  final NetworkCall _networkCall = NetworkCall();
  final Logger consolog = Logger();

  Future<dynamic> login(
      {required String username, required String password}) async {
    try {
      final hearder = {
        HttpHeaders.contentTypeHeader: 'application/json',
      };
      final reqestBody = {'username': username, 'password': password};
      var response = await _networkCall.request(
        paths: ApiPaths.loginPath,
        method: ApiPaths.postRequest,
        headers: hearder,
        body: reqestBody,
      );
      consolog.d('token =  ${response.statusCode}');
      if (response.statusCode == 200) {
        final str = await response.stream.bytesToString();
        consolog.d('data =  ${str}');
        return str;
      }
      throw AppException('${response.reasonPhrase}', '');
    } catch (e) {
      throw AppException('$e', '');
    }
  }

  Future<dynamic> validateToken() async {
    try {
      final token = await storage.read(key: 'token');
      if (token != null) {
        return token;
        // throw AppException('Have Token', '');
      }
      throw AppException('token null', '');
    } catch (e) {
      log('Error = $e');
      rethrow;
    }
  }

  Future<bool> saveToken({
    required String token,
  }) async {
    try {
      await storage.write(key: 'token', value: token);
      //log('save token sccuss');
      return true;
    } catch (e) {
      throw AppException('$e', '');
    }
  }

  Future<bool> removeToken() async {
    try {
      await storage.delete(key: 'token');
      return true;
    } catch (e) {
      throw AppException('$e', '');
    }
  }
}
