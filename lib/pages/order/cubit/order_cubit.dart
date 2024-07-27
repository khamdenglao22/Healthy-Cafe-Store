import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:store_app/app_router.dart';
import 'package:store_app/components/message_helper.dart';
import 'package:store_app/main.dart';
import 'package:store_app/models/order_detail.dart';
import 'package:store_app/models/order_model.dart';
import 'package:store_app/repositorys/login_repository.dart';
import 'package:store_app/repositorys/order_repository.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit({
    required this.orderRepository,
    required this.loginRepository,
  }) : super(const OrderState());

  final OrderRepository orderRepository;
  final LoginRepository loginRepository;
  final scroCtrl = ScrollController();

  bool mounted = true;
  @override
  Future<void> close() {
    mounted = false;
    return super.close();
  }

  void initialScroCtrl(context) {
    scroCtrl.addListener(() {
      if (scroCtrl.position.pixels > 10) {
        if (mounted) {
          emit(state.copyWith(showFloating: true));
        }
      }
      if (scroCtrl.position.pixels < 10) {
        if (mounted) {
          emit(state.copyWith(showFloating: false));
        }
      }
      if (scroCtrl.position.atEdge) {
        if (scroCtrl.position.pixels != 0) {
          log('on load more....');
          loadOrderData();
        }
      }
    });
  }

  Future getOrderData() async {
    try {
      if (mounted) {
        emit(state.copyWith(
          fetchStatus: AppStatus.loading,
          page: 0,
        ));
      }
      var result = await orderRepository.getOrderData(
        statusList: 2,
        limit: state.limit,
        pageNumber: state.page,
      );
      result.fold((l) {
        if (mounted) {
          log('l = $l');
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
          emit(state.copyWith(
            fetchStatus: AppStatus.success,
            // orderModel: model,
            orderDetailModel: model.orders,
            page: state.page + 1,
          ));
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

  Future loadOrderData() async {
    try {
      if (mounted) {
        emit(state.copyWith(
          loadMoreStatus: AppStatus.loading,
        ));
      }
      var result = await orderRepository.getOrderData(
          statusList: 2, limit: state.limit, pageNumber: state.page);
      result.fold((l) {
        if (mounted) {
          emit(state.copyWith(
              loadMoreStatus: AppStatus.failure, error: l.message));
          MessageHelper.showSnackBarMessage(
            isSuccess: false,
            message: l.message,
          );
        }
      }, (model) {
        log('success');
        if (mounted) {
          emit(state.copyWith(
            loadMoreStatus: AppStatus.success,
            orderDetailModel: state.orderDetailModel + model.orders,
            page: state.page + 1,
          ));
        }
      });
    } catch (e) {
      log('error = $e');
      if (mounted) {
        emit(state.copyWith(
            loadMoreStatus: AppStatus.failure, error: e.toString()));
      }
    }
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
            // exit(0);
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
