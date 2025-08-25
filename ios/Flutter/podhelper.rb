# ios/Flutter/podhelper.rb

def find_flutter_root_from_env
  env_root = ENV['FLUTTER_ROOT']
  return nil unless env_root && !env_root.empty?
  candidate = File.expand_path(File.join(env_root, 'packages', 'flutter_tools', 'bin', 'podhelper'))
  File.exist?(candidate) ? env_root : nil
end

def find_flutter_root_from_generated
  generated = File.expand_path(File.join('..', 'Flutter', 'Generated.xcconfig'), __dir__)
  return nil unless File.exist?(generated)

  root = nil
  File.foreach(generated) do |line|
    m = line.match(/FLUTTER_ROOT\=(.*)/)
    if m
      root = m[1].strip
      break
    end
  end
  return nil unless root

  # Normalize Windows path for macOS/Linux
  root = root.gsub('\\', '/')
  root = root.sub(/^[A-Za-z]:\//, '/')

  candidate = File.expand_path(File.join(root, 'packages', 'flutter_tools', 'bin', 'podhelper'))
  File.exist?(candidate) ? root : nil
end

def flutter_root
  from_env = find_flutter_root_from_env
  return from_env if from_env

  from_generated = find_flutter_root_from_generated
  return from_generated if from_generated

  raise 'Unable to locate FLUTTER_ROOT. Ensure Flutter is installed in the workflow (sets FLUTTER_ROOT) and that "flutter pub get" ran before pod install.'
end

require File.expand_path(File.join('packages', 'flutter_tools', 'bin', 'podhelper'), flutter_root)
