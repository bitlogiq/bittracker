# Gemfile
# This ensures CI installs the right Ruby gems for iOS builds

source "https://rubygems.org"

# Require at least Ruby 3.2 (the GitHub macOS runners use 3.2+)
ruby ">= 3.2.0"

# Fastlane for build & TestFlight upload
gem "fastlane", "~> 2.228"

# CocoaPods for iOS dependencies
gem "cocoapods", "~> 1.16"

# xcbeautify to make xcodebuild logs easier to read in CI
gem "xcbeautify", "~> 2.30"

# Optional: pin Bundler version so it matches workflow step
gem "bundler", "~> 2.4"
