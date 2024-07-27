import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/my_style/my_style.dart';
import 'package:store_app/pages/order/cubit/order_cubit.dart';
import 'package:store_app/pages/order/order_page.dart';
import 'package:store_app/pages/order_all/cubit/order_all_cubit.dart';
import 'package:store_app/pages/order_all/order_all_page.dart';
import 'package:store_app/repositorys/login_repository.dart';
import 'package:store_app/repositorys/order_repository.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        BlocProvider(
          create: (context) => OrderCubit(
            orderRepository: context.read<OrderRepository>(),
            loginRepository: context.read<LoginRepository>(),
          )
            ..getOrderData()
            ..initialScroCtrl(context),
          child: const OrderPage(),
        ),
        BlocProvider(
          create: (context) => OrderAllCubit(
            loginRepository: context.read<LoginRepository>(),
            // statusList: settings.arguments as int,
          ),
          child: const OrderAllPage(),
        ),
      ][currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: 'ລາຍການອໍເດິ້ໃໝ່',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.toc),
            label: 'ລາຍການ',
          ),
        ],
        selectedItemColor: Colors.white,
        backgroundColor: darkColor,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
    );
  }
}
