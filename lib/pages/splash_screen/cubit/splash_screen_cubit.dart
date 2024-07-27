import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:store_app/app_router.dart';
import 'package:store_app/repositorys/login_repository.dart';
import 'dart:developer';

part 'splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit({required this.loginRepository})
      : super(const SplashScreenState());

  final LoginRepository loginRepository;
  bool mounted = true;

  @override
  Future<void> close() {
    mounted = false;
    return super.close();
  }

  Future validateToken() async {
    final result = await loginRepository.validateToken();
    //await Future.delayed(const Duration(seconds: 3));
    result.fold(
      (erorr) {
        log('error = $erorr');
        navService.pushNamedAndRemoveUntil(AppRouter.loginPage);
      },
      (token) {
        log('success = $token');
        navService.pushNamedAndRemoveUntil(AppRouter.dashboardPage);
      },
    );
  }
}
