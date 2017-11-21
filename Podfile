platform :ios, '9.0'

target 'SmartAlumni' do
    use_frameworks!
    pod 'PhoneNumberKit'
    pod 'IQKeyboardManagerSwift’
    pod 'Alamofire', '~> 4.5'
    pod 'SwiftyJSON'
    pod 'RealmSwift'
    pod 'Locksmith'
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

