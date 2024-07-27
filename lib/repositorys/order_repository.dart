import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:store_app/models/failure.dart';
import 'package:store_app/models/order_detail.dart';
import 'package:store_app/models/order_model.dart';
import 'package:store_app/services/order_service.dart';

class OrderRepository {
  final OrderService service = OrderService();

  Future<Either<Failure, OrderModel>> getOrderData({required int statusList,required int limit,required int pageNumber}) async {
    try {
      final result = await service.getOrderData(statusList: statusList, limit: limit, pageNumber: pageNumber);
      return Right(result);
    } catch (e) {
      return Left(Failure('$e'));
    }
  }

  Future<Either<Failure, OrderDetailModel>> getOrderDetailById(
      {required String id}) async {
    try {
      final result = await service.getOrderDataById(id: id);
      return Right(result);
    } catch (e) {
      return Left(Failure('$e'));
    }
  }

  Future<Either<Failure, dynamic>> confirmOrder(
      {required String orderId}) async {
    try {
      final result = await service.confirmOrder(orderId: orderId);
      return Right(result);
    } catch (e) {
      return Left(Failure('$e'));
    }
  }

  Future<Either<Failure, dynamic>> cancelOrder(
      {required String orderId,required String reasonForCancel}) async {
    try {
      final result = await service.cancelOrder(orderId: orderId,reasonForCancel: reasonForCancel);
      return Right(result);
    } catch (e) {
      return Left(Failure('$e'));
    }
  }
}
