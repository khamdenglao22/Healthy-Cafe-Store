import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:store_app/components/message_helper.dart';
import 'package:store_app/main.dart';
import 'package:store_app/repositorys/order_repository.dart';

part 'cancel_order_state.dart';

class CancelOrderCubit extends Cubit<CancelOrderState> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController reasonForCancel = TextEditingController();

  CancelOrderCubit({
    required this.orderRepository,
    required this.orderId,
    required this.context,
  }) : super(const CancelOrderState());

  final OrderRepository orderRepository;
  final String orderId;
  final BuildContext context;

  bool mounted = true;
  @override
  Future<void> close() {
    mounted = false;
    return super.close();
  }

  Future cancelOrder() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
      if (mounted) {
        emit(state.copyWith(fetchStatus: AppStatus.loading));
      }
      var result = await orderRepository.cancelOrder(
          orderId: orderId, reasonForCancel: reasonForCancel.text);
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
          setCancelStatus();
          MessageHelper.showSnackBarMessage(
            isSuccess: true,
            message: 'Cancel Successful',
          );
          Navigator.pop(context, state.cancelStatus);
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
    
  }

  Future setCancelStatus() async {
    emit(state.copyWith(cancelStatus: true));
  }
}
