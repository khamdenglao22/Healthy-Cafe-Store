import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:store_app/app_router.dart';
import 'package:store_app/components/message_helper.dart';
import 'package:store_app/main.dart';
import 'package:store_app/repositorys/login_repository.dart';

part 'order_all_state.dart';

class OrderAllCubit extends Cubit<OrderAllState> {
  OrderAllCubit({required this.loginRepository}) : super(const OrderAllState());

  final LoginRepository loginRepository;

  bool mounted = true;
  @override
  Future<void> close() {
    mounted = false;
    return super.close();
  }

  Future logOut() async {
    try {
      if (mounted) {
        emit(state.copyWith(fetchStatus: AppStatus.loading));
      }
      var result = await loginRepository.removeToken();
      result.fold((l) {
        if (mounted) {
          emit(
              state.copyWith(fetchStatus: AppStatus.failure, error: l.message));
          MessageHelper.showSnackBarMessage(
            isSuccess: false,
            message: l.message,
          );
        }
      }, (model) {
        log('success');
        if (mounted) {
          if (model) {
            navService.pushNamedAndRemoveUntil(AppRouter.loginPage);
          }
        }
      });
    } catch (e) {
      log('error = $e');

      if (mounted) {
        emit(state.copyWith(
            fetchStatus: AppStatus.failure, error: e.toString()));
      }
    }
  }
}
