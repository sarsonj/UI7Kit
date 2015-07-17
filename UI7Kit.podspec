Pod::Spec.new do |s|
  s.name         = "UI7Kit"
  s.version      = "0.9.22"
  s.summary      = "UI7Kit is a GUI toolkit to implement iOS7 look & feel UIKit under iOS5/iOS6. It is also supported that patching UIKit to UI7Kit in runtime."
  s.homepage     = "https://github.com/youknowone/UI7Kit"
  s.license      = "2-clause BSD"
  s.author       = { "Jeong YunWon" => "jeong@youknowone.org" }
  s.source       = { :git => "https://github.com/youknowone/UI7Kit.git", :tag => "0.9.22" }
  s.requires_arc = false
  s.screenshots  = "https://github.com/youknowone/UI7Kit/raw/master/UI7Kit.png"
  s.platform     = :ios, '5.0'
  s.header_dir = "UI7Kit"

  s.source_files = 'UI7Kit/*.{h,m}'
  s.resources = 'Resources/*'
  s.framework = 'QuartzCore'

  s.prefix_header_file     = 'UI7Kit/UI7Kit-Prefix.pch'
  s.prefix_header_contents = '
#include <cdebug/debug.h>
#include <UIKitExtension/UIKitExtension.h>
#include <UI7Kit/UI7Kit.h>
    '
  s.dependency 'cdebug'
  s.dependency 'FoundationExtension'
  s.dependency 'SevenSwitch', '~> 1.3.0'
  s.dependency 'GIKPopoverBackgroundView/Core'
end
