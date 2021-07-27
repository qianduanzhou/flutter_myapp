import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_myapp/routes/LoginRoute.dart';
import 'service/loginService.dart';
import 'routes/LoginRoute.dart';
import './models/user.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider(create: (context) => UserModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => LoginRoute()
          }
      ),
    );
  }
}