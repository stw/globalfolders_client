#!/usr/bin/ruby -w 

$:.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
require "globalfolders_client"

begin 
  GlobalfoldersClient::Client.load_config( File.join( File.dirname(__FILE__), "config.yml") )
  
  doc = GlobalfoldersClient::Document.find(1)
  puts doc.inspect

  user = GlobalfoldersClient::User.find(1)
  puts
  puts doc.url(user)
  
rescue Exception => e
  puts "Error: #{e.message}"
end
