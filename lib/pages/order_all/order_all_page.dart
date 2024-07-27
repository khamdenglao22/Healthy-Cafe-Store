import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:store_app/app_router.dart';
import 'package:store_app/components/my_height.dart';
import 'package:store_app/my_style/my_style.dart';
import 'package:store_app/pages/order_all/cubit/order_all_cubit.dart';


class OrderAllPage extends StatefulWidget {
  const OrderAllPage({super.key});

  @override
  State<OrderAllPage> createState() => _OrderAllPageState();
}

class _OrderAllPageState extends State<OrderAllPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderAllCubit, OrderAllState>(
        listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      var cubit = context.read<OrderAllCubit>();

      return Scaffold(
        appBar: AppBar(
          title: Text('ລາຍການ'),
          actions: [
            IconButton(
              onPressed: () {
                cubit.logOut();
              },
              icon: Icon(Icons.exit_to_app),
            ),
          ],
        ),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(8.0),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: [
            GestureDetector(
              onTap: () {
                navService.pushNamed(
                  AppRouter.orderAllListPage,
                  args: [2],
                );
              },
              child: Card(
                color: Color.fromARGB(255, 117, 185, 240),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 65.0,
                    ),
                    MyHeight(
                      height: 8.0,
                    ),
                    Text(
                      'ມີການສັ່ງຊື້',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                navService.pushNamed(
                  AppRouter.orderAllListPage,
                  args: [1],
                );
              },
              child: Card(
                color: Color.fromARGB(255, 106, 245, 229),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.bookmark,
                      size: 65.0,
                    ),
                    MyHeight(
                      height: 8.0,
                    ),
                    Text(
                      'ຢືນຢັນການສັ່ງຊື້',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                navService.pushNamed(
                  AppRouter.orderAllListPage,
                  args: [4],
                );
              },
              child: Card(
                color: Color.fromARGB(255, 146, 143, 241),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.local_shipping,
                      size: 65.0,
                    ),
                    MyHeight(
                      height: 8.0,
                    ),
                    Text(
                      'ກຳລັງຈັດສົ່ງ',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                navService.pushNamed(
                  AppRouter.orderAllListPage,
                  args: [3],
                );
              },
              child: Card(
                color: Color.fromARGB(255, 46, 247, 76),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.done_outline,
                      size: 65.0,
                    ),
                    MyHeight(
                      height: 8.0,
                    ),
                    Text(
                      'ຈັດສົ່ງສຳເລັດ',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                navService.pushNamed(
                  AppRouter.orderAllListPage,
                  args: [6],
                );
              },
              child: Card(
                color: Color.fromRGBO(240, 98, 124, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.free_cancellation,
                      size: 65.0,
                    ),
                    MyHeight(
                      height: 8.0,
                    ),
                    Text(
                      'ຈັດສົ່ງບໍ່ສຳເລັດ',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                navService.pushNamed(
                  AppRouter.orderAllListPage,
                  args: [5],
                );
              },
              child: Card(
                color: darkColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      size: 65.0,
                    ),
                    MyHeight(
                      height: 8.0,
                    ),
                    Text(
                      'ການສັ່ງຊື້ສຳເລັດ',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                navService.pushNamed(
                  AppRouter.orderAllListPage,
                  args: [7],
                );
              },
              child: Card(
                color: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.remove_shopping_cart,
                      size: 65.0,
                    ),
                    MyHeight(
                      height: 8.0,
                    ),
                    Text(
                      'ຍົກເລີກການສັ່ງຊື້',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
