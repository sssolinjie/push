import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'bdpush_method_channel.dart';

abstract class BdpushPlatform extends PlatformInterface {
  /// Constructs a BdpushPlatform.
  BdpushPlatform() : super(token: _token);

  static final Object _token = Object();

  static BdpushPlatform _instance = MethodChannelBdpush();

  /// The default instance of [BdpushPlatform] to use.
  ///
  /// Defaults to [MethodChannelBdpush].
  static BdpushPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BdpushPlatform] when
  /// they register themselves.
  static set instance(BdpushPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> initSdk(Map<String, String> param) {
    throw UnimplementedError('initSdk() has not been implemented.');
  }
  
}
