#!/usr/bin/ruby -w 

require File.join(File.dirname(__FILE__), '../lib/globalfolders_client')

GlobalfoldersClient::Client.load(File.join(File.dirname(__FILE__), "config.yml"))

user = GlobalFolders::User.find(1)
puts "User: " + user.first_name + " " + user.last_name

accounts = GlobalFolders::Account.find(:all, :params => { :user_id => user.id })
accounts.each do |a|
  puts "\tAccount: #{a.name}"
  folders = GlobalFolders::Folder.find(:all, :params => { :folder => { :account_id => a.id }})

  folders.each do |f|
    puts "\t\tFolder: #{f.name}"

    files = GlobalFolders::Document.find(:all, :params => { :document => { :folder_id => f.id }})
    files.each do |file|
      puts "\t\t\tFile: #{file.title}"
    end
  end
end
