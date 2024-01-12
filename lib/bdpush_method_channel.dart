import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'bdpush_platform_interface.dart';

/// An implementation of [BdpushPlatform] that uses method channels.
class MethodChannelBdpush extends BdpushPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('bdpush');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool?> initSdk(Map<String, String> param) async {
    final version = await methodChannel.invokeMethod<bool>('initSdk', param);
    return version;
  }

}
