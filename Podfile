# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'
use_frameworks!
workspace 'LiteTwitter'

def reactive
    pod 'RxSwift',    '~> 4.0'
    pod 'RxCocoa',    '~> 4.0'
end

target 'LiteTwitter' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  pod 'Apollo'
  pod 'MBProgressHUD', '~> 1.1.0'
  pod 'IQKeyboardManager'
  pod 'AloeStackView'
  pod 'SwiftKeychainWrapper'
  pod 'ReachabilitySwift'
  reactive

  target 'LiteTwitterTests' do
    inherit! :search_paths
    pod 'RxBlocking', '~> 4.0'
    pod 'RxTest',     '~> 4.0'
  end

  target 'LiteTwitterUITests' do
    inherit! :search_paths
    # Pods for testing
  end
end

target 'Profile' do
    project 'Profile/Profile'
    reactive
end
