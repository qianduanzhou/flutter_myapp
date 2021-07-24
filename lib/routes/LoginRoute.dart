import 'dart:convert';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../service/loginService.dart';
class LoginRoute extends StatefulWidget {
  @override
  _LoginRoute createState() => new _LoginRoute();
}
const _constCountdown = 180;//倒计时常量
class _LoginRoute extends State<LoginRoute> {
  TextEditingController _unameController = TextEditingController();//用户名
  TextEditingController _passwordController = TextEditingController();//密码
  TextEditingController _checkCodeController = TextEditingController();//验证码
  String _imgUrl = '';//验证码图片
  late String _vcode;//验证码code
  int _countdown = _constCountdown;//倒计时
  late Timer _timer;//计时器

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initImgCode();
  }
  _initImgCode() {//加载验证码图片
    new LoginService().getImage().then((res) {
      _imgUrl = res['img'];
      _vcode = res['code'];
      // _timer.cancel();
      setState(() {
        _countdown = _constCountdown;
      });
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if(_countdown  < 1) {
            _timer.cancel();
            _initImgCode();
          } else {
            _countdown --;
          }
        });
      });
    }).catchError((onError) {
      print('LoginServiceErr:$onError');
    });
  }
  _login() {//登录
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/login/background.png"),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                fontSize: 40
              ),
            ),
            Text(
              'WELCOME',
              style: TextStyle(
                color: Color(0xFFf2a001),
                decoration: TextDecoration.none,
                fontSize: 30
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(56, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              width: 400,
              height: 60,
              margin: EdgeInsets.only(top: 50),
              alignment: Alignment.center,
              child: TextField(
                controller: _unameController,
                autofocus: true,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: '账号',
                  hintStyle: TextStyle(
                    color: Color(0xFFffffff),
                  ),
                  prefixIcon: Icon(
                    Icons.perm_identity,
                    color: Color(0xFFffffff),
                    size: 30,
                  ),
                  contentPadding: EdgeInsets.only(left: 40, top: 10),
                  border: InputBorder.none
                ),
              )
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(56, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              width: 400,
              height: 60,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 20),
              child: TextField(
                controller: _passwordController,
                autofocus: true,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '密码',
                  hintStyle: TextStyle(
                    color: Color(0xFFffffff)
                  ),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Color(0xFFffffff),
                    size: 30,
                  ),
                  contentPadding: EdgeInsets.only(left: 40, top: 10),
                  border: InputBorder.none
                ),
              )
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(56, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              width: 400,
              height: 60,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '验证码',
                    style: TextStyle(
                      color: Color(0xff606266),
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Container(
                    width: 90,
                    height: 35,
                    margin: EdgeInsets.only(left: 10,right: 30),
                    child: TextField(
                      controller: _checkCodeController,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(),
                      )
                    ),
                  ),
                  _imgUrl != '' ? Image.memory(
                    base64.decode(
                      _imgUrl,
                    ),
                    width: 90,
                    height: 40,
                    fit: BoxFit.contain
                  ) : Container(
                    width: 90,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 50),
                    child: Text(
                      _countdown.toString(),
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
                    ),
                  ),
              ])
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              width: 400,
              height: 60,
              alignment: Alignment.center,
              child: CupertinoButton(
                color: Color(0xfff2a001),
                borderRadius: BorderRadius.circular(50),
                disabledColor: Colors.grey,
                child: Container(
                  width: 400,
                  height: 60,
                  alignment: Alignment.center,
                  child: Text(
                    '登录',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                onPressed: _login,
              ),
            )
          ],
        ),
      ),
    );
  }
}