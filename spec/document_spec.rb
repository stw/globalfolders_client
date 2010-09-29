$:.unshift File.dirname(__FILE__)
require "spec_helper"

describe "Document Interaction" do 
  before(:each) do
    setup_client
  end

  # show
  it "finds the correct document" do 
    document = GlobalfoldersClient::Document.find(7)
    document.title.should == "rails.png"
  end
  
  # index
  it "returns a list of documents" do
    docs = GlobalfoldersClient::Document.find(:all, :params => { :document => { :folder_id => 1 }})
    docs.count.should > 0
  end
  
  # update
  it "allows the updating of a document" do
    document = GlobalfoldersClient::Document.find(7)
    document.title = "WalkerTek Update"
    document.save.should == true
    document.title.should == "WalkerTek Update"
    document.title = "somefile"
    
    user = GlobalfoldersClient::User.find(1)
    api_key = user.api_key
    file = File.open(File.join(File.dirname(__FILE__), "upload_test.txt"))
    document.file = file
    #document.api_key = api_key
    #document.api = true
    document.api_method = "ruby"
    
    document.save.should == true
    document.title.should == "somefile"
  end

  # create
  it "allows the creation of a document" do 
    user = GlobalfoldersClient::User.find(1)
    api_key = user.api_key
    file = File.open(File.join(File.dirname(__FILE__), "upload_test.txt"))
    
    doc = GlobalfoldersClient::Document.create(:api_key => api_key, :file => file, :folder_id => 1, :file_name => "upload_test.txt", :title => "API Test", :description => "Test Description", :keywords => "Test Keywords")
    #doc.api = true
    #doc.api_method = "ruby"
    doc.title.should == "API Test"
    doc.description.should == "Test Description"
    doc.keywords.should == "Test Keywords"
    
    doc.save.should == true

    digest = Digest::SHA256.hexdigest(api_key + ":" + user.id.to_s + ":" + doc.id.to_s)
    
    #$stderr.puts "#{GlobalfoldersClient::Client.site}/documents/#{doc.id}?a=#{digest}&u=#{user.id}"
    #$stderr.puts
    
    doc.url(user).to_s.should == "#{GlobalfoldersClient::Client.site}/documents/#{doc.id}?a=#{digest}&u=#{user.id}"
    
    # doc.destroy.class.should == Net::HTTPOK
  end

  # destroy
  it "allows the removal of a document" do
    doc = GlobalfoldersClient::Document.create(:folder_id => 1, :title => "API Test", :file_name => "test.txt")
    doc.title.should == "API Test"
    doc.save.should == true
    doc.destroy.class.should == Net::HTTPOK
  end
end

