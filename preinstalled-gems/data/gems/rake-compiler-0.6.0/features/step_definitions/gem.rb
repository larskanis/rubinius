Given /^a gem named '(.*)'$/ do |gem_name|
  generate_gem_task gem_name
end

Then /^ruby gem for '(.*)' version '(.*)' do exist in '(.*)'$/ do |name, version, folder|
  File.exist?(gem_file(folder, name, version)).should be_true
end

Then /^binary gem for '(.*)' version '(.*)' do exist in '(.*)'$/ do |name, version, folder|
  File.exist?(gem_file_platform(folder, name, version)).should be_true
end

Then /^a gem for '(.*)' version '(.*)' platform '(.*)' do exist in '(.*)'$/ do |name, version, platform, folder|
  File.exist?(gem_file_platform(folder, name, version, platform)).should be_true
end

Then /^gem for platform '(.*)' get generated$/ do |platform|
  Then "a gem for 'gem_abc' version '0.1.0' platform '#{platform}' do exist in 'pkg'"
end

def gem_file(folder, name, version)
  "#{folder}/#{name}-#{version}.gem"
end

def gem_file_platform(folder, name, version, platform = nil)
  file = "#{folder}/#{name}-#{version}"
  file << "-" << (platform || Gem::Platform.new(RUBY_PLATFORM).to_s)
  file << ".gem"
  file
end
