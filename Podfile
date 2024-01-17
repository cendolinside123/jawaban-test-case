# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Case Bank' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Case Bank
  pod 'DGCharts'
  pod 'Alamofire'
#  pod 'ZXingObjC', '~> 3.6.4'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'PKHUD'
  
  target 'Case Bank Tests' do
    inherit! :search_paths
    use_frameworks!
  end

  post_install do |installer|
      installer.pods_project.build_configurations.each do |config|
          config.build_settings['GCC_OPTIMIZATION_LEVEL'] = '1'
          config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-O'
          config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
          
      end
      installer.pods_project.targets.each do |target|
        if target.respond_to?(:product_type) and target.product_type == "com.apple.product-type.bundle"
          target.build_configurations.each do |config|
              config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
              config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
              config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
          end
        end
      end
      installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
        end
      end

    end

end
