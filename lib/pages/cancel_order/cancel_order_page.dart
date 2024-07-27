import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/my_style/my_style.dart';
import 'package:store_app/pages/cancel_order/cubit/cancel_order_cubit.dart';
import 'package:store_app/pages/widgets/button_widget.dart';

class CancelOrderPage extends StatelessWidget {
  const CancelOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CancelOrderCubit, CancelOrderState>(
        listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      var cubit = context.read<CancelOrderCubit>();
      return Scaffold(
          appBar: AppBar(
            title: const Text('ສາເຫດ'),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.pop(context, state.cancelStatus);
              },
            ),
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.only(top: 20.0, right: 8.0, left: 8.0),
                    // color: Colors.red,
                    child: Form(
                      key: cubit.formKey,
                      child: TextField(
                        maxLines: 3,
                        controller: cubit.reasonForCancel,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            color: darkColor,
                          ),
                          labelText: "ສາເຫດ:",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: darkColor,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: darkColor,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(10.0),
                          isDense: true,
                        ),
                      ),
                    )),
                Container(
                  padding: EdgeInsets.all(8.0),
                  color: Color.fromARGB(77, 161, 160, 160),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CustomButtonWidget(
                          onPressed: () {
                            cubit.cancelOrder();
                          },
                          bgColor: darkColor,
                          textColor: Colors.white,
                          textTitle: "ຍົກເລີກ",
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
            ),
          ));
    });
  }
}
