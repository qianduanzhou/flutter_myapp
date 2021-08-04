import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_myapp/routes/loginRoute.dart';
import 'package:flutter_myapp/routes/MenuRoute.dart';
import 'package:flutter_myapp/routes/listRoute.dart';
import 'routes/loginRoute.dart';
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
        ChangeNotifierProvider(create: (context) => UserModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => LoginRoute(),
            '/menu': (context) => MenuRoute(),
            '/list': (context) => ListRoute()
          }
      ),
    );
  }
}