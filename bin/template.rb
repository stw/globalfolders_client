#!/usr/bin/ruby -w 

$:.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
require "globalfolders_client"

begin 
  GlobalfoldersClient::Client.load(File.join(File.dirname(__FILE__), "config.yml"))
  
  doc = GlobalfoldersClient::Document.find(1)
  puts doc.inspect

  puts
  puts doc.current_url
  
rescue Exception => e
  puts "Error: #{e.message}"
end
