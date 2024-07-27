import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/pages/cancel_order/cancel_order_page.dart';
import 'package:store_app/pages/cancel_order/cubit/cancel_order_cubit.dart';
import 'package:store_app/pages/dashboard/dashboard_page.dart';
import 'package:store_app/pages/login/cubit/login_cubit.dart';
import 'package:store_app/pages/login/login_page.dart';
import 'package:store_app/pages/order/cubit/order_cubit.dart';
import 'package:store_app/pages/order/order_page.dart';
import 'package:store_app/pages/order_all_list/cubit/order_all_list_cubit.dart';
import 'package:store_app/pages/order_all_list/order_all_list_page.dart';
import 'package:store_app/pages/order_detail/cubit/order_detail_cubit.dart';
import 'package:store_app/pages/order_detail/order_detail_page.dart';
import 'package:store_app/pages/rider/cubit/rider_cubit.dart';
import 'package:store_app/pages/rider/rider_page.dart';
import 'package:store_app/pages/splash_screen/cubit/splash_screen_cubit.dart';
import 'package:store_app/pages/splash_screen/splash_screen_page.dart';
import 'package:store_app/repositorys/login_repository.dart';
import 'package:store_app/repositorys/order_repository.dart';
import 'package:store_app/repositorys/rider_repository.dart';

class AppRouter {
  static const String splashScreenPage = '/splashScreenPage';
  static const String loginPage = '/loginPage';
  static const String orderPage = '/orderPage';
  static const String dashboardPage = '/dashboardPage';
  static const String orderDetailPage = '/orderDetailPage';
  static const String riderPage = '/riderPage';
  static const String orderAllListPage = '/orderAllListPage';
  static const String cancelOrderPage = '/cancelOrderPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreenPage:
        // var data = settings.arguments as List;
        return MaterialPageRoute(
          builder: ((context) => BlocProvider(
                create: (context) => SplashScreenCubit(
                  loginRepository: context.read<LoginRepository>(),
                )..validateToken(),
                child: const SplashScreenPage(),
              )),
        );
      case dashboardPage:
        return MaterialPageRoute(
          builder: (context) => const DashboardPage(),
        );
      case loginPage:
        return MaterialPageRoute(
          builder: ((context) => BlocProvider(
                create: (context) => LoginCubit(
                  loginRepository: context.read<LoginRepository>(),
                ),
                child: const LoginPage(),
              )),
        );
      case orderPage:
        return MaterialPageRoute(
          builder: ((context) => BlocProvider(
                create: (context) => OrderCubit(
                  orderRepository: context.read<OrderRepository>(),
                  loginRepository: context.read<LoginRepository>(),
                )..getOrderData(),
                child: const OrderPage(),
              )),
        );

      case orderDetailPage:
        var data = settings.arguments as List;
        return MaterialPageRoute(
          builder: ((context) => BlocProvider(
                create: (context) => OrderDetailCubit(
                  orderRepository: context.read<OrderRepository>(),
                  id: data[0],
                )..getOrderDetailById(),
                child: const OrderDetailPage(),
              )),
        );

      case riderPage:
        var data = settings.arguments as List;
        return MaterialPageRoute(
          builder: ((context) => BlocProvider(
                create: (context) => RiderCubit(
                  context: context,
                  riderRepository: context.read<RiderRepository>(),
                  orderId: data[0],
                )..getRiderData(),
                child: const RiderPage(),
              )),
        );

      case orderAllListPage:
        var data = settings.arguments as List;
        return MaterialPageRoute(
          builder: ((context) => BlocProvider(
                create: (context) => OrderAllListCubit(
                  orderRepository: context.read<OrderRepository>(),
                  statusList: data[0],
                )
                  ..getOrderData()
                  ..initialScroCtrl(context),
                child: const OrderAllListPage(),
              )),
        );

      case cancelOrderPage:
        var data = settings.arguments as List;
        return MaterialPageRoute(
          builder: ((context) => BlocProvider(
                create: (context) => CancelOrderCubit(
                  context: context,
                  orderRepository: context.read<OrderRepository>(),
                  orderId: data[0],
                ),
                child: const CancelOrderPage(),
              )),
        );

      default:
        return MaterialPageRoute(builder: (context) => const DefaulPage());
    }
  }
}

class DefaulPage extends StatelessWidget {
  const DefaulPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('No found page'),
      ),
    );
  }
}
