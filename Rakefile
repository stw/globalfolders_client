require 'bundler'
Bundler.setup

require 'rake'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

desc 'Default: run specs.'
task :default => [:clean, :spec]

desc 'Clean up files.'
task :clean do |t|
  FileUtils.rm_rf "doc"
  FileUtils.rm_rf "tmp"
  FileUtils.rm_rf "pkg"
  FileUtils.rm "test/test.log" rescue nil
  Dir.glob("globalfolders_client-*.gem").each{|f| FileUtils.rm f }
end

gemspec = eval(File.read("globalfolders_client.gemspec"))

task :gem   => "#{gemspec.full_name}.gem"
task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["globalfolders_client.gemspec"] do
  system "gem build globalfolders_client.gemspec"
  system "gem install globalfolders_client-#{GlobalfoldersClient::VERSION}.gem"
end
