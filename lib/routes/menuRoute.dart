import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuRoute extends StatefulWidget {
  @override
  _MenuRoute createState() => _MenuRoute();
}

class _MenuRoute extends State<MenuRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xfff1f2f3),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              color: Color(0xfff1f2f3),
              child: Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/img/menu/bg.png"),
                    fit: BoxFit.fill
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 20,
                      top: 30,
                      child: Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Color(0xffecf5ff),
                          borderRadius: BorderRadius.all(Radius.circular(3))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.west,
                              size: 20,
                            ),
                            Text(
                              '退出登录'
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/img/login/top.png",
                            width: 120
                          ),
                          Text(
                            '增排通',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold,
                              fontSize: 30
                            ),
                          ),
                        ]
                      ),
                    )
                  ],
                )
              ),
            ),
            Positioned(
              bottom: 20,
              child: Container(
                width: 500,
                height: 730,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
              )
            )
          ]
        )
      )
    );
  }
}