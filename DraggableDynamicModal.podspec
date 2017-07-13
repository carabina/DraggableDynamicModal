#
# Be sure to run `pod lib lint DraggableDynamicModal.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DraggableDynamicModal'
  s.version          = '0.2.0'
  s.summary          = 'This library allows to facilitate the display of a view controller as modal with great animation and user interaction.
                         You can easily change the child in this modal as well as the size.

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/ali59a/DraggableDynamicModal'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ali59a' => 'aabbas90@gmail.com' }
  s.source           = { :git => 'https://github.com/ali59a/DraggableDynamicModal.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'DraggableDynamicModal/Classes/**/*.{Swift}'

   s.resource_bundles = {
     'DraggableDynamicModal' => ['DraggableDynamicModal/Classes/*.{storyboard}']
   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'ZFDragableModalTransition'
end
