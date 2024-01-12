import 'package:flutter_test/flutter_test.dart';
import 'package:bdpush/bdpush.dart';
import 'package:bdpush/bdpush_platform_interface.dart';
import 'package:bdpush/bdpush_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBdpushPlatform
    with MockPlatformInterfaceMixin
    implements BdpushPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final BdpushPlatform initialPlatform = BdpushPlatform.instance;

  test('$MethodChannelBdpush is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBdpush>());
  });

  test('getPlatformVersion', () async {
    Bdpush bdpushPlugin = Bdpush();
    MockBdpushPlatform fakePlatform = MockBdpushPlatform();
    BdpushPlatform.instance = fakePlatform;

    expect(await bdpushPlugin.getPlatformVersion(), '42');
  });
}
