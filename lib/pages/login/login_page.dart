import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/components/my_height.dart';
import 'package:store_app/my_style/my_style.dart';
import 'package:store_app/pages/login/cubit/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = context.read<LoginCubit>();
          return GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 150.0,
                    width: 150.0,
                  ),
                  Text(
                    'ເຂົ້າສູ່ລະບົບ',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24.0,
                      color: darkColor,
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Form(
                    key: cubit.formKey,
                    child: Column(
                      children: [
                        TextField(
                          controller: cubit.username,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.account_box,
                              color: darkColor,
                            ),
                            labelStyle: TextStyle(
                              color: darkColor,
                            ),
                            labelText: "Username:",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: darkColor,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: darkColor,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(10.0),
                            isDense: true,
                          ),
                        ),
                        MyHeight(
                          height: 20.0,
                        ),
                        TextField(
                          controller: cubit.password,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: state.passwordVisible,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: darkColor,
                            ),
                            labelStyle: TextStyle(
                              color: darkColor,
                            ),
                            labelText: "ລະຫັດຜ່ານ:",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: darkColor,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: darkColor,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(10.0),
                            isDense: true,
                            suffixIcon: IconButton(
                              onPressed: () {
                                cubit.changPasswordVisible();
                              },
                              icon: Icon(
                                state.passwordVisible
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_off_sharp,
                                color: darkColor,
                              ),
                            ),
                          ),
                        ),
                        MyHeight(
                          height: 20.0,
                        ),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: darkColor,
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                            ),
                            onPressed: () {
                              cubit.loginMethod();
                            },
                            child: Text(
                              'ເຂົ້າສູ່ລະບົບ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
