require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-tref-paint-code"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  Library implements a general approach for using PaintCode generated files from React Native on both iOS and Android platforms.
                   DESC
  s.homepage     = "https://github.com/ReferenceArmada/react-native-tref-paint-code"
  s.license      = "MIT"
  s.authors      = { "The Reference Armada" => "armada@reference.be" }
  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/ReferenceArmada/react-native-tref-paint-code.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,swift}"
  s.requires_arc = true

  s.dependency "React"
end

