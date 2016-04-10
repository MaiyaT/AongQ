

Pod::Spec.new do |s|


s.name         = "TAAongQ"
s.version      = "1.1.1"
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


s.source       = { :git => "https://github.com/MaiyaT/AongQ.git", :tag => "0.0.1" }



s.source_files  = "TAAongQ/**/*.{h,m}"

s.exclude_files = "Classes/Exclude"
s.frameworks = 'Foundation', 'UIKit'



# ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#
#  Link your library with frameworks, or libraries. Libraries do not include
#  the lib prefix of their name.
#

# s.framework  = "SomeFramework"
# s.frameworks = "SomeFramework", "AnotherFramework"

# s.library   = "iconv"
# s.libraries = "iconv", "xml2"


# ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#
#  If your library depends on compiler flags you can set them in the xcconfig hash
#  where they will only apply to your library. If you depend on other Podspecs
#  you can include multiple dependencies to ensure it works.

# s.requires_arc = true

# s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
# s.dependency "JSONKit", "~> 1.4"

end
