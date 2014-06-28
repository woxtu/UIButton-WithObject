Pod::Spec.new do |s|
  s.name         = 'UIButton+WithObject'
  s.version      = '0.0.1'
  s.summary      = 'A category that extends for adding target.'
  s.homepage     = 'https://github.com/woxtu/UIButton-WithObject'
  s.license      = { :type => 'MIT', :file => 'LICENSE-MIT' }
  s.author       = { 'woxtu' => 'woxtup@gmail.com' }
  s.source       = { :git => 'https://github.com/woxtu/UIButton-WithObject.git', :tag => '0.0.1' }
  s.source_files = 'UIButton+WithObject/UIButton+WithObject.{h,m}'
  s.platform = :ios, '5.0'
  s.requires_arc = true
  s.framework = 'UIKit'
end
