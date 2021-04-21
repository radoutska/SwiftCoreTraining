# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'
deployment_target = '13.0'

install! 'cocoapods', :disable_input_output_paths => true, :warn_for_unused_master_specs_repo => false

use_frameworks!
inhibit_all_warnings!

# https://github.com/strongself/Generamba/wiki/Rambafile-Structure
# https://github.com/strongself/Generamba

workspace 'SwiftCoreTraining'

project 'SwiftCoreTraining'

def development_pods
  
  use_frameworks!
  inhibit_all_warnings!
  
  # UI
  pod 'Eureka', '~> 5.3.3'
  pod 'SnapKit', '~> 5.0.1'
  pod 'SVProgressHUD', '~> 2.2.5'
  
  # Networking
  pod 'Kingfisher', '~> 6.2.1'
  
  # Social auth - Facebook
  pod 'FBSDKCoreKit', '~> 9.2.0'
  pod 'FBSDKLoginKit', '~> 9.2.0'
  pod 'FBSDKShareKit', '~> 9.2.0'
  
  # Database
  pod 'RealmSwift', '~> 10.7.2'
  
end

abstract_target 'App' do
  
  target 'SwiftCoreTraining' do
    
    project 'SwiftCoreTraining'
    development_pods
    
  end
  
  target 'SwiftCoreTrainingTests' do
    
    project 'SwiftCoreTraining'
    development_pods
    
  end
  
  target 'SwiftCoreTrainingUITests' do
    
    project 'SwiftCoreTraining'
    development_pods
    
  end
  
end

post_install do |installer|
  
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO' # set 'NO' to disable DSYM uploading - usefull for third-party error logging SDK (like Firebase)
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      if config.name == 'Debug' || config.name == 'Debug-MockAPI'
        config.build_settings['OTHER_SWIFT_FLAGS'] = ['$(inherited)', '-Onone']
        config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
      end
    end
  end
  
  installer.generated_projects.each do |project|
    project.build_configurations.each do |bc|
      bc.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
    end
  end
  
end
