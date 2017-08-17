#!/usr/bin/env ruby

require 'xcodeproj'

system "swift package generate-xcodeproj"

project = Xcodeproj::Project.open('Dependencies.xcodeproj')

project.targets.each do |target|
  module_map_file = "Dependencies.xcodeproj/GeneratedModuleMap/#{target.name}/module.modulemap"

  target.build_configurations.each do |config|
    config.build_settings['DEFINES_MODULE'] = 'YES'
    config.build_settings['SDKROOT'] = 'iphoneos'

    # Remove this line if you prefer to link the dependencies dynamically
    # You will also need to embed the framework with the app bundle
    config.build_settings['MACH_O_TYPE'] = 'staticlib'

    # Set MODULEMAP_FILE for non-Swift Frameworks
    #
    # Module maps are correctly generated for non-Swift frameworks, but SPM
    # doesn't put the path in the build config output from generate-xcodeproj.
    if File.exist? module_map_file
      config.build_settings['MODULEMAP_FILE'] = "${SRCROOT}/#{module_map_file}"
    end
  end
end

project.save
