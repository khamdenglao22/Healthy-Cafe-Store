import 'package:dartz/dartz.dart';
import 'package:store_app/models/failure.dart';
import 'package:store_app/services/login_service.dart';

class LoginRepository {
  final LoginService service = LoginService();
  Future<Either<Failure, dynamic>> login(
      {required String username, required String password}) async {
    try {
      final result =
          await service.login(username: username, password: password);
      return Right(result);
    } catch (e) {
      return Left(Failure('$e'));
    }
  }

  Future<Either<Failure, dynamic>> validateToken() async {
    try {
      final result = await service.validateToken();
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, bool>> saveToken({
    required String token,
  }) async {
    try {
      final result = await service.saveToken(token: token);
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, bool>> removeToken() async {
    try {
      final result = await service.removeToken();
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
