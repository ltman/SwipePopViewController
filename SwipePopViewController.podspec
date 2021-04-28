#
# Be sure to run `pod lib lint SwipePopViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwipePopViewController'
  s.version          = '0.3.1'
  s.summary          = 'Swipe right to pop the current View Controller'
  s.description      = 'Swipe right anywhere in View Controller to pop it out!'

  s.homepage         = 'https://github.com/ltman/SwipePopViewController'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chalermpong' => 's_pong_c@hotmail.com' }
  s.source           = { :git => 'https://github.com/ltman/SwipePopViewController.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.swift_versions = '5.0'

  s.source_files = 'Sources/SwipePopViewController/**/*'
end
