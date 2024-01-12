import 'package:flutter_test/flutter_test.dart';
import 'package:lbwpush/lbwpush.dart';
import 'package:lbwpush/lbwpush_platform_interface.dart';
import 'package:lbwpush/lbwpush_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockLbwpushPlatform
    with MockPlatformInterfaceMixin
    implements LbwpushPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
  
  @override
  Future<String?> getPushUid() {
    // TODO: implement getPushUid
    throw UnimplementedError();
  }
  
  @override
  Future<void> initsdk(Map<String, String> param) {
    // TODO: implement initsdk
    throw UnimplementedError();
  }
  
  @override
  Future<void> startPushService() {
    // TODO: implement startPushService
    throw UnimplementedError();
  }
  
  @override
  Future<void> deleteAlias() {
    // TODO: implement deleteAlias
    throw UnimplementedError();
  }
  
  @override
  Future<String?> getAlias() {
    // TODO: implement getAlias
    throw UnimplementedError();
  }
  
  @override
  Future<void> setAlias(String alias) {
    // TODO: implement setAlias
    throw UnimplementedError();
  }
  
  @override
  Future<void> addTags(List<String> list) {
    // TODO: implement addTags
    throw UnimplementedError();
  }
  
  @override
  Future<void> cleanTags() {
    // TODO: implement cleanTags
    throw UnimplementedError();
  }
  
  @override
  Future<void> deleteTags(List<String> list) {
    // TODO: implement deleteTags
    throw UnimplementedError();
  }
  
  @override
  Future<List<String?>?> getAllTags() {
    // TODO: implement getAllTags
    throw UnimplementedError();
  }
  
  @override
  Future<bool?> isTagBinding(String a) {
    // TODO: implement isTagBinding
    throw UnimplementedError();
  }
  
  @override
  Future<void> updateTags(List<String> list) {
    // TODO: implement updateTags
    throw UnimplementedError();
  }
  
  @override
  Future<bool?> areNotificationsEnabled() {
    // TODO: implement areNotificationsEnabled
    throw UnimplementedError();
  }
  
  @override
  Future<bool?> showNotificationGuide() {
    // TODO: implement showNotificationGuide
    throw UnimplementedError();
  }
}

void main() {
  final LbwpushPlatform initialPlatform = LbwpushPlatform.instance;

  test('$MethodChannelLbwpush is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelLbwpush>());
  });

  test('getPlatformVersion', () async {
    Lbwpush lbwpushPlugin = Lbwpush();
    MockLbwpushPlatform fakePlatform = MockLbwpushPlatform();
    LbwpushPlatform.instance = fakePlatform;

    expect(await lbwpushPlugin.getPlatformVersion(), '42');
  });
}
