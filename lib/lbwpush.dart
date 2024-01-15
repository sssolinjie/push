
import 'lbwpush_method_channel.dart';
import 'lbwpush_platform_interface.dart';

class Lbwpush {
  Future<String?> getPlatformVersion() {
    return LbwpushPlatform.instance.getPlatformVersion();
  }

  Future<String?> getPushUid() {
    return LbwpushPlatform.instance.getPushUid();
  }

  Future<void> startPushService() {
    return LbwpushPlatform.instance.startPushService();
  }

  Future<void> initsdk(Map<String, String> param) {
    return LbwpushPlatform.instance.initsdk(param);
  }
//===============================别名===============================
  Future<bool?> setAlias(String alias) {
    return LbwpushPlatform.instance.setAlias(alias);
  }
  Future<String?> getAlias() {
    return LbwpushPlatform.instance.getAlias();
  }
  Future<bool?> deleteAlias() {
    return LbwpushPlatform.instance.deleteAlias();
  }
//=============================标签=================================
  Future<bool?> addTags(List<String> list) {
    return LbwpushPlatform.instance.addTags(list);
  }

  Future<bool?> deleteTags(List<String> list) {
    return LbwpushPlatform.instance.deleteTags(list);
  }

  Future<bool?> updateTags(List<String> list) {
    return LbwpushPlatform.instance.updateTags(list);
  }
  Future<bool?> cleanTags() {
    return LbwpushPlatform.instance.cleanTags();
  }
  Future<String?> getAllTags() {
    return LbwpushPlatform.instance.getAllTags();
  }

  Future<bool?> isTagBinding(String tag) {
    return LbwpushPlatform.instance.isTagBinding(tag);
  }
  
  ///===============权限相关==========================
  Future<bool?> areNotificationsEnabled() {
    return LbwpushPlatform.instance.areNotificationsEnabled();
  }
  Future<bool?> showNotificationGuide() {
    return LbwpushPlatform.instance.showNotificationGuide();
  }


  
  void addEventHandler(Function call){
    return LbwpushPlatform.instance.addEventHandler(call);
  }

  void setbadge(){
    return LbwpushPlatform.instance.setbadge();
  }
  
}
