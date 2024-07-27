import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/main.dart';
import 'package:store_app/my_style/my_style.dart';
import 'package:store_app/pages/rider/cubit/rider_cubit.dart';
import 'package:store_app/pages/widgets/button_widget.dart';

class RiderPage extends StatelessWidget {
  const RiderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RiderCubit, RiderState>(listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      var cubit = context.read<RiderCubit>();
      return Scaffold(
        appBar: AppBar(
          title: Text('ລາຍຊື່ຜູ້ສົ່ງອາຫານ'),
          // leading: IconButton(
          //   icon: Icon(
          //     Icons.arrow_back,
          //   ),
          //   onPressed: () {
          //     Navigator.pop(context, state.setRiderStatus);
          //   },
          // ),
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
                          cubit.getRiderData();
                        },
                        child: Text('Try again'))
                  ],
                ),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      right: 8.0,
                      left: 8.0,
                    ),
                    child: ListView.builder(
                        itemCount: state.riderList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: RadioMenuButton(
                              value: state.riderList[index].id,
                              groupValue: state.selectedRider,
                              onChanged: (value) {
                                cubit.selectedRider(value!);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.riderList[index].name),
                                  Text(
                                      'ເບີໂທ: ${state.riderList[index].phoneNo}'),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  color: Color.fromARGB(77, 161, 160, 160),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButtonWidget(
                          onPressed: () {
                            cubit.setRider();
                          },
                          bgColor: darkColor,
                          textColor: Colors.white,
                          textTitle: "ບັກທືກ",
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          pHorizontal: 10.0,
                          pVertical: 10.0,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      );
    });
  }
}
