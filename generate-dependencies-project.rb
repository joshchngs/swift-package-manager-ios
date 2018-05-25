#!/usr/bin/env ruby

require 'xcodeproj'

system "swift package generate-xcodeproj"

project = Xcodeproj::Project.open('Dependencies.xcodeproj')

# You will also need to edit the root project name
root_project = Xcodeproj::Project.open('SwiftPackagesWithiOS.xcodeproj')

# Adding the following build configuration from parent project to Dependencies.
# If you are using multiple configurations for example `Beta` or `Staging`
# Your Frameworks will be placed under correct Product build configuration 
# /Build/Products/Staging-iphonesimulator/App.app/Frameworks
build_configs = root_project.build_configurations.reject { |bc| bc.name == 'Debug' || bc.name == 'Release' }
build_configs.each do |cf|
    if project.build_configurations.find { |bc| bc.name == cf.name && bc.type == cf.type }
      puts "Build configuration #{cf.name} already exists in #{File.basename(project.path)}"
    else
      puts "Adding the following build configuration to #{File.basename(project.path)}: #{cf.name}(#{cf.type})"
      project.add_build_configuration(cf.name, cf.type)
    end
end

project.targets.each do |target|
  module_map_file = "Dependencies.xcodeproj/GeneratedModuleMap/#{target.name}/module.modulemap"

  target.build_configurations.each do |config|
    config.build_settings['DEFINES_MODULE'] = 'YES'
    config.build_settings['SDKROOT'] = 'iphoneos'

    # Remove this line if you prefer to link the dependencies dynamically
    # You will also need to embed the framework with the app bundle
    config.build_settings['MACH_O_TYPE'] = 'staticlib'

    # Remove this line if you prefer to
    # Add platfor support
    config.build_settings['SUPPORTED_PLATFORMS'] = 'macosx iphoneos iphonesimulator appletvos appletvsimulator watchos watchsimulator'

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
