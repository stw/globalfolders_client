#!/usr/bin/ruby -w 

require File.join(File.dirname(__FILE__), '../lib/globalfolders_client')

GlobalfoldersClient::Client.load_config( File.join( File.dirname(__FILE__), "config.yml") )

user = GlobalfoldersClient::User.find(1)
puts "User: " + user.first_name + " " + user.last_name

accounts = GlobalfoldersClient::Account.find(:all, :params => { :user_id => user.id })
accounts.each do |a|
  puts "\tAccount: #{a.name}"
  folders = GlobalfoldersClient::Folder.find(:all, :params => { :folder => { :account_id => a.id }})

  folders.each do |f|
    puts "\t\tFolder: #{f.name}"

    files = GlobalfoldersClient::Document.find(:all, :params => { :document => { :folder_id => f.id }})
    files.each do |file|
      puts "\t\t\tFile: #{file.title}"
    end
  end
end
