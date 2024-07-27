import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:store_app/app_router.dart';
import 'package:store_app/components/message_helper.dart';
import 'package:store_app/main.dart';
import 'package:store_app/models/order_detail.dart';
import 'package:store_app/models/order_model.dart';
import 'package:store_app/repositorys/order_repository.dart';

part 'order_detail_state.dart';

class OrderDetailCubit extends Cubit<OrderDetailState> {
  OrderDetailCubit({
    required this.id,
    required this.orderRepository,
  }) : super(const OrderDetailState());
  final String id;

  final OrderRepository orderRepository;

  bool mounted = true;
  @override
  Future<void> close() {
    mounted = false;
    return super.close();
  }

  Future getOrderDetailById() async {
    try {
      if (mounted) {
        emit(state.copyWith(fetchStatus: AppStatus.loading));
      }
      var result = await orderRepository.getOrderDetailById(id: id);
      result.fold((l) {
        if (mounted) {
          emit(
              state.copyWith(fetchStatus: AppStatus.failure, error: l.message));
        }
      }, (model) {
        log('success order detail');
        if (mounted) {
          emit(state.copyWith(
              fetchStatus: AppStatus.success, orderDetail: model));
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

  Future confirmOrder() async {
    try {
      if (mounted) {
        emit(state.copyWith(fetchStatus: AppStatus.loading));
      }
      var result = await orderRepository.confirmOrder(orderId: id);
      result.fold((l) {
        if (mounted) {
          emit(state.copyWith(
            fetchStatus: AppStatus.success,
            error: l.message,
          ));
          MessageHelper.showSnackBarMessage(
            isSuccess: false,
            message: l.message,
          );
        }
      }, (model) {
        log('confirm success');
        if (mounted) {
          setConfirmStatus();
          getOrderDetailById();
          MessageHelper.showSnackBarMessage(
            isSuccess: true,
            message: 'Confirm Successful',
          );
          navService.pushNamed(
            AppRouter.riderPage,
            args: [id],
          ).then((value) => {
                if (value == true)
                  {
                    getOrderDetailById(),
                    setConfirmStatus(),
                  }
              });
        }
      });
    } catch (e) {
      log('error = $e');
      if (mounted) {
        emit(state.copyWith(
            fetchStatus: AppStatus.failure, error: e.toString()));
        MessageHelper.showSnackBarMessage(
          isSuccess: false,
          message: e,
        );
      }
    }
  }

  Future setConfirmStatus() async {
    emit(state.copyWith(confirmStatus: true));
  }
}
