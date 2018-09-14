Pod::Spec.new do |s|
  s.name         = "ZBPopMenuView"
  s.version      = "0.0.1"
  s.summary      = "气泡弹出框式的菜单列表"
  s.description  = "气泡弹出框式的菜单列表"
  s.homepage     = "https://github.com/zhangzhibinhi/ZBPopMenuView"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author    = "zhangzb"
  s.platform     = :ios
  s.source       = { :git => "https://github.com/zhangzhibinhi/ZBPopMenuView.git", :commit => "2c01547" }
  s.source_files  = "PopMenuView/PopMenuView/*.{h,m,xib}"
end
