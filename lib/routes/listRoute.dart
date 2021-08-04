import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../service/monitorService.dart';
import '../utils/scale.dart';

class TypeMap {
  String type;
  TypeMap(this.type);

  Map<String, String> map = {
    'well': '窨井',
    'rainfall': '雨量计'
  };

  format() {
    if(map.containsKey(type)) {
      return map[type];
    } else {
      return type;
    }
  }
}

class ListRoute extends StatefulWidget {
  @override
  _ListRoute createState() => _ListRoute();
}

class _ListRoute extends State<ListRoute> {
  List _list = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getList();
  }
  _getList() {
    new MonitorService(context).getList({}).then((res) {
      setState(() {
        _list = res;
      });
      print('_list${_list.length}');
    }).catchError((err) {
      print('err$err');
    });
  }
  @override
  Widget build(BuildContext context) {
    Scale.initialize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('监测检测'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(vertical: Scale.setPx(5)),
        color: Color(0xfff5f5f5),
        child: _list.length > 0 ? ListView.builder(
          itemCount: _list.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: Scale.setPx(50),
              margin: EdgeInsets.all(Scale.setPx(5)),
              padding: EdgeInsets.symmetric(horizontal: Scale.setPx(10)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(Scale.setPx(5)))
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: Scale.setPx(30),
                    // width: 50,
                    padding: EdgeInsets.symmetric(horizontal: Scale.setPx(10)),
                    margin: EdgeInsets.only(right: Scale.setPx(5)),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xff00acf8),
                      borderRadius: BorderRadius.all(Radius.circular(Scale.setPx(10)))
                    ),
                    child: Text(
                      TypeMap(_list[index]['type']).format(),
                      style: TextStyle(
                        fontSize: Scale.setPx(14),
                        color: Colors.white
                      ),
                    )
                  ),
                  Expanded(
                    child: Text(
                      _list[index]['name'],
                      style: TextStyle(
                        fontSize: Scale.setPx(16)
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ]
              ),
            );
          }
        ): Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: SizedBox(
              width: Scale.setPx(40),
              height: Scale.setPx(40),
              child: CircularProgressIndicator(strokeWidth: Scale.setPx(2))
          ),
        ),
      )
    );
  }
}