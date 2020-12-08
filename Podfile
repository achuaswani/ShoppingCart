# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'ShoppingCart' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ShoppingCart
    pod 'Firebase' 
    pod 'Firebase/Auth'
    pod 'Firebase/Analytics'
    pod 'Firebase/Database'
    pod 'Firebase/Crashlytics'
    pod 'SwiftLint'
    pod 'CodableFirebase'
    pod 'Firebase/Storage'

  target 'ShoppingCartTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ShoppingCartUITests' do
    # Pods for testing
  end

end
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |configuration|
        configuration.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
        configuration.build_settings.delete('ARCHS')
        configuration.build_settings['CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER'] = 'NO'
       end
   end
end
