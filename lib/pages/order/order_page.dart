import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:store_app/app_router.dart';
import 'package:store_app/components/my_height.dart';
import 'package:store_app/main.dart';
import 'package:store_app/my_style/my_style.dart';
import 'package:store_app/pages/order/cubit/order_cubit.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
    // Initialize the timezone package
    tz.initializeTimeZones();
    // tz.setLocalLocation(tz.getLocation('Asia/Bangkok')); // +07:00 time zone
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      var cubit = context.read<OrderCubit>();
      return Scaffold(
        appBar: AppBar(
          title: const Text('ລາຍການອໍເດິ້ໃໝ່'),
          actions: [
            IconButton(
              onPressed: () {
                cubit.logOut();
              },
              icon: Icon(Icons.exit_to_app),
            ),
          ],
        ),
        body: Builder(builder: (context) {
          if (state.fetchStatus == AppStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.fetchStatus == AppStatus.failure) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.info,
                  size: 50,
                  color: Colors.red,
                ),
                Text('Something went wrong!'),
                ElevatedButton(
                    onPressed: () {
                      cubit.getOrderData();
                    },
                    child: Text('Try again'))
              ],
            ));
          }

          if (state.orderDetailModel.isEmpty) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.remove_shopping_cart,
                  size: 50,
                  color: Colors.red,
                ),
                Text(
                  'ບໍ່ມີອໍເດີ້...!',
                  style: TextStyle(fontSize: 22.0),
                ),
              ],
            ));
          }
          return RefreshIndicator(
            onRefresh: () => cubit.getOrderData(),
            child: SingleChildScrollView(
              controller: cubit.scroCtrl,
              child: Column(
                children: [
                  Column(
                    children:
                        List.generate(state.orderDetailModel.length, (index) {
                      var orderList = state.orderDetailModel[index];
                      return GestureDetector(
                        onTap: () {
                          navService.pushNamed(
                            AppRouter.orderDetailPage,
                            args: [orderList.orderId],
                          ).then((value) {
                            if (value == true) {
                              cubit.getOrderData();
                            }
                          });
                        },
                        child: Card(
                          elevation: 6,
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(
                            vertical: 5.0,
                            horizontal: 8.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 18.0,
                                        top: 18.0,
                                        bottom: 18.0,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'ເລກທີສັ່ງຊື້:',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            orderList.orderId,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          MyHeight(
                                            height: 10.0,
                                          ),
                                          Text(
                                            'ລູກຄ້າ:',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            orderList.customerName,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          MyHeight(
                                            height: 10.0,
                                          ),
                                          Text(
                                            'ສະຖານະອໍເດີ້:',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Container(
                                            // color: Colors.blue,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10.0,
                                              vertical: 2.0,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Color.fromARGB(
                                                  255, 117, 185, 240),
                                            ),
                                            child: Text(
                                              orderList.orderStatusName,
                                              style: TextStyle(
                                                fontSize: 14.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 0,
                                        top: 18.0,
                                        right: 18.0,
                                        bottom: 18.0,
                                      ),
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'ຍອດລວມ:',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              // f.format(orderList.subtotal),
                                              '${NumberFormat().format(orderList.actualSale)} ກີບ',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                              ),
                                            ),
                                            MyHeight(
                                              height: 10.0,
                                            ),
                                            Text(
                                              'ວັນທີສັ່ງຊື້:',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              DateFormat('dd-MM-yyyy HH:mm:ss')
                                                  .format(tz.TZDateTime.from(
                                                      orderList.orderDate,
                                                      tz.getLocation(
                                                          'Asia/Bangkok'))),
                                              style: TextStyle(
                                                fontSize: 14.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  Builder(builder: (context) {
                    if (state.loadMoreStatus == AppStatus.loading ||
                        state.loadMoreStatus == AppStatus.initial &&
                            state.orderDetailModel.length > state.limit) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Container();
                  }),
                ],
              ),
            ),
          );
        }),
      );
    });
  }
}
