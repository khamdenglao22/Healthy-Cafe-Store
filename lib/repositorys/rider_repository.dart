import 'package:dartz/dartz.dart';
import 'package:store_app/models/failure.dart';
import 'package:store_app/models/rider_model.dart';
import 'package:store_app/services/rider_service.dart';

class RiderRepository {
  final RiderService service = RiderService();

  Future<Either<Failure, List<RiderModel>>> getRiderData() async {
    try {
      final result = await service.getRiderData();
      return Right(result);
    } catch (e) {
      return Left(Failure('$e'));
    }
  }

  Future<Either<Failure, dynamic>> setRider({
    required String orderId,
    required int riderId,
  }) async {
    try {
      final result = await service.setRider(orderId: orderId, riderId: riderId);
      return Right(result);
    } catch (e) {
      return Left(Failure('$e'));
    }
  }
}
