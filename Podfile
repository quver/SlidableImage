platform :ios, '8.0'

target 'SlidableImage' do
  use_frameworks!

  target 'SlidableImageTests' do
    inherit! :search_paths
    pod 'iOSSnapshotTestCase'
    pod 'Nimble'
    pod 'Quick'
  end


    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '4.2'
            end
        end
  end

end
