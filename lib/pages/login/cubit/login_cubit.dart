import 'dart:developer';
import 'dart:convert' as convert;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:store_app/app_router.dart';
import 'package:store_app/components/message_helper.dart';
import 'package:store_app/repositorys/login_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  final LoginRepository loginRepository;

  LoginCubit({required this.loginRepository})
      : super(const LoginState(loginStatus: LoginStatus.initial));

  bool mounted = true;

  @override
  Future<void> close() {
    mounted = false;
    return super.close();
  }

  changPasswordVisible() {
    if (mounted) {
      emit(state.copyWith(passwordVisible: !state.passwordVisible));
    }
  }

  Future<void> loginMethod() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      emit(state.copyWith(loginStatus: LoginStatus.loading));
      final result = await loginRepository.login(
        username: username.text.trim(),
        password: password.text,
      );
      result.fold((error) {
        log('error = $error');
        emit(state.copyWith(
            loginStatus: LoginStatus.failure, error: error.toString()));
        MessageHelper.showSnackBarMessage(
          isSuccess: false,
          message: error.toString(),
        );
      }, (user) async {
        log('success = $user');
        var jsonResponse = convert.jsonDecode(user) as Map<String, dynamic>;
        var token = jsonResponse['token'];
        await loginRepository.saveToken(token: token.toString());
        emit(state.copyWith(loginStatus: LoginStatus.success));
        MessageHelper.showSnackBarMessage(
            isSuccess: true, message: 'Login Successful');
        navService.pushNamedAndRemoveUntil(AppRouter.dashboardPage);
      });
    }
  }
}
