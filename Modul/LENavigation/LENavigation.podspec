#
# Be sure to run `pod lib lint LENavigation.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'LENavigation'
s.version          = '0.0.1'
s.summary          = 'LENavigation是个人私有库.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
TODO: Add long description of the pod here.
DESC

s.homepage         = 'http://192.168.1.117:8099/r/LENavigation.git'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'LE' => '551998132@qq.com' }
s.source           = { :git => 'http://192.168.1.117:8099/r/LENavigation.git', :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '8.0'

s.source_files = '**/*.{h,m}'

#s.resource_bundles = {
#    'LENavigation' => ['LENavigationImage/*.png']
#}
s.resource = "LENavigationImage.bundle"

#s.ios.preserve_paths = 'AlicloudUtils.framework','CloudPushSDK.framework','UTDID.framework','UTMini.framework'
#s.ios.public_header_files = 'AlicloudUtils.framework/Headers/*.h','CloudPushSDK.framework/Headers/*.h','UTDID.framework/Headers/*.h','UTMini.framework/Headers/*.h'
#s.ios.vendored_frameworks = 'AlicloudUtils.framework','CloudPushSDK.framework','UTDID.framework','UTMini.framework'

#s.resource_bundles = {
#    'VersionAlertView' => ['VersionAlertView/image.bundle']
#}

# s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'UIKit', 'MapKit'
s.frameworks = 'UIKit', 'Foundation'
#s.libraries = 'libz.tbd','libresolv.tbd','libsqlite3.tbd'
#s.library = 'z','resolv','sqlite3'
# s.dependency 'AFNetworking', '~> 3.1.0'
# s.dependency 'LECategorys', '~> 0.0.4'
end
