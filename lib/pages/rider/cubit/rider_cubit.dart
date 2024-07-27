import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:store_app/components/message_helper.dart';
import 'package:store_app/main.dart';
import 'package:store_app/models/rider_model.dart';
import 'package:store_app/repositorys/rider_repository.dart';

part 'rider_state.dart';

class RiderCubit extends Cubit<RiderState> {
  RiderCubit({
    required this.riderRepository,
    required this.orderId,
    required this.context,
  }) : super(const RiderState());

  final RiderRepository riderRepository;
  final String orderId;
  final BuildContext context;

  bool mounted = true;
  @override
  Future<void> close() {
    mounted = false;
    return super.close();
  }

  selectedRider(int value){
    emit(state.copyWith(selectedRider: value));
  }


  Future<dynamic> getRiderData() async {
    try {
      if (mounted) {
        emit(state.copyWith(fetchStatus: AppStatus.loading));
      }
      var result = await riderRepository.getRiderData();
      result.fold((l) {
        if (mounted) {
          emit(
              state.copyWith(fetchStatus: AppStatus.failure, error: l.message));
        }
      }, (model) {
        log('success rider');
        if (mounted) {
          emit(state.copyWith(
              fetchStatus: AppStatus.success, riderList: model));
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


  Future setRider() async {
    try {
      if (mounted) {
        emit(state.copyWith(fetchStatus: AppStatus.loading));
      }
      var result = await riderRepository.setRider(orderId: orderId,riderId: state.selectedRider);
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
        log('set rider success');
        if (mounted) {
          emit(state.copyWith(setRiderStatus: true));
          MessageHelper.showSnackBarMessage(
            isSuccess: true,
            message: 'Set Rider Successful',
          );
          Navigator.pop(context,state.setRiderStatus);
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
