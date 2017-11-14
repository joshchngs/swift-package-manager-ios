# Swift Package Manager with iOS

This project demonstrates a working method for using Swift Package Manager to manage the dependencies of an iOS project. It was developed on Xcode 9.1, using Swift 4 and the SPM v4 description format.

**To get started:

1. `ruby generate-project-dependencies.rb`.** This will pull down dependencies and create a _Dependencies_ project that is included as a sub-project in the example project.

2. **Open `SwiftPackagesWithiOS.xcodeproj` in Xcode**

3. **Build the main target** (you may need to manually build the target for the _Dependencies_ sub-project).

This will build a simple app that depends on [RxSwift](https://github.com/ReactiveX/RxSwift). RxSwift was chosen because it shows how to handle modules generated from Objective-C.

The end result will be a standard iOS application, with Static Frameworks for each of its dependencies embedded within the bundle.

You can link the dependencies dynamically if you prefer, by removing the `config.build_settings['MACH_O_TYPE'] = 'staticlib'` line in `generate-project-dependencies.rb`. If you do this **you will need to add the `Dependencies` framework to your main target**.

You can step through the commits to see what steps were taken, with a brief overview of the process below.

## Process

_(The process hasn't been tried with Xcode 8.3 & Swift 3.1)_

1. Generate iOS App project with Xcode
2. Generate swift package for Dependencies
3. Create dummy source file for Dependencies (I've chosen to put this in `.deps-sources` but does not necessarily need to be hidden)
4. Override build settings in generated xcodeproj (this is done in `generate-project-dependencies.rb`)
5. Add Dependencies.xcodeproj as subproject of the main app xcodeproj
6. Add a dependency (to RxSwift in this example) in Package.swift
7. Link our App with the new Rx*.frameworks
8. Write some sample code to verify that the import works
9. Override MODULEMAP_FILE setting for non-Swift modules

