#
# Be sure to run `pod lib lint ABToolKit.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ABToolKit"
  s.version          = "0.1.0"
  s.summary          = "A short description of ABToolKit."
  s.description      = <<-DESC
                       An optional longer description of ABToolKit

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/a1exb1/ABToolKit-pod"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Alex Bechmann" => "alex_bechmann@hotmail.com" }
  s.source           = { :git => "https://github.com/a1exb1/ABToolKit-pod.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
   'ABToolKit' => ['Pod/Assets/*.*']
  }

#s.

# s.resource_bundle = {
#   'ABToolKitAssets' => [
#       'Pod/Assets/encryptor_compressor.txt',
#       'Assets/encryptor_compressor.txt'
#   ]
#}
# s.resource = "ABToolKitResources.bundle"

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  #
    s.dependency 'Alamofire', '~> 1.2.1'
    s.dependency 'SwiftyJSON', '~> 2.2.0'
    s.dependency 'SwiftyUserDefaults', '~> 1.2.0'

# s. prefix_header_contents = "import Alamofire import SwiftyJSON"
end
