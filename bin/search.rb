#!/usr/bin/ruby -w 

require File.join(File.dirname(__FILE__), '../lib/globalfolders_client')

begin 
  GlobalfoldersClient::Client.load(File.join(File.dirname(__FILE__), "config.yml"))
  
  docs = GlobalFolders::Search.get(:index, { :account_id => 1, :query => 'rails' })
  puts "Docs: #{docs.inspect}"
  docs.each do |d|
    puts "Doc: #{d.title}"
  end
rescue Exception => e
  puts "Error: #{e.message}"
end