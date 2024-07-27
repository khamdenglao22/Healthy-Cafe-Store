import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:store_app/app_router.dart';
import 'package:store_app/components/my_height.dart';
import 'package:store_app/main.dart';
import 'package:store_app/my_style/my_style.dart';
import 'package:store_app/pages/order_detail/cubit/order_detail_cubit.dart';
import 'package:intl/intl.dart';
import 'package:store_app/pages/widgets/button_widget.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  void initState() {
    super.initState();
    // Initialize the timezone package
    tz.initializeTimeZones();
    // tz.setLocalLocation(tz.getLocation('Asia/Bangkok')); // +07:00 time zone
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderDetailCubit, OrderDetailState>(
        listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      var cubit = context.read<OrderDetailCubit>();
      return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) {
            return;
          }
          Navigator.pop(context, state.confirmStatus);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('ລາຍລະອຽດອໍເດີ້'),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.pop(context, state.confirmStatus);
              },
            ),
          ),
          body: Builder(
            builder: (context) {
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
                          cubit.getOrderDetailById();
                        },
                        child: Text('Try again'))
                  ],
                ));
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ເລກທີສັ່ງຊື້:',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      state.orderDetail!.orderId,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ວັນທີສັ່ງຊື້:',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      DateFormat('dd-MM-yyyy HH:mm:ss').format(
                                        tz.TZDateTime.from(
                                          state.orderDetail!.orderDate,
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
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ລູກຄ້າ:',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      state.orderDetail!.customerName,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ສະຖານະຊຳລະເງິນ:',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      '${state.orderDetail!.paymentStatusName}, ${state.orderDetail!.paymentMethodName}',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                        borderRadius: BorderRadius.circular(5),
                                        color: state.orderDetail!.orderStatusId ==
                                                2
                                            ? Color.fromARGB(255, 117, 185, 240)
                                            : state.orderDetail!.orderStatusId ==
                                                    1
                                                ? Color.fromARGB(
                                                    255, 106, 245, 229)
                                                : state.orderDetail!.orderStatusId ==
                                                        4
                                                    ? Color.fromARGB(
                                                        255, 146, 143, 241)
                                                    : state.orderDetail!.orderStatusId ==
                                                            3
                                                        ? Color.fromARGB(
                                                            255, 46, 247, 76)
                                                        : state.orderDetail!
                                                                    .orderStatusId ==
                                                                5
                                                            ? darkColor
                                                            : state.orderDetail!
                                                                        .orderStatusId ==
                                                                    6
                                                                ? Color.fromARGB(
                                                                    255, 240, 98, 124)
                                                                : state.orderDetail!.orderStatusId ==
                                                                        7
                                                                    ? Colors.red
                                                                    : Color.fromARGB(
                                                                        255,
                                                                        117,
                                                                        185,
                                                                        240),
                                      ),
                                      child: Text(
                                        state.orderDetail!.orderStatusName,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ທີ່ຢູ່ຈັດສົ່ງ:',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      state.orderDetail!.deliveryDetail,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Builder(builder: (context) {
                            if (state.orderDetail!.orderStatusId == 7 &&
                                state.orderDetail!.reasonForCancel != null) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'ເຫດຜົນ:',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          state.orderDetail!.reasonForCancel
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                            return Container();
                          }),
                          Builder(builder: (context) {
                            if (state.orderDetail!.orderStatusId == 6 &&
                                state.orderDetail!.reasonForDeliveryFail !=
                                    null) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'ເຫດຜົນ:',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          state.orderDetail!
                                              .reasonForDeliveryFail
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                            return Container();
                          }),
                          MyHeight(
                            height: 15.0,
                          ),
                          Text(
                            'ລາຍການສັ່ງຊື້:',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          MyHeight(
                            height: 10.0,
                          ),
                          ...state.orderDetail!.orderItems.map(
                            (val) => Card(
                              margin: EdgeInsets.symmetric(
                                vertical: 2.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      val.productName,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    val.options!.isNotEmpty
                                        ? Row(
                                            children: [
                                              Text(
                                                'ຕົວເລືອກ: ',
                                                style: TextStyle(
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                              ...val.options!.map(
                                                (e) => Row(
                                                  children: [
                                                    Text(
                                                      '${e.optionName}',
                                                      style: TextStyle(
                                                        fontSize: 12.0,
                                                      ),
                                                    ),
                                                    val.options!.length > 1
                                                        ? Text(
                                                            ', ',
                                                            style: TextStyle(
                                                              fontSize: 13.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                            ),
                                                          )
                                                        : SizedBox.shrink(),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        : SizedBox.shrink(),
                                    val.remark != null && val.remark != ''
                                        ? Text(
                                            'ໝາຍເຫດ: ${val.remark!}',
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Row(
                                            children: [
                                              Text(
                                                '${val.qty.toString()} ',
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                val.unitName,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              '${NumberFormat().format(val.price)} ກີບ',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.all(8.0),
                            color: Color.fromARGB(77, 212, 211, 211),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ລວມ',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text('ສ່ວນຫຼຸດ'),
                                    Text('ຄ່າຈັດສົ່ງ'),
                                    Text(
                                      'ລວມມູນຄ່າ',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${NumberFormat().format(state.orderDetail?.subtotal)} ກີບ',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                        '${NumberFormat().format(state.orderDetail?.discountAmount)} ກີບ'),
                                    Text(
                                        '${NumberFormat().format(state.orderDetail?.deliveryCost)} ກີບ'),
                                    Text(
                                      '${NumberFormat().format(state.orderDetail?.actualSale)} ກີບ',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )),
                        state.orderDetail!.orderStatusId == 1 &&
                                state.orderDetail!.riderId == 0
                            ? Container(
                                padding: EdgeInsets.all(8.0),
                                color: Color.fromARGB(77, 161, 160, 160),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: CustomButtonWidget(
                                        onPressed: () {
                                          navService.pushNamed(
                                            AppRouter.riderPage,
                                            args: [cubit.id],
                                          ).then((value) {
                                            if (value == true) {
                                              cubit.getOrderDetailById();
                                              cubit.setConfirmStatus();
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
                                  ],
                                ),
                              )
                            : state.orderDetail!.orderStatusId == 2
                                ? Container(
                                    padding: EdgeInsets.all(8.0),
                                    color: Color.fromARGB(77, 161, 160, 160),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: CustomButtonWidget(
                                            onPressed: () {
                                              navService.pushNamed(
                                                AppRouter.cancelOrderPage,
                                                args: [
                                                  state.orderDetail!.orderId
                                                ],
                                              ).then((value) {
                                                if (value == true) {
                                                  cubit.getOrderDetailById();
                                                  cubit.setConfirmStatus();
                                                }
                                              });
                                            },
                                            bgColor: Colors.red,
                                            textColor: Colors.white,
                                            textTitle: "ຍົກເລິກ",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            pHorizontal: 10.0,
                                            pVertical: 10.0,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12.0,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: CustomButtonWidget(
                                            onPressed: () {
                                              cubit.confirmOrder();
                                            },
                                            bgColor: darkColor,
                                            textColor: Colors.white,
                                            textTitle: "ຢືນຢັນການສັ່ງຊື້",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            pHorizontal: 10.0,
                                            pVertical: 10.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink(),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      );
    });
  }
}
