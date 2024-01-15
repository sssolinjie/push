import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'lbwpush_platform_interface.dart';



/// An implementation of [LbwpushPlatform] that uses method channels.
class MethodChannelLbwpush extends LbwpushPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('lbwpush');
  
  late Function callback;
  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> getPushUid() async {
    final version = await methodChannel.invokeMethod<String>('getPushUid');
    return version;
  }

  @override
  Future<void> initsdk(Map<String, String> param) async {
    await methodChannel.invokeMethod<String>('initsdk', param);
  }

  @override
  Future<void> startPushService() async {
    await methodChannel.invokeMethod<String>('startPushService');
  }

  @override
  Future<bool?> setAlias (String alias) async{
    final version = await methodChannel.invokeMethod<bool>('setAlias',alias);
    return version;
  }

  @override
  Future<String?> getAlias() async {
    final version = await methodChannel.invokeMethod<String>('getAlias');
    return version;
  }

  @override
  Future<bool?> deleteAlias () async{
    final version = await methodChannel.invokeMethod<bool>('deleteAlias');
    return version;
  }


  @override
  Future<bool?> addTags(List<String> list) async{
    final version =  await methodChannel.invokeMethod<bool>('addTags',list);
    return version;
  }
  @override
  Future<bool?> deleteTags(List<String> list) async{
    final version =  await methodChannel.invokeMethod<bool>('deleteTags',list);
    return version;
  }
  @override
  Future<bool?> updateTags(List<String> list) async{
    final version =  await methodChannel.invokeMethod<bool>('updateTags',list);
    return version;
  }
  @override 
  Future<bool?> cleanTags() async{
   final version =  await methodChannel.invokeMethod<bool>('cleanTags');
    return version;
  }
  @override
  Future<String?> getAllTags() async{
    final value = await methodChannel.invokeMethod<String>('getAllTags');
    return value;
  }
  @override
  Future<bool?> isTagBinding(String tag) async{
    final value = await methodChannel.invokeMethod<bool>('isTagBinding', tag);
    return value;
  }

  @override
  Future<bool?> areNotificationsEnabled() async{
    final value = await methodChannel.invokeMethod<bool>('areNotificationsEnabled');
    return value;
  }
  @override
  Future<bool?> showNotificationGuide() async{
    final version = await methodChannel.invokeMethod<bool>('showNotificationGuide');
    return version;
  }

  @override
  void addEventHandler(Function call){
   callback = call;
    methodChannel.setMethodCallHandler((data) async{
      callback(data.method, data.arguments);
    });
  }

  @override
  Future<void> setbadge() async{
   await methodChannel.invokeMethod('setbadge');
  }
}
