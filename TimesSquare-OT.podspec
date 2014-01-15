
version = '2.0.12'

Pod::Spec.new do |s|
  s.name         = "TimesSquare-OT"
  s.version      = version
  s.summary      = "TimesSquare is an Objective-C calendar view for your apps."
  s.homepage     = "https://github.com/square/objc-TimesSquare"
  s.license      = 'Apache License, Version 2.0'
  s.author       = { "Square" => "http://squareup.com" }
  s.source       = { :git => "https://github.com/opentable/objc-TimesSquare.git", :tag => "#{version}-OpenTable" }
  s.platform     = :ios, '5.0'
  s.source_files = 'TimesSquare/*.{h,m}'
  s.requires_arc = true
  s.header_dir = 'TimesSquare'
end
