
import 'bdpush_platform_interface.dart';

class Bdpush {
  Future<String?> getPlatformVersion() {
    return BdpushPlatform.instance.getPlatformVersion();
  }

  Future<bool?> initSdk(Map<String, String> param){
    return BdpushPlatform.instance.initSdk(param);
  }
}
