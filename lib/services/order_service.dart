import 'dart:convert';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:store_app/constants/api_paths.dart';
import 'package:store_app/models/order_detail.dart';
import 'package:store_app/models/order_model.dart';
import 'package:store_app/services/app_exceptions.dart';
import 'package:store_app/services/base_service.dart';
import 'package:store_app/services/network_call.dart';

class OrderService extends BaseService {
  final NetworkCall _networkCall = NetworkCall();
  final Logger consolog = Logger();

  Future<OrderModel> getOrderData(
      {required int statusList,
      required int limit,
      required int pageNumber}) async {
    try {
      var response = await _networkCall.request(
        paths:
            '${ApiPaths.orderPath}?orderStatusList=${statusList}&paymentStatusList=1,2&paymentMethodList=1,2&limit=${limit}&pageNumber=${pageNumber}',
        method: ApiPaths.getRequest,
      );

      if (response.statusCode == 200) {
        final str = await response.stream.bytesToString();
        consolog.d('data =  ${str}');
        // var result = OrderModel.fromJson(json.decode(str));
        // var data = jsonEncode(result.orders);
        // consolog.d('data =  ${data}');
        return orderModelFromJson(str);
      }
      throw AppException('${response.reasonPhrase}', '');
    } catch (e) {
      throw AppException('$e', '');
    }
  }

  Future<OrderDetailModel> getOrderDataById({required String id}) async {
    try {
      var response = await _networkCall.request(
        paths: '${ApiPaths.orderPath}/${id}',
        method: ApiPaths.getRequest,
      );

      if (response.statusCode == 200) {
        final str = await response.stream.bytesToString();
        consolog.d('data =  ${str}');
        return orderDetailModelFromJson(str);
      }
      throw AppException('${response.reasonPhrase}', '');
    } catch (e) {
      throw AppException('$e', '');
    }
  }

  Future<dynamic> confirmOrder({required String orderId}) async {
    try {
      // consolog.d('orderId =  ${orderId}');
      var response = await _networkCall.request(
        paths: '${ApiPaths.orderPath}/${orderId}/confirm',
        method: ApiPaths.postRequest,
        body: {},
      );

      if (response.statusCode == 200) {
        final str = await response.stream.bytesToString();
        consolog.d('data =  ${response.statusCode}');
        return str;
      }
      throw AppException('${response.reasonPhrase}', '');
    } catch (e) {
      throw AppException('$e', '');
    }
  }

  Future<dynamic> cancelOrder(
      {required String orderId, required String reasonForCancel}) async {
    try {
      // consolog.d('orderId =  ${orderId}');
      var response = await _networkCall.request(
        paths:
            '${ApiPaths.orderPath}/${orderId}/cancel?reasonForCancel=${reasonForCancel}',
        method: ApiPaths.postRequest,
        body: {},
      );

      if (response.statusCode == 200) {
        final str = await response.stream.bytesToString();
        consolog.d('data =  ${response.statusCode}');
        return str;
      }
      throw AppException('${response.reasonPhrase}', '');
    } catch (e) {
      throw AppException('$e', '');
    }
  }
}
