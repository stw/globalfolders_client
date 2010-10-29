$:.unshift File.dirname(__FILE__)
require "spec_helper"

describe "Folder Interaction" do 
  before(:each) do
    setup_client
  end

  # show
  it "finds the correct folder" do 
    folder = GlobalfoldersClient::Folder.find(1)
    folder.name.should == "WalkerTek"
    folder.parent_id.should == nil
  end
  
  # index
  it "returns a list of folders" do
    folders = GlobalfoldersClient::Folder.find(:all, :params => { :folder => { :account_id => 1 }})
    folders.count.should > 0
  end
  
  # updated since
  it "shows all files updated since date" do
    folders = GlobalfoldersClient::Folder.find(:all, :from => :updated_since, :params => { :date => '2010-04-10 12:00:00 -4:00' })
    folders.count.should > 0
  end

  # update
   it "allows the updating of a folder" do
     folder = GlobalfoldersClient::Folder.find(1)
     folder.name = "WalkerTek Update"
     folder.save.should == true
     folder.name.should == "WalkerTek Update"
     folder.name = "WalkerTek"
     folder.save.should == true
     folder.name.should == "WalkerTek"
   end
  
   # create
   it "allows the creation of a folder" do 
     folders = GlobalfoldersClient::Folder.find(:all, :params => { :folder => { :account_id => 1 }})
     folder = GlobalfoldersClient::Folder.create(:account_id => 1, :name => "API Folder", :parent_id => folders.first.id)
     folder.name.should == "API Folder"
     folder.parent_id.should == folders.first.id
   end
  
   # destroy
   it "allows the removal of a folder" do
     folders = GlobalfoldersClient::Folder.find(:all, :params => { :folder => { :account_id => 1 }})
     folder = GlobalfoldersClient::Folder.create(:account_id => 1, :name => "API Folder", :parent_id => folders.first.id)
     folder.destroy.class.should == Net::HTTPOK
   end
end

