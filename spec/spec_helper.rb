require "bundler"
Bundler.setup

require "rspec"
require "globalfolders_client"
require "support/matchers"

Rspec.configure do |config|
    config.include GlobalfoldersClient::Spec::Matchers
end

def setup_client
  GlobalfoldersClient::Client.load(File.join(File.dirname(__FILE__), "config.yml"))
end