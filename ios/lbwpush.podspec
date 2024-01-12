#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint lbwpush.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'lbwpush'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'
  s.ios.vendored_frameworks = 'Frameworks/SPSDK.framework','Frameworks/SPSDKGeo.framework','Frameworks/SPSDKMessage.framework','Frameworks/Protobuf.framework'
  s.vendored_frameworks = 'SPSDK.framework','SPSDKGeo.framework','SPSDKMessage.framework','Protobuf.framework'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
