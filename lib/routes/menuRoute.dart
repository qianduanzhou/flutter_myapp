import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import '../utils/scale.dart';
class AnimatedLogo extends AnimatedWidget {//动画方式2：AnimatedWidget方式渲染动画 可以不使用addListener()和setState() 来更新UI
  final String title;
  final IconData icon;
  final Color bgColor;

  AnimatedLogo({Key? key, required this.title, required this.icon, required this.bgColor, required Animation<double> animation}): 
  super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Column(
      children: [
        Container(
          width: animation.value,
          height: animation.value,
          margin: EdgeInsets.only(bottom: Scale.setPx(5)),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.all(Radius.circular(Scale.setPx(30)))
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: Scale.setPx(40),
          ),
        ),
        Text(
          title,
          style: TextStyle(color: Color(0xff666666), fontSize: Scale.setPx(16)),
        )
      ],
    );
  }
}

class GrowTransition extends StatelessWidget {//动画方式3： 把渲染过程也抽象出来
  final Widget child;
  final Animation<double> animation;

  GrowTransition({Key? key, required this.child, required this.animation}): 
  super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation, 
      builder: (BuildContext context, Widget? child) {
        return Container(
          width: animation.value,
          height: animation.value,
          margin: EdgeInsets.only(bottom: Scale.setPx(5)),
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 185, 101, 1),
            borderRadius: BorderRadius.all(Radius.circular(Scale.setPx(30)))
          ),
          child: child
        );
      },
      child: child,
    );
  }
}

class MenuRoute extends StatefulWidget {
  @override
  _MenuRoute createState() => _MenuRoute();
}

class _MenuRoute extends State<MenuRoute> with SingleTickerProviderStateMixin {
  late Animation<double> animation0;
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));

    animation0 = Tween<double>(begin: 80, end: 90).animate(controller)
    ..addListener(() {
      setState(() {
        //动画方式1：必须监听addListener并使用setState来更新ui
      });
    });

    animation = Tween<double>(begin: 80, end: 90).animate(controller)
    ..addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        controller.reverse();
      } else if(status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    controller.forward();//开始动画
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Scale.initialize(context);
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
                height: Scale.setPx(300),
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
                      left: Scale.setPx(20),
                      top: Scale.setPx(50),
                      child: Container(
                        width: Scale.setPx(100),
                        height: Scale.setPx(30),
                        decoration: BoxDecoration(
                          color: Color(0xffecf5ff),
                          borderRadius: BorderRadius.all(Radius.circular(3))
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.west,
                                size: Scale.setPx(20),
                              ),
                              Text(
                                '退出登录'
                              )
                            ],
                          ),
                        )
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: Scale.setPx(50)),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/img/login/top.png",
                            width: Scale.setPx(120)
                          ),
                          Text(
                            '增排通',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold,
                              fontSize: Scale.setPx(30)
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
              bottom: 0,
              child: Container(
                width: Scale.setPx(375),
                height: Scale.screenHeight * 0.7,
                padding: EdgeInsets.symmetric(vertical: Scale.setPx(30)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(Scale.setPx(20)), topRight: Radius.circular(Scale.setPx(20)))
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        AnimatedLogo(title: '管网实况图', icon: Icons.insights, bgColor: Color.fromRGBO(111, 201, 241, 1), animation: animation),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/list');
                          },
                          child: Column(
                            children: [
                              GrowTransition(
                                animation: animation,
                                child: Icon(
                                  Icons.visibility,
                                  color: Colors.white,
                                  size: Scale.setPx(40),
                                )
                              ),
                              Text(
                                '监测检测',
                                style: TextStyle(color: Color(0xff666666), fontSize: Scale.setPx(16)),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              width: animation.value,
                              height: animation.value,
                              margin: EdgeInsets.only(bottom: Scale.setPx(5)),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(90, 216, 152, 1),
                                borderRadius: BorderRadius.all(Radius.circular(Scale.setPx(30)))
                              ),
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                                size: Scale.setPx(40),
                              ),
                            ),
                            Text(
                              '工单巡检',
                              style: TextStyle(color: Color(0xff666666), fontSize: Scale.setPx(16)),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
            )
          ]
        )
      )
    );
  }
}