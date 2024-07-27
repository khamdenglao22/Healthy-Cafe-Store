import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:store_app/components/message_helper.dart';
import 'package:store_app/main.dart';
import 'package:store_app/models/order_detail.dart';
import 'package:store_app/models/order_model.dart';
import 'package:store_app/repositorys/order_repository.dart';

part 'order_all_list_state.dart';

class OrderAllListCubit extends Cubit<OrderAllListState> {
  OrderAllListCubit({
    required this.orderRepository,
    required this.statusList,
  }) : super(const OrderAllListState());

  final OrderRepository orderRepository;
  final int statusList;

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
        emit(
          state.copyWith(
            fetchStatus: AppStatus.loading,
            page: 0,
          ),
        );
      }
      var result = await orderRepository.getOrderData(
        statusList: statusList,
        limit: state.limit,
        pageNumber: state.page,
      );
      result.fold((l) {
        if (mounted) {
          emit(
            state.copyWith(
              fetchStatus: AppStatus.failure,
              error: l.message,
            ),
          );
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
          statusList: statusList, limit: state.limit, pageNumber: state.page);
      result.fold((l) {
        if (mounted) {
          emit(
              state.copyWith(loadMoreStatus: AppStatus.failure, error: l.message));
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
}
