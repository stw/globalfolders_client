$:.unshift File.dirname(__FILE__)
require "spec_helper"

describe "User interaction" do
  before(:each) do
    setup_client
  end
  
  # authorize
  it "authorizes correctly" do
    user = GlobalfoldersClient::User.find(1)
    user.first_name.should == "Steve"
  end
  
  # index
  it "does not allow a list of users" do
    GlobalfoldersClient::User.all.should == nil
  end
  
  # show
  it "finds the correct user" do 
    user = GlobalfoldersClient::User.find(1)
    user.email.should == "swalker@walkertek.com"
  end
  
  # create
  it "does not allow creating a user" do 
    lambda { GlobalfoldersClient::User.create(:first_name => "Steve", :last_name => "Walker", :email => "steve@walkertek.com", :password => 'test01', :password_confirmation => 'test01') }.should raise_error(ActiveResource::ResourceNotFound)
  end

  # update
  it "allows the updating of a user" do
    user = GlobalfoldersClient::User.find(1)
    user.first_name = "Mike"
    user.first_name.should == "Mike"
    user.first_name = "Steve"
    user.save
    user.first_name.should == "Steve"
  end

  # destroy
  it "does not allow the removal of a user" do
    user = GlobalfoldersClient::User.find(1)
    lambda { user.destroy }.should raise_error(ActiveResource::ResourceNotFound)
  end
end
