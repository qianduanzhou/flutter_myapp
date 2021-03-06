import 'dart:convert';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../service/loginService.dart';
import '../utils/AESUtil.dart';
import '../models/user.dart';
import '../utils/scale.dart';

class LoginRoute extends StatefulWidget {
  @override
  _LoginRoute createState() => new _LoginRoute();
}
const _constCountdown = 180;//倒计时常量
class _LoginRoute extends State<LoginRoute> {
  GlobalKey _formKey = new GlobalKey<FormState>();
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
  @override
  void dispose() {
    super.dispose();
    _unameController.dispose();
    _passwordController.dispose();
    _checkCodeController.dispose();
  }

  _initImgCode() {//加载验证码图片
    new LoginService(context).getImage().then((res) {
      setState(() {
        _imgUrl = res['img'];
        _vcode = res['code'];
        _countdown = _constCountdown;
      });
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if(_countdown < 1) {
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
    if((_formKey.currentState as FormState).validate()){
      //验证通过提交数据
      var username = _unameController.text;
      var password = _passwordController.text;
      var vtext = _checkCodeController.text;
      if(vtext == '') {
        return;
      }
      Map<String, dynamic> param = {
        'username': username,
        'password': AESUtil('').encrypt(password),
        'clientType2': 'app',
        'vtext': vtext,
        'vcode': _vcode,
        'hasParam': 1,
        'clientIP': '',
        'clientOS': 'Android手机',
      };
      new LoginService(context).login(param).then((res) {
        _timer.cancel();
        UserModel user = context.read<UserModel>();
        user.token = res['token'];
        print(user.token);
        Navigator.pushNamed(context, '/menu');
        _getUserInfo(res);
      }).catchError((err) {
        print('loginErr:$err');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(err['msg']))
        );
      });
    }
  }

  _getUserInfo(res) {//获取用户信息
    print('_getUserInfo$res');
    Map<String, String> param = {
      'token': res['token']
    };
    new LoginService(context).getUserInfo(param).then((res) {
      UserModel user = context.read<UserModel>();
      user.userData = res;
    }).catchError((err) {
      print('loginErr:$err');
    });
  }

  _imgTap() {//图片点击事件
    _timer.cancel();
    _initImgCode();
  }

  OutlineInputBorder _getOutlineInputBorder() {//获取输入框边框样式
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(Scale.setPx(50)),
      borderSide: BorderSide.none
    );
  }

  @override
  Widget build(BuildContext context) {
    Scale.initialize(context);
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
              width: Scale.setPx(100)
            ),
            Text(
              '增排通',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                decoration: TextDecoration.none,
                fontSize: Scale.setPx(30)
              ),
            ),
            Text(
              'WELCOME',
              style: TextStyle(
                color: Color(0xFFf2a001),
                decoration: TextDecoration.none,
                fontSize: Scale.setPx(25)
              ),
            ),
            Form(
              key: _formKey,
              // autovalidateMode: AutovalidateMode.always,//自动验证
              child: Column(
                children: [
                  Container(
                    width: Scale.setPx(340),
                    height: Scale.setPx(90),
                    margin: EdgeInsets.only(top: Scale.setPx(50)),
                    alignment: Alignment.center,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: Scale.setPx(90),
                      ),
                      child: TextFormField(
                        controller: _unameController,
                        autofocus: true,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Scale.setPx(18)
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
                            size: Scale.setPx(30),
                          ),
                          fillColor: Color.fromARGB(56, 255, 255, 255),//背景颜色，必须结合filled: true,才有效
		                      filled: true,//重点，必须设置为true，fillColor才有效
                          contentPadding: EdgeInsets.all(Scale.setPx(12)),
                          border: _getOutlineInputBorder(),
                          enabledBorder: _getOutlineInputBorder(),
                          focusedBorder: _getOutlineInputBorder()
                        ),
                        validator: (String? v) {
                          return v?.trim() != '' ? null : "用户名不能为空";
                        }
                      ),
                    )
                  ),
                  Container(
                    width: Scale.setPx(340),
                    height: Scale.setPx(90),
                    alignment: Alignment.center,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: Scale.setPx(90),
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        autofocus: true,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Scale.setPx(18)
                        ),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: '密码',
                          hintStyle: TextStyle(
                            color: Color(0xFFffffff),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xFFffffff),
                            size: Scale.setPx(30),
                          ),
                          fillColor: Color.fromARGB(56, 255, 255, 255),//背景颜色，必须结合filled: true,才有效
		                      filled: true,//重点，必须设置为true，fillColor才有效
                          contentPadding: EdgeInsets.all(Scale.setPx(12)),
                          border: _getOutlineInputBorder(),
                          enabledBorder: _getOutlineInputBorder(),
                          focusedBorder: _getOutlineInputBorder()
                        ),
                        obscureText: true,
                        validator: (String? v) {
                          return v?.trim() != '' ? null : "密码不能为空";
                        }
                      ),
                    )
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(56, 255, 255, 255),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    width: Scale.setPx(340),
                    height: Scale.setPx(50),
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: Scale.setPx(20), right: Scale.setPx(10)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '验证码',
                          style: TextStyle(
                            color: Color(0xff506266),
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Container(
                          width: 90,
                          height: 35,
                          margin: EdgeInsets.only(left: Scale.setPx(10),right: Scale.setPx(30)),
                          child: TextFormField(
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
                            ),
                            validator: (String? v) {
                              if(v?.trim() == '') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('请输入验证码')
                                ));
                              }
                              return null;
                            }
                          ),
                        ),
                        _imgUrl != '' ? GestureDetector(
                          child: Image.memory(
                            base64.decode(
                              _imgUrl,
                            ),
                            width: Scale.setPx(90),
                            height: Scale.setPx(40),
                            fit: BoxFit.contain,
                            gaplessPlayback:true, //防止重绘
                          ),
                          onTap: _imgTap,
                        ) : Container(
                          width: Scale.setPx(90),
                          height: Scale.setPx(40),
                          decoration: BoxDecoration(
                            color: Colors.white
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: Scale.setPx(20)),
                          child: Text(
                            _countdown.toString(),
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: Scale.setPx(18),
                            ),
                          ),
                        ),
                    ])
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Scale.setPx(50)),
                    width: Scale.setPx(340),
                    height: Scale.setPx(50),
                    alignment: Alignment.center,
                    child: CupertinoButton(
                      color: Color(0xfff2a001),
                      borderRadius: BorderRadius.circular(Scale.setPx(50)),
                      disabledColor: Colors.grey,
                      child: Container(
                        width: Scale.setPx(340),
                        height: Scale.setPx(50),
                        alignment: Alignment.center,
                        child: Text(
                          '登录',
                          style: TextStyle(
                            fontSize: Scale.setPx(20),
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      onPressed: _login,
                    ),
                  )
                ],
              )

            ,)
          ],
        ),
      ),
    );
  }
}