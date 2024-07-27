import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:store_app/app_router.dart';
import 'package:store_app/components/message_helper.dart';
import 'package:store_app/my_style/my_style.dart';
import 'package:store_app/repositorys/login_repository.dart';
import 'package:store_app/repositorys/order_repository.dart';
import 'package:store_app/repositorys/rider_repository.dart';

enum AppStatus { initial, loading, success, failure }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => LoginRepository()),
        RepositoryProvider(create: (_) => OrderRepository()),
        RepositoryProvider(create: (_) => RiderRepository()),
        // RepositoryProvider(create: (_) => PostRepository()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
    if (_connectionStatus == ConnectivityResult.none) {
      MessageHelper.showSnackBarMessage(
          isSuccess: false, message: 'No Internet');
    }
    // else{
    //   MessageHelper.showSnackBarMessage(
    //       isSuccess: true, message: 'Online');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App-Healthy-Cafe-Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NotoSansLaoUI',
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
          color: darkColor,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      //home: const HomePage(),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.splashScreenPage,
      navigatorKey: NavigationService.navigationKey,
      scaffoldMessengerKey: MessageHelper.scaffoldMessengerKey,
    );
  }
}
