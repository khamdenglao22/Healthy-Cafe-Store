import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:store_app/app_router.dart';
import 'package:store_app/components/my_height.dart';
import 'package:store_app/main.dart';
import 'package:store_app/my_style/my_style.dart';
import 'package:intl/intl.dart';
import 'package:store_app/pages/order_all_list/cubit/order_all_list_cubit.dart';
import 'package:store_app/pages/widgets/button_widget.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class OrderAllListPage extends StatefulWidget {
  const OrderAllListPage({super.key});

  @override
  State<OrderAllListPage> createState() => _OrderAllListPageState();
}

class _OrderAllListPageState extends State<OrderAllListPage> {
  @override
  void initState() {
    super.initState();
    // Initialize the timezone package
    tz.initializeTimeZones();
    // tz.setLocalLocation(tz.getLocation('Asia/Bangkok')); // +07:00 time zone
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderAllListCubit, OrderAllListState>(
        listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      var cubit = context.read<OrderAllListCubit>();
      return Scaffold(
        appBar: AppBar(
          title: state.orderDetailModel.isEmpty
              ? const Text('ບໍ່ມີຂໍ້ມູນ')
              : state.orderDetailModel[0].orderStatusId == 2
                  ? const Text('ມີການສັ່ງຊື້')
                  : state.orderDetailModel[0].orderStatusId == 1
                      ? const Text('ຢືນຢັນການສັ່ງຊື້')
                      : state.orderDetailModel[0].orderStatusId == 5
                          ? const Text('ການສັ່ງຊື້ສຳເລັດ')
                          : state.orderDetailModel[0].orderStatusId == 4
                              ? const Text('ກຳລັງຈັດສົ່ງ')
                              : state.orderDetailModel[0].orderStatusId == 3
                                  ? const Text('ຈັດສົ່ງສຳເລັດ')
                                  : state.orderDetailModel[0].orderStatusId == 6
                                      ? const Text('ຈັດສົ່ງບໍ່ສຳເລັດ')
                                      : state.orderDetailModel[0]
                                                  .orderStatusId ==
                                              7
                                          ? const Text('ຍົກເລີກການສັ່ງຊື້')
                                          : const Text(''),
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
                  'ບໍ່ມີຂໍ້ມູນ...!',
                  style: TextStyle(fontSize: 22.0),
                ),
              ],
            ));
          }
          return SingleChildScrollView(
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
                                            color: orderList.orderStatusId == 2
                                                ? Color.fromARGB(
                                                    255, 117, 185, 240)
                                                : orderList.orderStatusId == 1
                                                    ? Color.fromARGB(
                                                        255, 106, 245, 229)
                                                    : orderList.orderStatusId ==
                                                            5
                                                        ? darkColor
                                                        : orderList.orderStatusId ==
                                                                4
                                                            ? Color.fromARGB(
                                                                255,
                                                                146,
                                                                143,
                                                                241)
                                                            : orderList.orderStatusId ==
                                                                    3
                                                                ? Color
                                                                    .fromARGB(
                                                                        255,
                                                                        46,
                                                                        247,
                                                                        76)
                                                                : orderList.orderStatusId ==
                                                                        6
                                                                    ? Color
                                                                        .fromRGBO(
                                                                            240,
                                                                            98,
                                                                            124,
                                                                            1)
                                                                    : orderList
                                                                                .orderStatusId ==
                                                                            7
                                                                        ? Colors
                                                                            .red
                                                                        : Color.fromARGB(
                                                                            255,
                                                                            117,
                                                                            185,
                                                                            240),
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
                                                .format(
                                              tz.TZDateTime.from(
                                                orderList.orderDate,
                                                tz.getLocation('Asia/Bangkok'),
                                              ),
                                            ),
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
                            state.orderDetailModel[index].orderStatusId == 1 &&
                                    state.orderDetailModel[index].riderId == 0
                                ? Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(
                                      left: 8.0,
                                      bottom: 8.0,
                                      right: 8.0,
                                    ),
                                    child: CustomButtonWidget(
                                      onPressed: () {
                                        // cubit.confirmOrder();
                                        navService.pushNamed(
                                          AppRouter.riderPage,
                                          args: [
                                            state
                                                .orderDetailModel[index].orderId
                                          ],
                                        ).then((value) {
                                          if (value == true) {
                                            cubit.getOrderData();
                                          }
                                        });
                                      },
                                      bgColor: Colors.black,
                                      textColor: Colors.white,
                                      textTitle: "ເລືອກຜູ້ສົ່ງອາຫານ",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      pHorizontal: 10.0,
                                      pVertical: 10.0,
                                    ),
                                  )
                                : const SizedBox.shrink(),
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
          );
        }),
      );
    });
  }
}
