platform :ios, '9.0'

target 'SmartAlumni' do
    use_frameworks!
    pod 'Fabric', '~> 1.7.2'
    pod 'Crashlytics', '~> 3.9.3'
    pod 'PhoneNumberKit'
    pod 'IQKeyboardManagerSwift’
    pod 'Alamofire', '~> 4.5'
    pod 'SwiftyJSON'
    pod 'RealmSwift'
    pod 'Locksmith'
    pod 'Firebase/Core'
    pod 'Firebase/Storage'
    pod 'PromiseKit', '~> 4.4'
    pod 'Kingfisher', '~> 4.0'
    pod 'Segmentio', :git => 'https://github.com/Yalantis/Segmentio.git' , :branch => 'master'
    pod 'SkyFloatingLabelTextField', '~> 3.0'
    pod 'SwiftValidator', :git => 'https://github.com/jpotts18/SwiftValidator.git', :branch => 'master'
    
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
        end
    end
end

