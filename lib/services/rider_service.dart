import 'package:logger/logger.dart';
import 'package:store_app/constants/api_paths.dart';
import 'package:store_app/models/rider_model.dart';
import 'package:store_app/services/app_exceptions.dart';
import 'package:store_app/services/base_service.dart';
import 'package:store_app/services/network_call.dart';

class RiderService extends BaseService {
  final NetworkCall _networkCall = NetworkCall();
  final Logger consolog = Logger();

  Future<List<RiderModel>> getRiderData() async {
    try {
      var response = await _networkCall.request(
        paths: ApiPaths.riderPath,
        method: ApiPaths.getRequest,
      );

      if (response.statusCode == 200) {
        final str = await response.stream.bytesToString();
        consolog.d('data =  ${str}');
        return riderModelFromJson(str);
      }
      throw AppException('${response.reasonPhrase}', '');
    } catch (e) {
      throw AppException('$e', '');
    }
  }

  Future<dynamic> setRider({
    required String orderId,
    required int riderId,
  }) async {
    try {
      // consolog.d('orderId =  ${orderId}');
      var response = await _networkCall.request(
        paths: '${ApiPaths.orderPath}/${orderId}/set-rider/${riderId}',
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
