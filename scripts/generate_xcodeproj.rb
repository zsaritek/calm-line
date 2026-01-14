#!/usr/bin/env ruby
# frozen_string_literal: true

require "xcodeproj"
require "pathname"

PROJECT_NAME = "Calm-Line"
SRC_ROOT = "Calm-Line"

project_path = "#{PROJECT_NAME}.xcodeproj"

FileUtils.rm_rf(project_path) if Dir.exist?(project_path)
project = Xcodeproj::Project.new(project_path)

# Groups
root_group = project.main_group
src_group = root_group.new_group(SRC_ROOT, SRC_ROOT)

%w[App Models Services ViewModels Views].each do |name|
  src_group.new_group(name, name)
end

assets_group = src_group.new_group("Assets.xcassets", "Assets.xcassets")
assets_group.new_reference("Contents.json")
appicon_group = assets_group.new_group("AppIcon.appiconset", "AppIcon.appiconset")
appicon_group.new_reference("Contents.json")

# Target
target = project.new_target(:application, PROJECT_NAME, :ios, "17.0")
target.build_configurations.each do |config|
  config.build_settings["SWIFT_VERSION"] = "5.0"
  config.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = "17.0"
  config.build_settings["PRODUCT_BUNDLE_IDENTIFIER"] = "com.zsaritek.calmline"
  config.build_settings["PRODUCT_MODULE_NAME"] = "CalmLine"
  config.build_settings["DEVELOPMENT_TEAM"] = ""
  config.build_settings["CURRENT_PROJECT_VERSION"] = "1"
  config.build_settings["MARKETING_VERSION"] = "1.0"
  config.build_settings["GENERATE_INFOPLIST_FILE"] = "YES"
  config.build_settings["INFOPLIST_KEY_CFBundleDisplayName"] = "Calm-Line"
  config.build_settings["INFOPLIST_KEY_UIApplicationSceneManifest_Generation"] = "YES"
  config.build_settings["ASSETCATALOG_COMPILER_APPICON_NAME"] = "AppIcon"
  config.build_settings["TARGETED_DEVICE_FAMILY"] = "1"
end

def add_swift_sources(project, target, group, relative_dir)
  Dir.glob(File.join(relative_dir, "**/*.swift")).sort.each do |path|
    rel = Pathname.new(path).relative_path_from(Pathname.new(relative_dir)).to_s
    file_ref = group.new_reference(rel)
    target.add_file_references([file_ref])
  end
end

# Wire sources
app_group = src_group.children.find { |g| g.display_name == "App" }
models_group = src_group.children.find { |g| g.display_name == "Models" }
views_group = src_group.children.find { |g| g.display_name == "Views" }

add_swift_sources(project, target, app_group, "#{SRC_ROOT}/App")
add_swift_sources(project, target, models_group, "#{SRC_ROOT}/Models")
add_swift_sources(project, target, views_group, "#{SRC_ROOT}/Views")

# Resources (assets)
resources_phase = target.resources_build_phase
assets_ref = src_group.new_reference("Assets.xcassets")
resources_phase.add_file_reference(assets_ref, true)

project.save

puts "Generated #{project_path}"


