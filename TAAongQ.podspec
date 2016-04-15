

Pod::Spec.new do |s|

s.name         = "TAAongQ"
s.version      = "1.2.0"
s.summary      = "TAAongQ."
s.description  = <<-DESC
                    AongQ等一些软件的公用文件，基类，自定义的视图
                DESC
s.homepage     = "https://github.com/MaiyaT/AongQ"
s.license      = "MIT"
# s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
s.author             = { "林宁宁" => "763465697@qq.com" }
s.platform     = :ios, "7.0"
s.requires_arc = true
s.source       = { :git => "https://github.com/MaiyaT/AongQ.git", :tag => s.version }
s.source_files  = "TAAongQ/**/*.{h,m}"
s.exclude_files = "Classes/Exclude"
s.frameworks = 'Foundation', 'UIKit'

end
