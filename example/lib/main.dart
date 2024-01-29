import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:lbwpush/lbwpush.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String appkey = '700042334';
  String SecKey = '2d92ecab0aa85800311a6c2d9ed26415';
  String MasterSecret = '7d9eede93a62a2d2e8b3ea2b5b512ed4';
  final _lbwpushPlugin = Lbwpush();

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      appkey = "41268";
      SecKey = '9f51d3d496767ec16f47cf1e347c44eb';
    }
  }

  initsdk() {
    var a = {
      'appkey': appkey,
      'SecKey': SecKey,
    };
    _lbwpushPlugin.addEventHandler((eventname, data){
      print(eventname);
      print(data);//{"111":"222"} {}
      /**
       * {_msg_id: 30011, aps: {sound: default, alert: {subtitle: 11, title: 1111, body: 111}, badge: 10, interruption-level: time-sensitive}, 111: 222, _traceId: 6012, _badge_conf: +1, _env: 0, _msg_type: 0}
       */
    });
    _lbwpushPlugin.initsdk(a);
    
       
  }

  startPushService() {
    _lbwpushPlugin.startPushService();
  }

  getPushUid() async {
    var a = await _lbwpushPlugin.getPushUid();
    print(a);
  }

  setAlias() async {
    final data = await _lbwpushPlugin.setAlias('lbwhei');
    print(data);
  }

  getAlias() async {
    var a = await _lbwpushPlugin.getAlias();
    print(a);
  }

  deleteAlias() async {
    final data = await _lbwpushPlugin.deleteAlias();
    print(data);
  }

  addTags() async {
    final data = await _lbwpushPlugin.addTags(['林杰1', "林杰1", "林杰3", "林杰4"]);
    print(data);
  }

  deleteTags() async {
    final data = await _lbwpushPlugin.deleteTags(['林杰1']);
    print(data);
  }

  updateTags() async {
    final data = await _lbwpushPlugin.updateTags(['林杰0', "林杰1", "林杰3", "林杰4"]);
    print(data);
  }

  cleanTags() async {
    final data = await _lbwpushPlugin.cleanTags();
    print(data);
  }

  isTagBinding() async {
    final data = await _lbwpushPlugin.isTagBinding("林杰4");
    print(data);
  }

  getAllTags() async {
    final data = await _lbwpushPlugin.getAllTags();
    List<String> a = data?.split(',') ?? [];
    for (var i in a) {
      print(i);
    }
  }

  areNotificationsEnabled() async {
    _lbwpushPlugin.setbadge();
    // final data = await _lbwpushPlugin.areNotificationsEnabled();
    // print(data);
  }

  showNotificationGuide() async {
    final data = await _lbwpushPlugin.showNotificationGuide();
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(onPressed: initsdk, child: Text('初始化sdk')),
              ElevatedButton(onPressed: startPushService, child: Text('开始推送')),
              ElevatedButton(onPressed: getPushUid, child: Text('pushid')),
              ElevatedButton(onPressed: setAlias, child: Text('设置别名')),
              ElevatedButton(onPressed: getAlias, child: Text('获取别名')),
              ElevatedButton(onPressed: deleteAlias, child: Text('删除别名')),
              ElevatedButton(onPressed: addTags, child: Text('添加标签')),
              ElevatedButton(onPressed: deleteTags, child: Text('删除标签')),
              ElevatedButton(onPressed: updateTags, child: Text('更新标签')),
              ElevatedButton(onPressed: cleanTags, child: Text('清空标签')),
              ElevatedButton(onPressed: isTagBinding, child: Text('是否有这标签')),
              ElevatedButton(onPressed: getAllTags, child: Text('获取所有标签')),
              ElevatedButton(
                  onPressed: areNotificationsEnabled, child: Text('是否有通知权限')),
              ElevatedButton(
                  onPressed: showNotificationGuide, child: Text('权限引导')),
            ],
          ),
        ),
      ),
    );
  }
}
