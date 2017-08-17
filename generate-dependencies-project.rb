#!/usr/bin/env ruby

require 'xcodeproj'

system "swift package generate-xcodeproj"

project = Xcodeproj::Project.open('Dependencies.xcodeproj')

project.targets.each do |target|
  target.build_configurations.each do |config|
    config.build_settings['DEFINES_MODULE'] = 'YES'
    config.build_settings['SDKROOT'] = 'iphoneos'

    # Remove this line if you prefer to link the dependencies dynamically
    # You will also need to embed the framework with the app bundle
    config.build_settings['MACH_O_TYPE'] = 'staticlib'
  end
end

project.save
