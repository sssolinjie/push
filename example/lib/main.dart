import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:bdpush/bdpush.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
 
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _bdpushPlugin = Bdpush();

  String appkey = '700042332';
  String SecKey = '831719873468e15ce3093d0832f89595';
  String MasterSecret = '16941e8b0ab94e65b5b9014ba157600f';
  @override
  void initState() {
    super.initState();
  }

  initsdk() async {
    var a = {
      'appkey' : appkey,
      'SecKey' : SecKey,
    };
    var bbb = await _bdpushPlugin.initSdk(a);
    print(bbb);
  }

  getPushUid(){

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('bdpush'),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(onPressed: (){
                initsdk();
              }, child: Text('初始化'))
            ],
          ),
        ),
      ),
    );
  }
}
