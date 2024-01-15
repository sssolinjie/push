import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'lbwpush_method_channel.dart';

abstract class LbwpushPlatform extends PlatformInterface {
  /// Constructs a LbwpushPlatform.
  LbwpushPlatform() : super(token: _token);

  static final Object _token = Object();

  static LbwpushPlatform _instance = MethodChannelLbwpush();

  /// The default instance of [LbwpushPlatform] to use.
  ///
  /// Defaults to [MethodChannelLbwpush].
  static LbwpushPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LbwpushPlatform] when
  /// they register themselves.
  static set instance(LbwpushPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<String?> getPushUid() {
    throw UnimplementedError('getPushUid() has not been implemented.');
  }
  Future<void> initsdk(Map<String, String> param) {
    throw UnimplementedError('initsdk() has not been implemented.');
  }
  Future<void> startPushService() {
    throw UnimplementedError('startPushService() has not been implemented.');
  }

   Future<bool?> setAlias(String alias) {
    throw UnimplementedError('setAlias() has not been implemented.');
  }
  Future<String?> getAlias() {
    throw UnimplementedError('getAlias() has not been implemented.');
  }
  Future<bool?> deleteAlias() {
    throw UnimplementedError('deleteAlias() has not been implemented.');
  }

  Future<bool?> addTags(List<String> list) {
    throw UnimplementedError('addTags() has not been implemented.');
  }

  Future<bool?> deleteTags(List<String> list) {
   throw UnimplementedError('deleteTags() has not been implemented.');
  }

  Future<bool?> updateTags(List<String> list) {
    throw UnimplementedError('updateTags() has not been implemented.');
  }
  Future<bool?> cleanTags() {
    throw UnimplementedError('cleanTags() has not been implemented.');
  }
  Future<String?> getAllTags() {
    throw UnimplementedError('getAllTags() has not been implemented.');
  }

  Future<bool?> isTagBinding(String tag) {
    throw UnimplementedError('isTagBinding() has not been implemented.');
  }

  Future<bool?> areNotificationsEnabled() {
    throw UnimplementedError('areNotificationsEnabled() has not been implemented.');
  }
  Future<bool?> showNotificationGuide() {
    throw UnimplementedError('showNotificationGuide() has not been implemented.');
  }

  void addEventHandler(Function call){
    throw UnimplementedError('addEventHandler() has not been implemented.');
  }
  void setbadge(){
    throw UnimplementedError('setbadge() has not been implemented.');
  }
}
