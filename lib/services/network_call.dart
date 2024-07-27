import 'dart:convert';
import 'dart:developer' as logs;
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:store_app/constants/api_paths.dart';
import 'package:store_app/services/app_exceptions.dart';

class NetworkCall {
  final _storage = const FlutterSecureStorage();
  final Logger log = Logger();
  Future<dynamic> request({
    required String paths,
    required method,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    dynamic requestBody;
    final url = Uri.parse(paths);
    if (body != null) {
      requestBody = jsonEncode(body);
    }
    // Add JWT token to header
    final jwtToken = await getJwtToken();
    if (headers == null) {
      headers = {'Authorization': 'Bearer $jwtToken'};
    } else {
      headers.putIfAbsent('Authorization', () => 'Bearer $jwtToken');
    }

    log.d('Request: $method => $url, headers = $headers, body = $requestBody');

    try {
      // dynamic response;
      http.StreamedResponse response;
      try {
        switch (method) {
          case ApiPaths.getRequest:
            var request = http.Request('GET', url);
            request.headers.addAll(headers);
            response = await request.send();
            // response = await http.get(url, headers: headers);
            break;
          case ApiPaths.postRequest:
            var request = http.Request('POST', url);
            request.body = requestBody;
            request.headers.addAll(headers);
            response = await request.send();
            // response = await http.post(url, headers: headers, body: requestBody);
            break;
          case ApiPaths.putRequest:
            var request = http.Request('PUT', url);
            request.body = requestBody;
            request.headers.addAll(headers);
            response = await request.send();
            // response = await http.put(url, headers: headers, body: requestBody);
            break;
          case ApiPaths.patchRequest:
            var request = http.Request('PATCH', url);
            request.body = requestBody;
            request.headers.addAll(headers);
            response = await request.send();
            // response = await http.patch(url, headers: headers, body: requestBody);
            break;
          case ApiPaths.deleteRequest:
            var request = http.Request('DELETE', url);
            request.body = requestBody;
            request.headers.addAll(headers);
            response = await request.send();
            // response = await http.delete(url, headers: headers, body: requestBody);
            break;
          default:
            var request = http.Request('DELETE', url);
            request.headers.addAll(headers);
            response = await request.send();
          // response = await http.get(url, headers: headers);
        }
      } on SocketException catch (e) {
        throw FetchDataException('No Internet connection');
      } on FormatException {
        throw FetchDataException('Error while parsing response');
      } catch (e) {
        logs.log('error this = $e');
        throw AppException('$e', '');
      }
      switch (response.statusCode) {
        case HttpStatus.ok:
          return response;
        // return json.decode(response.body);
        case HttpStatus.badRequest:
          throw BadRequestException(
              'Your request is invalid ${HttpStatus.badRequest}');
        case HttpStatus.unauthorized:
          throw UnauthorisedException('Invalid credentials');
        case HttpStatus.forbidden:
          throw ForbiddenException(
              'Access to the resources on the server is denied! ${HttpStatus.forbidden}');
        case HttpStatus.notFound:
          final str = await response.stream.bytesToString();
          final Map<String, dynamic> data = json.decode(str);
          throw NotFoundException('${data['message']}');
        case HttpStatus.internalServerError:
          throw ServerException('Something went wrong on server side');
        default:
          throw FetchDataException(
              'Error occured while communication with server');
      }
    } catch (e) {
      throw AppException('$e', '');
    }
  }

  Future<String?> getJwtToken() async {
    return _storage.read(key: 'token');
  }
}
