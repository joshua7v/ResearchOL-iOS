platform :ios, '8.0'
inhibit_all_warnings!

pod 'AMSmoothAlert', '~> 1.1'
pod 'M13Checkbox', '~> 1.1.2'
pod 'SDWebImage', '~> 3.7.2'
pod 'AVOSCloud'
pod 'Toast', '~> 2.4'
pod 'MJRefresh', '~> 1.4.5'
pod 'MJExtension', '~> 1.0.0'
pod 'Firebase', '~> 2.2.1'
pod 'Masonry', '~> 0.6.1'
pod 'AFNetworking', '~> 2.2.0'
pod 'NYXImagesKit', '~> 2.3'
pod 'FXKeychain', '~> 1.5'
pod 'MBProgressHUD', '~> 0.8'

link_with 'ResearchOL', 'ResearchOLTests'

post_install do |installer_representation|
    installer_representation.project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ARCHS'] = 'armv7 arm64'
        end
    end
end
