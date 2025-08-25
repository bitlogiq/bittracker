# ios/Flutter/podhelper.rb

def find_flutter_root_from_env
  env_root = ENV['FLUTTER_ROOT']
  return nil unless env_root && !env_root.empty?
  candidate = File.expand_path(File.join(env_root, 'packages', 'flutter_tools', 'bin', 'podhelper'))
  File.exist?(candidate) ? env_root : nil
end

def find_flutter_root_from_generated
  # Standard Flutter template location
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

  # Normalize Windows-style paths for *nix (macOS/Linux) runners
  # Convert backslashes to forward slashes
  root = root.gsub('\\', '/')
  # Drop drive letter like C:/ if present (GitHub runners won't mount it the same way)
  root = root.sub(/^[A-Za-z]:\//, '/')

  candidate = File.expand_path(File.join(root, 'packages', 'flutter_tools', 'bin', 'podhelper'))
  File.exist?(candidate) ? root : nil
end

def flutter_root
  from_env = find_flutter_root_from_env
  return from_env if from_env

  from_generated = find_flutter_root_from_generated
  return from_generated if from_generated

  raise 'Unable to locate FLUTTER_ROOT. Ensure the runner installs Flutter (which sets FLUTTER_ROOT) or that ios/Flutter/Generated.xcconfig exists with a valid FLUTTER_ROOT. Make sure "flutter pub get" ran before pod install.'
end

require File.expand_path(File.join('packages', 'flutter_tools', 'bin', 'podhelper'), flutter_root)
