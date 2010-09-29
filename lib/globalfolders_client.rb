require 'rubygems'
require 'active_resource'
require 'httpclient'
      
require 'globalfolders_client/version'

module GlobalfoldersClient

  class Client < ActiveResource::Base
    self.proxy    = ''
    self.timeout  = 5
    # self.format = :json
    
    def self.load_config(filename)
      begin 
        unless File.exists?(filename)
          raise "Config file #{filename} not found."
        end
        
        config = YAML.load_file(filename)
      
        self.site     = config["host"] || "https://www.globalfolders.com"
        self.user     = config["username"]
        self.password = config["password"]
      rescue Exception => e
        $stderr.puts "Error: #{e.message}"
      end
    end
  end 

  class User < Client 
  end 

  class Account < Client 
  end 
  
  class Folder < Client 
  end

  class Document < Client 
    attr_accessor :file, :api_key #, :api_method, :api
    
    # send file on create if we have :api_key and :file in the args
    def self.create(args)
      args["api"] = "1"
      args["api_method"] = "ruby"
      file    = args[:file]     && args.delete(:file)
      api_key = args[:api_key]  && args.delete(:api_key)
      obj = super(args)
      if (file && api_key)
        obj._upload(api_key, file)
      end
      obj
    end
    
    # send file on save if we have an api_key and file
    def save
      if (file && api_key)
        self._upload(api_key, file)
      end
      super
    end
    
    # the url is just /documents/ with the id appended
    def url(user)
      digest = Document.api_access_hash(id, user)
      "#{Client.site}/documents/#{id}?a=#{digest}&u=#{user.id}"
    end
    
    # posting a file requires the api_key and the file object
    def _upload(api_key, file)  
      url = Client.site + "/upload.json"
      params = { "api_key" => api_key, "api_method" => "ruby", "id" => id.to_s, "file" => file }
      resp = HTTPClient.post url, params 
      JSON.parse(resp.content)
    end    
  
    def self.api_access_hash(id, user)
      user ? Digest::SHA256.hexdigest(user.api_key + ":" + user.id.to_s + ":" + id.to_s) : false
    end
  end
  
  class Search < Client
    self.collection_name = "search"
  end

end
